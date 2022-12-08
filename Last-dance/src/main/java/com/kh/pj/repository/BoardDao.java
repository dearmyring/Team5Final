package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.BoardDto;
import com.kh.pj.entity.RecipeDto;
import com.kh.pj.vo.BoardListVO;

public interface BoardDao {
	
	int sequence();//시퀀스 발행 메소드
	
	List<BoardListVO> boardList(String memberNick);
	List<BoardListVO> boardClickList(String memberNick);
	List<BoardListVO> boardLikeList(String memberNick);
	
	public void write(BoardDto boardDto);
	boolean edit(BoardDto boardDto);
	boolean delete(int boardNo);
	
	
	//상세,좋아요
	BoardListVO selectOne(int boardPostNo);
	BoardListVO click(int boardNo);
	boolean updateClickCount(int boardNo);

	//첨부파일 관련 기능
		void connectAttachment(int boardOriginNo, int boardAttachmentNo);
		int insert2(BoardDto boardDto);
}
