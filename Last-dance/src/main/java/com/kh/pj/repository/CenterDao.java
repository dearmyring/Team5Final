package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.CenterDto;

public interface CenterDao {
	//과거 문의 내역 조회 후 출력용
	public List<CenterDto> historyList(String loginId);
	
	//문의 내역 DB 저장용
	public void insert(CenterDto centerDto); 
	
	//관리자 고객문의 리스트 출력용
	public List<CenterDto> adminList();
}
