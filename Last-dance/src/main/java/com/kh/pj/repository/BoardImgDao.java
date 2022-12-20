package com.kh.pj.repository;

import com.kh.pj.entity.BoardImgDto;

public interface BoardImgDao {
	void insert(BoardImgDto boardImgDto);
	
	BoardImgDto find(int boardNo);
	
	boolean editThumbnail(BoardImgDto boardImgDto);
}
