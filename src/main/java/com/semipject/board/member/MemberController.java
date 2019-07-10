package com.semipject.board.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;


@Controller
@SessionAttributes({"session_userid"})
public class MemberController {
	
	@Autowired
	private MemberDAO dao;
	
	public MemberController() {
		System.out.println("Start MemberController");
	}
	
	
	/*
	@RequestMapping(value="[요청명령어]", method=RequestMethod.[GET|POST], produces="text/plain; charset='UTF-8'")
	 */
	
	
	// (ajax 통신)
	@ResponseBody
	@RequestMapping(value="member/login.ajax", method=RequestMethod.POST)
	public String calendarAdd(MemberDTO dto, Model model, HttpSession session) {
		
		String result = dao.login(dto);//로그인 result는 userid or fale
		System.out.println("로그인 result = "+result);
		System.out.println("member/login.ajax 호출됨 ");
		
		if (result!="fale") {
			
			session.setAttribute("session_userid", result);		
			
			System.out.println("session_userid = "+session.getAttribute("session_userid"));
		}
		
		// 조회된 정보를 sessionVO에 등록한다.

		
		return result;
	}// calendarAdd() end
	
	
	@RequestMapping(value="member/login.do", method=RequestMethod.POST)
	public ModelAndView login(MemberDTO dto, HttpServletRequest req, HttpServletResponse res) {
		
		System.out.println(dto.getUserid());
		System.out.println(dto.getUserpw());

		String result = dao.login(dto);//로그인 result는 userid or fale
		System.out.println("로그인 result = "+result);		
		System.out.println("member/login.do 호출됨");
		
		HttpSession session = null;
		if (result!="fale") {
			session= req.getSession();
			session.setAttribute("session_userid", result);
		}
		session= req.getSession();
		session.setAttribute("session_userid", result);
		
		// 조회된 정보를 sessionVO에 등록한다.
		
		System.out.println(session.getAttribute("session_userid"));

		ModelAndView mav=new ModelAndView("index");	
		mav.addObject("session_userid", session);
		
		return mav;
	} // logout() end	
	
	
	@RequestMapping(value="member/logout.do", method=RequestMethod.POST)
	public ModelAndView logout(MemberDTO dto, SessionStatus status, HttpServletRequest request) {
		
		//세션지우기
		status.setComplete();//세션 지우기
		
		String url = request.getHeader("referer"); //이전페이지 URL 가져옴
		int start = url.lastIndexOf("/planbut/");
		String addr = url.substring(start); //이전페이지(명령어만 뽑기)
		
		RedirectView rv = new RedirectView(addr);
		rv.setExposeModelAttributes(false);
		ModelAndView mav=new ModelAndView(rv);		
		
		return mav;
	} // logout() end	
	
}