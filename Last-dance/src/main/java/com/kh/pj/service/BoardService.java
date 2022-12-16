package com.kh.pj.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kh.pj.entity.BoardDto;


public interface BoardService {
	
	int write(BoardDto boardDto, List<MultipartFile> attachment) throws IllegalStateException, IOException;

	boolean remove(int boardNo);
}
