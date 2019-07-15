package com.semipject.board.post;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.codehaus.jackson.JsonParser;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import net.utility.UploadFileUtils;

@Component
public class PostDAO {

	@Autowired
	SqlSession sqlSession;

	public PostDAO() {
	}

	public int insertPost(PostDTO dto, MultipartHttpServletRequest mtfRequest) {
		PostMapper mapper = sqlSession.getMapper(PostMapper.class);	
		//유저 ID 설정해주기 나중에 고칠 럿
		
		//파일들을 list에 저장

		String title = dto.getTitle();
		String content = dto.getContent();
		String userid = dto.getUserid();

		System.out.println("/postinsert.do POST 요청됨");
		System.out.println("카테고리" + dto.getCategory());
		System.out.println("파일네임" + dto.getFile_names());
		System.out.println("컨텐츠" + dto.getContent());
		System.out.println("제목" + dto.getTitle());
		System.out.println("아이디" + dto.getUserid());
		title = title.replace("<", "&lt;");
		title = title.replace("<", "&gt;");
		
		userid = userid.replace("<", "&lt;");
		userid = userid.replace("<", "&gt;");
		// *공백문자 처리  
		title = title.replace("  ",	"&nbsp;&nbsp;");
		userid = userid.replace("  ",	"&nbsp;&nbsp;");
		// *줄바꿈 문자처리
		content = content.replace("\n", "<br>");
		dto.setTitle(title);
		dto.setContent(content);
		dto.setUserid(userid);
		
		// 게시물 등록
		/*// 게시물의 첨부파일 정보 등록
		JSONArray file_names = dto.getFile_names(); // 첨부파일 배열
		if(file_names == null) return ; // 첨부파일이 없으면 메서드 종료
		// 첨부파일들의 정보를 tbl_attach 테이블에 insert
		for(JSONObject file: file_names){ 
			boardDao.addAttach(name);
		}*/
		
		//업로드할 파일들을 리스트에 지정
		List<MultipartFile> fileList = mtfRequest.getFiles("file"); 
	    /*String src = mtfRequest.getParameter("src");
	    System.out.println("src value : " + src);
*/
		if (!fileList.isEmpty()) {				
	
	        String path = mtfRequest.getSession().getServletContext().getRealPath("/resources/files_updown/");
	        System.out.println("path = " + path);
	        //  String path = "C:\\image\\";
	    	String uploadedFileName = null;
	    	JSONArray file_namesArray = new JSONArray();
	
			for (MultipartFile mf : fileList) {
	            /*String originFileName = mf.getOriginalFilename(); // 원본 파일 명
	            long fileSize = mf.getSize(); // 파일 사이즈
	
	            System.out.println("originFileName : " + originFileName);
	            System.out.println("fileSize : " + fileSize);
	
	            String safeFile = path + System.currentTimeMillis() + originFileName;
	            try {
	                mf.transferTo(new File(safeFile));
	            } catch (IllegalStateException e) {
	                // TODO Auto-generated catch block
	                e.printStackTrace();
	            } catch (IOException e) {
	                // TODO Auto-generated catch block
	                e.printStackTrace();
	            }*/
				//원래 파일명
				JSONObject file = new JSONObject();
				file.put("originName", mf.getOriginalFilename()); 
	
				try {
					uploadedFileName=UploadFileUtils.uploadFile(path, mf.getOriginalFilename(), mf.getBytes());
					file.put("uplodedName",uploadedFileName);
					file_namesArray.add(file);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
	        }//파일들 저장하고 저장된 파일 네임 jsonarry에  저장하는 for end
			
			
			dto.setFile_names(file_namesArray.toString());
		}
		System.out.println(dto.getFile_names());
/*		
		String[] files =  dto.getFile_names();// 첨부파일 배열
		if(files != null) {
			
			for(String name : files){ 
			}
		}; // 첨부파일이 없으면 메서드 종료
		*/
		
		int result = mapper.insert(dto);
		return result;
	}

	//POST list 뽑아오기
	public ArrayList<PostDTO> postList(PostDTO dto) {

		PostMapper mapper = sqlSession.getMapper(PostMapper.class);	
		ArrayList<PostDTO> list = mapper.postList(dto);
		
		return list;
	}

	public ArrayList<PostDTO> searchlist(Map<String, String> data) {
		
		PostMapper mapper = sqlSession.getMapper(PostMapper.class);	
		ArrayList<PostDTO> list = mapper.searchlist(data);

		return list;
	}

	public PostDTO detail(PostDTO dto) {
		PostMapper mapper = sqlSession.getMapper(PostMapper.class);	
		PostDTO resultdto = mapper.detail(dto);

		return resultdto;
	}

	public int delete(PostDTO dto)throws Exception {
		PostMapper mapper = sqlSession.getMapper(PostMapper.class);	
		int deleteresult = mapper.delete(dto);
		
		return deleteresult;

	}

	public int deletefile(PostDTO dto, int idx, String filename) {
		
		PostMapper mapper = sqlSession.getMapper(PostMapper.class);	
		JSONArray file_namesArray = new JSONArray();
		Object newfile_namesArray = new JSONArray();
		JSONParser parser = new JSONParser();
		try {
			file_namesArray = (JSONArray) parser.parse(dto.getFile_names());
			
			System.out.println("file_namesArray = " +file_namesArray);
			newfile_namesArray = file_namesArray.remove(idx);
			System.out.println("file_namesArray remove idx 후 = " +file_namesArray);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("newfile_namesArray.toString = "+ newfile_namesArray);
		String file_names = file_namesArray.toString();
		System.out.println(filename);
		System.out.println(file_names);
		if (file_namesArray.size()==0) {
			file_names="";
		}
		dto.setFile_names(file_names);
		int deleteresult  = mapper.deletefile(dto);
		
		return deleteresult;
	}

	public int update(PostDTO dto) {

		PostMapper mapper = sqlSession.getMapper(PostMapper.class);	
		int result= mapper.update(dto);
		
		
		return result;
	}

	public int countListContent(String searchOption, String keyword) throws Exception {
		PostMapper mapper = sqlSession.getMapper(PostMapper.class);	
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		int result= mapper.countListContent(map);
		return result;
	}

	public List<PostDTO> listAll(int start, int end, String searchOption, String keyword) {
		PostMapper mapper = sqlSession.getMapper(PostMapper.class);	
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		List result= mapper.listAll(map);
		return result;
	}

}
