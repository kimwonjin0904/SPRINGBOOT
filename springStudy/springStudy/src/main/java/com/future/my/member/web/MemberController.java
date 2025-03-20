package com.future.my.member.web;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.future.my.member.service.MemberService;
import com.future.my.member.vo.MemberVO;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping("/registView")
	public String registView() {
		
		return "member/registView";
	}
	
	@RequestMapping("/registDo")
	public String registDo(MemberVO member) {
		
		System.out.println(member);
		try {
			memberService.registMember(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/";
	}
	
	@RequestMapping("/loginView")
	public String loginView() {
		
		return "member/loginView";
	}
	
	@RequestMapping("/loginDo")
	public String loginDo(MemberVO vo, HttpSession session
			            , boolean remember, HttpServletResponse res) {
		MemberVO user = null;
		try {
			user = memberService.loginMember(vo);
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/loginView";
		}
		session.setAttribute("login", user);
		if(remember) {
			//쿠키 생성
			Cookie cookie = new Cookie("rememberId", user.getMemId());
			res.addCookie(cookie);
		}else {
			Cookie cookie = new Cookie("rememberId", "");
			cookie.setMaxAge(0);//동일한 쿠키의 유효시간을 0으로
			res.addCookie(cookie);
		}
		
		return "redirect:/";
	}
	@RequestMapping("/logoutDo")
	public String logoutDo(HttpSession session) {
			session.invalidate();
			return "redirect:/";
	}
	
	
}
