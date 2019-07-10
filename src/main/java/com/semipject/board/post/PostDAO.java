package com.semipject.board.post;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component
public class PostDAO {

	@Autowired
	SqlSession sqlSession;

	public PostDAO() {
	}

	public int insertPost(PostDTO dto, MultipartHttpServletRequest mtfRequest) {
		PostMapper mapper = sqlSession.getMapper(PostMapper.class);	
		//유저 ID 설정해주기 나중에 고칠 럿
		dto.setUserid("asdf");
		
		List<MultipartFile> fileList = mtfRequest.getFiles("file");
        String src = mtfRequest.getParameter("src");
        System.out.println("src value : " + src);

        String path = mtfRequest.getSession().getServletContext().getRealPath("/resources/files_updown/");
        System.out.println("path = " + path);
        
        String file_names = null;

        for (MultipartFile mf : fileList) {
            String originFileName = mf.getOriginalFilename(); // 원본 파일 명
            long fileSize = mf.getSize(); // 파일 사이즈
            
            System.out.println("originFileName"+ mf.getName() +" : " + originFileName);
            System.out.println("fileSize : " + fileSize);
            file_names += ","+ System.currentTimeMillis() + originFileName;
            

            String safeFile = path + System.currentTimeMillis() + originFileName;
            try {
                mf.transferTo(new File(safeFile));
            } catch (IllegalStateException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        
        if (file_names==null) {
			file_names="null";
		}
        dto.setFile_names(file_names);
        System.out.println("file_names="+dto.getFile_names());
        

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

}
