package com.kh.pj.repository;

import com.kh.pj.entity.BoardLikeDto;


public interface BoardLikeDao {

	void insert(BoardLikeDto dto);
	void delete(BoardLikeDto dto);
	boolean check(BoardLikeDto dto);
	int count(int boardLikeNo);
	
	void refresh(int boardLikeNo);
	
	
}
