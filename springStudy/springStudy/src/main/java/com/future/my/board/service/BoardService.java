package com.future.my.board.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.future.my.board.dao.IBoardDAO;
import com.future.my.board.vo.BoardVO;

@Service
public class BoardService {

	@Autowired
	IBoardDAO dao;
	
	// 게시글 목록 조회
	public ArrayList<BoardVO> getBoardList(){
		return dao.getBoardList();
	}
	// 게시글 작성
	public void writeBoard(BoardVO vo) throws Exception {
		int result = dao.writeBoard(vo);
		if(result == 0) {
			throw new Exception();
		}
	}
	//게시글 상세조회
	public BoardVO getBoard(int boardNo) throws Exception {
		BoardVO result = dao.getBoard(boardNo);
		if(result == null) {
			throw new Exception();
		}
		return result;
	}
	//게시글 업데이트
	
}
