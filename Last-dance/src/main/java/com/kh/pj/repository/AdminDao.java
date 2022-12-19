package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.AdminDto;
import com.kh.pj.vo.ListSearchVO;
import com.kh.pj.vo.MemberCountVO;
import com.kh.pj.vo.TrendingSearchesVO;

public interface AdminDao {
	public AdminDto login(String adminId);
	public int adminPostCount(ListSearchVO vo);

	
	//관리자 메인페이지 시작!
	//회원 전체, 오늘 가입자 카운트
	MemberCountVO memberCount();
	//오늘의 인기검색어 1~10위
	List<TrendingSearchesVO> trendingSearches();
 	
}
