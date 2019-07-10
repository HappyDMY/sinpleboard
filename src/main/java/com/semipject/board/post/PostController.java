package com.semipject.board.post;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;



/**
 * Handles requests for the application home page.
 */
@Controller
public class PostController {
	@Autowired
	private PostDAO dao;

	private static final Logger logger = LoggerFactory.getLogger(PostController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */

	@RequestMapping(value = "/postlist.do", method = RequestMethod.GET)
	public String board(Locale locale, Model model, @RequestParam(defaultValue = "title") String searchOption,
			@RequestParam(defaultValue = "") String keyword, @RequestParam(defaultValue = "1") int curPage, @RequestParam Map<String, String> data) {
		logger.info("게시판 열림", locale);
		PostDTO dto = new PostDTO();
	
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
		
		
		ArrayList<PostDTO> list=dao.postList(dto);	// 캘린더(calendar) 리스트 -> 수정 시

		
		model.addAttribute("list", list );
		
		return "jsps/list";
	}

	@RequestMapping(value = "/postinsert.do", method = RequestMethod.GET)
	public String insert(Locale locale, Model model, PostDTO dto) {

		return "jsps/insertform";
	}

	@RequestMapping(value = "/postinsert.do", method = RequestMethod.POST)
	public String insertProc(Locale locale, Model model, @RequestParam Map<String, Object> map, PostDTO dto,
			MultipartHttpServletRequest mtfRequest) {

		System.out.println("/postinsert.do POST 요청됨");
		System.out.println("/postinsert.do POST 요청됨" + map.get("category"));
		System.out.println("카테고리" + dto.getCategory());
		System.out.println("파일네임" + dto.getFile_names());
		System.out.println("컨텐츠" + dto.getContent());
		System.out.println("제목" + dto.getTitle());
		System.out.println("아이디" + dto.getUserid());

		int result = dao.insertPost(dto, mtfRequest);

		// System.out.println("result = " + result);
		return "jsps/list";
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
		return "jsps/detail";
		
	}
}// class end
