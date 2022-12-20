package com.kh.pj.repository;

import com.kh.pj.entity.AdminDto;
import com.kh.pj.vo.ListSearchVO;
import com.kh.pj.vo.ListSearchVO2;

public interface AdminDao {
	public AdminDto login(String adminId);
	public int adminPostCount(ListSearchVO vo);
	public int adminBoardCount(ListSearchVO2 vo2);
}
