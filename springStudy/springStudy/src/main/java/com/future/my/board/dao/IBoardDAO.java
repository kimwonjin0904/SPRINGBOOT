package com.future.my.board.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.future.my.board.vo.BoardVO;

@Mapper
public interface IBoardDAO {

	// 게시글 목록 조회
	public ArrayList<BoardVO> getBoardList();
	// 게시글 작성
	public int writeBoard(BoardVO board);
	// 게시글 상세 조회
	public BoardVO getBoard(int boardNo);
	//게시글 업데이트
	
	//게시글 삭제
	
}
