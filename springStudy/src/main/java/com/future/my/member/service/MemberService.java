package com.future.my.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.future.my.member.dao.IMemberDAO;
import com.future.my.member.vo.MemberVO;

@Service  // 비즈니스 로직을 처리하는 계층 
public class MemberService {

		@Autowired   // spring 의존성 주입DI(dependency injection)자동 처리
		             // 스프링이 빈(bean)을 자동으로 관리 
		IMemberDAO dao;
		
		public void registMember(MemberVO vo) throws Exception {
			int result = dao.registMember(vo);
			if(result == 0) {
				throw new Exception();
			}
		}
		
		public MemberVO loginMember(MemberVO vo) throws Exception {
			
			MemberVO user = dao.loginMember(vo);
			System.out.println(user);
			if(user == null) {
				throw new Exception();
			}
			return user;
		}
}
