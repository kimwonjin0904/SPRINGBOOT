package com.future.my.board.web;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.future.my.board.service.BoardService;
import com.future.my.board.vo.BoardVO;

@Controller
public class BoardController {

	@Autowired
	BoardService boardService;
	
	@RequestMapping("/boardView")
	public String boardView(Model model) {
		
		ArrayList<BoardVO> boardList = boardService.getBoardList();
		// Model은 spring에서 컨트롤러와 뷰 사이의 데이터를 전달하기 위한 객체
		// key:value형태로 모델에 저장장됨  [배열, 기본타입 모두 상관없음].
		model.addAttribute("boardList", boardList);
		return "board/boardView";
	}
	
	@RequestMapping("/boardWriteView")
	public String boardWriteView(HttpSession session) {
		if(session.getAttribute("login") == null) {
			return "redirect:/loginView";
		}
		return "board/boardWriteView";
	}
	@RequestMapping("/boardWriteDo")
	public String boardWriteDo(BoardVO board) throws Exception {
	    boardService.writeBoard(board);
		return "redirect:/boardView";
	}
	
	@RequestMapping("/getBoard")
	public String boardDetailView (Model model, int boardNo) throws Exception {
		System.out.println(boardNo);
		BoardVO vo = boardService.getBoard(boardNo);
		model.addAttribute("board", vo);
		// TODO: 댓글 목록 조회		

		return "board/boardDetailView";
	}
	@RequestMapping("/boardEditView")
	public String boardEditView(Model model, int boardNo) throws Exception {
		BoardVO vo = boardService.getBoard(boardNo);
		model.addAttribute("board", vo);
		return "board/boardEditView";
	}
	
}
