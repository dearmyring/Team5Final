package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.BoardDto;

public interface BoardDao {
	void insert(BoardDto boardDto);
	List<BoardDto> selectList();
	BoardDto selectOne(int boardNo);
	boolean edit(BoardDto boardDto);
	boolean delete(int boardDto);
}
