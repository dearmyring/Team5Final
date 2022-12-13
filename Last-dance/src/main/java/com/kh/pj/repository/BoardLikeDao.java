package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.BoardLikeDto;
import com.kh.pj.vo.BoardLikeVO;


public interface BoardLikeDao {

	void insert(BoardLikeDto dto);
	void delete(BoardLikeDto dto);
	boolean check(BoardLikeDto dto);
	int count(int boardLikeNo);
	
	void refresh(int boardLikeNo);
	
	
	
}
