package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.BoardDto;
import com.kh.pj.vo.BoardVO;

public interface BoardDao {

	List<BoardVO>list();
	//게시글 작성
	public void write(BoardDto boardDto);
	boolean edit(BoardDto boardDto);
	boolean delete(int boardNo);
	BoardVO find(int boardNo);
}
