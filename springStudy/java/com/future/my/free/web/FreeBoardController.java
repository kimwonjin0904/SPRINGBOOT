package com.future.my.free.web;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.future.my.common.service.CodeService;
import com.future.my.common.vo.CodeVO;
import com.future.my.free.service.FreeBoardService;
import com.future.my.free.vo.FreeBoardSearchVO;
import com.future.my.free.vo.FreeBoardVO;

@Controller
@RequestMapping("/free")
public class FreeBoardController {

	@Autowired
	CodeService codeService;
	
	// 해당 컨트롤러에서 연결되는 화면에서는 comList 사용 가능 
	@ModelAttribute("comList")
	public ArrayList<CodeVO> getCodeList() {
		return codeService.getCodeList("BC00"); // 게시판 관련
	}
	
	@ModelAttribute("comMainList")
	public ArrayList<CodeVO> comMainList() {
		return codeService.getCodeList(null); // test
	}
	
	@Autowired
	FreeBoardService freeBoardService;
	
	@RequestMapping("/test")
	public String test() {
		return "free/test";
	}
	
	@RequestMapping("/freeList")
	public String freeList(Model model
			              // 모델 객체 바인딩 & 뷰 데이터 전달 
			              // 요청과 응답 시 데이터를 유지하기 위해서 
			             , @ModelAttribute("searchVO") FreeBoardSearchVO searchVO) {
		System.out.println(searchVO);
		ArrayList<FreeBoardVO> freeList = freeBoardService.getBoardList(searchVO);
		model.addAttribute("freeList", freeList);
		return "free/freeList";
	}
	
	@RequestMapping("/freeView")
	public String freeView(Model model, @RequestParam("boNo") int boNo) throws Exception {
		System.out.println();
	    // 조회수 증가 되도록 (해당 게시글의 hit + 1 업데이트)
	    // db, xml, dao, service, controller
		
		FreeBoardVO free = freeBoardService.getBoard(boNo);
		model.addAttribute("free", free);
	    return "free/freeView";
	}
	
	@RequestMapping("/freeForm")
	public String freeForm() {
		return "free/freeForm";
	}
	
	@PostMapping("/freeBoardWriteDo")
	public String freeBoardWriteDo(FreeBoardVO vo) throws Exception {
		System.out.println(vo);
		freeBoardService.insertFreeBoard(vo);
		return "redirect:/free/freeList";
	}
}
