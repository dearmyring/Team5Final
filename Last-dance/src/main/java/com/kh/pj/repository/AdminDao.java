package com.kh.pj.repository;

import com.kh.pj.entity.AdminDto;
import com.kh.pj.vo.ListSearchVO;
import com.kh.pj.vo.MemberCountVO;

public interface AdminDao {
	public AdminDto login(String adminId);
	public int adminPostCount(ListSearchVO vo);

	
	//관리자 메인페이지 시작!
	//회원 전체, 오늘 가입자 카운트
	MemberCountVO memberCount();
 	
}
