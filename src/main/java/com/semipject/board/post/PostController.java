package com.semipject.board.post;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonParser;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;


import net.utility.UploadFileUtils;


/**
 * Handles requests for the application home page.
 */
@Controller
@SessionAttributes({"session_userid","session_usergrade"})
public class PostController {
	@Autowired
	private PostDAO dao;

	private static final Logger logger = LoggerFactory.getLogger(PostController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */

	@RequestMapping(value = "/postlist.do", method = RequestMethod.GET)
	public ModelAndView board(@RequestParam(defaultValue="title") String searchOption,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam(defaultValue="1") int curPage, PostDTO dto,
			HttpSession session) throws Exception {
		logger.info("게시판 열림");
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsps/list");
		
		
		// 레코드의 갯수 계산
		int count = dao.countListContent(searchOption, keyword);
		System.out.println("총레코드수 = "+count);
		// 페이지 나누기 관련 처리
		BoardPager boardPager = new BoardPager(count, curPage);
		int start = boardPager.getPageBegin();
		int end = boardPager.getPageEnd();
		
		List<PostDTO> list = dao.listAll(start, end, searchOption, keyword);
		 

		
		//ArrayList<PostDTO> list=dao.postList(dto);	// 캘린더(calendar) 리스트 -> 수정 시
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", list); // list
		
		map.put("count", count); // 레코드의 갯수
		map.put("searchOption", searchOption); // 검색옵션
		map.put("keyword", keyword); // 검색키워드
		map.put("boardPager", boardPager);
		
		mav.addObject("map", map);
		/*
		// 데이터를 맵에 저장
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list); // list
		map.put("count", count); // 레코드의 갯수
		map.put("searchOption", searchOption); // 검색옵션
		map.put("keyword", keyword); // 검색키워드
		map.put("boardPager", boardPager);
		// ModelAndView - 모델과 뷰
		ModelAndView mav = new ModelAndView();
		*/
		
		
		
		return mav;
	}
	
	@RequestMapping(value = "/updateproc.do", method = RequestMethod.POST)
	public ModelAndView updateProc(PostDTO dto,  Model model, HttpSession session, MultipartHttpServletRequest mtfRequest) {	
		System.out.println("postno = "+dto.getPostno());
		System.out.println("title = "+dto.getTitle());
		System.out.println("content = "+dto.getContent());
		System.out.println();
		ModelAndView mav = new ModelAndView();
		int result=dao.update(dto);
		//String addr = "redirect:/postdetail.dopostno=?"+dto.getPostno();
		mav.setViewName("redirect:/postlist.do");
		//mav.addObject("result", result);
		
		return mav;
	}
	

	@RequestMapping(value = "/postupdate.do", method = RequestMethod.GET)
	public String update( Model model, PostDTO dto) {
		System.out.println("업데이트할 postno = "+ dto.getPostno());
		PostDTO resultdto = dao.detail(dto);
		
		model.addAttribute("dto", resultdto);		
		return "jsps/updateform";
		
	}
	

	@RequestMapping(value = "/postinsert.do", method = RequestMethod.GET)
	public String insert(Locale locale, Model model, PostDTO dto) {

		return "jsps/insertform";
	}

	@RequestMapping(value = "/postinsert.do", method = RequestMethod.POST)
	public ModelAndView insertProc(HttpSession session, Model model, @RequestParam Map<String, Object> map, PostDTO dto,
			MultipartHttpServletRequest mtfRequest) {
		
		ModelAndView mav = new ModelAndView();
		dto.setUserid((String)session.getAttribute("session_userid"));
		System.out.println("userid = "+ dto.getUserid() +"의 게시글 insert 요정쵬");
		List<MultipartFile> fileList = mtfRequest.getFiles("file"); 
		for (MultipartFile mf : fileList) {
			//원래 파일명\
			String ofn =mf.getOriginalFilename();
			StringTokenizer token = new StringTokenizer(ofn,".");
			while (token.hasMoreTokens()) {
				String str = token.nextToken();
				if (str.equals("jsp")||str.equals("php")||str.equals("asp")) {
					mav.setViewName("redirect:/insertform.do");
					mav.addObject("msg","부적합한 파일이 업로드 되었습니다.");
					return mav;

				} 
				
			}
        }//파일들 저장하고 저장된 파일 네임 jsonarry에  저장하는 for end
		
		
		
		int result = dao.insertPost(dto, mtfRequest);
		if (result==0) {
			mav.setViewName("redirect:/insertform.do");
			mav.addObject("msg","저장 실패");
			return mav;
		}

		// System.out.println("result = " + result);
		
		mav.setViewName("redirect:/postlist.do");
		return mav;



	}

	@ResponseBody
	@RequestMapping(value = "/postlist.ajax", produces = "application/json", method = RequestMethod.GET)
	public ArrayList<PostDTO> postsearch(@RequestParam Map<String, String> data) {
		/*
		 * System.out.println(data.get("startday"));
		 * System.out.println(data.get("endday"));
		 * System.out.println(data.get("category"));
		 * System.out.println(data.get("writerortitle"));
		 * System.out.println(data.get("word"));
		 * 
		 */
		
		

		// 페이지 나누기 관련 처리
		/*
		int count =  list.size();
		BoardPager boardPager = new BoardPager(count, curPage);
		int start = boardPager.getPageBegin();
		int end = boardPager.getPageEnd();

		List<PostDTO> resultlist = dao.listAll(start, end, searchOption, keyword);
		 */
		
		if (data.get("category") == "분류") {
			data.put("category", "%");
		}

		System.out.println();
		System.out.println("디폴트값인애들 수정 후");
		System.out.println(data.get("startdate"));
		System.out.println(data.get("enddate"));
		System.out.println(data.get("category"));
		System.out.println(data.get("writerortitle"));
		System.out.println(data.get("word"));

		ArrayList<PostDTO> list = dao.searchlist(data); // 캘린더(calendar) 리스트 -> 수정 시
		// 레코드의 갯수 계산
		System.out.println("post 리스트 size: " + list.size());

		return list;
	}// calendarLoad() end
	
	
	@RequestMapping(value = "/postdetail.do", method = RequestMethod.GET)
	public String detail( Model model, PostDTO dto) {
		System.out.println("postno = "+ dto.getPostno());
		PostDTO resultdto = dao.detail(dto);		
		
		System.out.println(resultdto.getCategory());
		System.out.println(resultdto.getTitle());
		System.out.println(resultdto.getContent());
		System.out.println(resultdto.getUserid());
		
		model.addAttribute("dto", resultdto);
		String str = resultdto.getFile_names();
		
		
		JSONParser jsonParser = new JSONParser();
		try {
			Object jsonArray =  jsonParser.parse(str);
			model.addAttribute("file_names", jsonArray);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "jsps/detail";
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/postdelete.ajax", method = RequestMethod.POST)
	public String delete(PostDTO dto, HttpSession session , HttpServletRequest req, HttpServletResponse res) throws Exception {
		System.out.println("postdelete.ajax 요청됨 parameter dto.postno="+dto.getPostno());
		System.out.println(session.getAttribute("session_userid").equals(dto.getUserid()) );
		String result = null;
		if (session.getAttribute("session_userid").equals(dto.getUserid())) {
			
			int deleteresult = dao.delete(dto);
			System.out.println("deleteresult = " + deleteresult);
			
			if (deleteresult==1) {
				result = "1";
				return result;
			}else {
				return result;
			}
			
		}else {
			return result;
		}		
	}
	@ResponseBody
	@RequestMapping(value = "/deletefile.ajax", method = RequestMethod.POST)
	public String deletefile(PostDTO dto, int idx, String fileName, HttpSession session , HttpServletRequest req, HttpServletResponse res) throws Exception {
		System.out.println("deletefile.ajax 요청됨 parameter dto.postno="+dto.getPostno());
		System.out.println(session.getAttribute("session_userid").equals(dto.getUserid()) );
		String result = null;
		
		if (session.getAttribute("session_userid").equals(dto.getUserid())) {
			
			// 파일의 확장자 추출
			String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
			// 이미지 파일 여부 검사
			
	        String path = req.getSession().getServletContext().getRealPath("/resources/files_updown/");
	        MediaType mType = net.utility.MediaUtils.getMediaType(formatName);
            // 헤더 구성 객체(외부에서 데이터를 주고받을 때에는 header와 body를 구성해야하기 때문에)
            HttpHeaders headers = new HttpHeaders();

			
			if (mType != null) {
				// 썸네일 이미지 파일 추출
				String front = fileName.substring(0, 12);
				String end = fileName.substring(14);
				// 썸네일 이미지 삭제
				new File(path + (front + end).replace('/', File.separatorChar)).delete();
			}
			// 원본 파일 삭제
			new File(path + fileName.replace('/', File.separatorChar)).delete();
			
			// 레코드 삭제
			int deleteresult = dao.deletefile(dto, idx, fileName);
			System.out.println("deleteresult = " + deleteresult);
			/*
        // 이미지의 경우(썸네일 + 원본파일 삭제), 이미지가 아니면 원본파일만 삭제
        // 이미지 파일이면
			*/
			if (deleteresult==1) {
				result = "1";
				return result;
			}else {
				return result;
			}
			
		}else {
			return result;
		}		
	}
}// class end
