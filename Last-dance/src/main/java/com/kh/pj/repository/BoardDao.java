package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.BoardDto;
import com.kh.pj.entity.RecipeDto;
import com.kh.pj.vo.BoardListVO;

public interface BoardDao {
	List<BoardListVO> boardList(String memberNick);
	public void write(BoardDto boardDto);
	boolean edit(BoardDto boardDto);
	boolean delete(int boardNo);
	
	
	BoardListVO find(int boardNo);
	
	BoardListVO click(int boardNo);
	boolean updateClickCount(int boardNo);


}
