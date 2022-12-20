package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.CenterDto;

public interface CenterDao {
	public List<CenterDto> historyList(String loginId);
	
	public void insert(CenterDto centerDto); 
}
