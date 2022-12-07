package com.kh.pj.repository;

import com.kh.pj.entity.NoticeDto;

public interface NoticeDao {
	//공지사항 시퀀스
	public int sequence();
	
	//공지사항 추가
	public void insert(NoticeDto noticeDto);
}
