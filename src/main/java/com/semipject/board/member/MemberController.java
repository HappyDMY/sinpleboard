package com.semipject.board.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;


@Controller
@SessionAttributes({"session_userid","session_usergrade"})
public class MemberController {
	
	@Autowired
	private MemberDAO dao;
	
	public MemberController() {
		System.out.println("Start MemberController");
	}
	
	
	/*
	@RequestMapping(value="[요청명령어]", method=RequestMethod.[GET|POST], produces="text/plain; charset='UTF-8'")
	 */
	/*
	
	// (ajax 통신)
	@ResponseBody
	@RequestMapping(value="member/login.ajax", method=RequestMethod.POST)
	public String calendarAdd(MemberDTO dto, Model model, HttpServletRequest req, HttpServletResponse res) {
		
		String result = dao.login(dto);//로그인 result는 userid or fale
		System.out.println("로그인 result = "+result);
		System.out.println("member/login.ajax 호출됨 ");
		HttpSession session = req.getSession();
		
		if (result!="fale") {
			if (session.getAttribute("session_userid")==null) {
				
			}
			
			session.setAttribute("session_userid", result);		
			
			System.out.println("session_userid = "+session.getAttribute("session_userid"));
		}
		

		System.out.println("session.getAttribute('session_userid')="+session.getAttribute("session_userid"));
		// 조회된 정보를 sessionVO에 등록한다.

		
		return result;
	}// calendarAdd() end
	*/
	
	@RequestMapping(value="login.do", method=RequestMethod.POST)
	public String login(MemberDTO dto, Model model, HttpServletRequest req, HttpServletResponse res)throws Throwable {
		String userid = dto.getUserid();
		String userpw = dto.getUserpw();

		userpw = userpw.replace("<", "&lt;");
		userpw = userpw.replace("<", "&gt;");
		
		userid = userid.replace("<", "&lt;");
		userid = userid.replace("<", "&gt;");
		// *공백문자 처리  
		userpw = userpw.replace("  ",	"&nbsp;&nbsp;");
		userid = userid.replace("  ",	"&nbsp;&nbsp;");
		// *줄바꿈 문자처리
		userid = userid.replace("\n", "<br>");
		userpw = userpw.replace("\n", "<br>");
		System.out.println(dto.getUserid());
		System.out.println(dto.getUserpw());

		String session_userid = dao.login(dto);//로그인 result는 userid or fale
		
		System.out.println("로그인 result = "+session_userid);		
		System.out.println("member/login.do 호출됨");
		/*HttpSession session = req.getSession();
		
		if (!session_userid.equals("fale")) {
			session.setAttribute("session_userid", session_userid);
		}
		session.setAttribute("session_userid", session_userid);
		// 조회된 정보를 sessionVO에 등록한다.
		
		System.out.println("session.getAttribute('session_userid')="+session.getAttribute("session_userid"));
		*/ 
		
		
		// model.addAttribute 로 세션 생성 어노테이션이 세션으로 저장해줌
		// @SessionAttributes({"session_userid","session_usergrade"})
		model.addAttribute("session_userid", session_userid);

//		ModelAndView mav=new ModelAndView("index");	
		
		return "index";
	} // logout() end	
	
	
	@RequestMapping(value="logout.do", method=RequestMethod.GET)
	public ModelAndView logout(MemberDTO dto, Model model, SessionStatus status, HttpServletRequest request) {
		
		//세션지우기
		status.setComplete();//세션 지우기
		ModelAndView mav=new ModelAndView("redirect:/home.do");		
		
		return mav;
	} // logout() end	
	
}