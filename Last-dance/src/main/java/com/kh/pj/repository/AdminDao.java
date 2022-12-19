package com.kh.pj.repository;

import com.kh.pj.entity.AdminDto;
import com.kh.pj.vo.ListSearchVO;

public interface AdminDao {
	public AdminDto login(String adminId);
	public int adminPostCount(ListSearchVO vo);
}
