package com.future.my.member.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.future.my.member.service.MemberService;
import com.future.my.member.vo.MemberVO;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Value("#{util['file.upload.path']}")
	private String CURR_IMAGE_PATH;
	
	@Value("#{util['file.download.path']}")
	private String WEB_PATH;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	
	@RequestMapping("/registView")
	public String registView() {
		
		return "member/registView";
	}
	
	@RequestMapping("/registDo")
	public String registDo(MemberVO member) {
		
		System.out.println(member);
		try {
			member.setMemPw(passwordEncoder.encode(member.getMemPw()));
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
			            , boolean remember, HttpServletResponse res) throws Exception {
		MemberVO user = null;
		user = memberService.loginMember(vo);
		// 사용자 입력 vo 비밀번호와 db user 비밀번호가 일치하면 true, 그렇지 않으면 false 반환
		boolean match = passwordEncoder.matches(vo.getMemPw(), user.getMemPw());
		if(user == null || !match) {
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
	
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		
		System.out.println(CURR_IMAGE_PATH);
		if(session.getAttribute("login") == null) {
			return "redirect:/loginView";
		}
		return "member/mypage";
	}
	@ResponseBody
	@PostMapping("/files/upload")
	public Map<String, Object> uploadFiles(HttpSession session
			            , @RequestParam("uploadImage") MultipartFile file) throws Exception{
		MemberVO vo  = (MemberVO) session.getAttribute("login");
		System.out.println(file);
		
		String imgPath = memberService.profileUpload(vo
				                      , CURR_IMAGE_PATH
				                      , WEB_PATH, file );
		Map<String, Object> map = new HashMap<>();
		map.put("message","success");
		map.put("imagePath", imgPath);
		return map;
	}
	
	
}
