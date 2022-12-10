package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.NoticeDto;

public interface NoticeDao {
	//공지사항 시퀀스
	public int sequence();
	
	//공지사항 추가
	public void insert(NoticeDto noticeDto);
	
	//공지사항 리스트
	public List<NoticeDto> list();
	
	//공지사항 상세
	public NoticeDto find(int noticeNo);
	
	//공지사항 수정
	public void update(NoticeDto noticeDto);
	
	//공지사항 삭제
	public void delete(int noticeNo);
}
