package com.kh.pj.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.AdminDto;
import com.kh.pj.vo.ListSearchVO;
import com.kh.pj.vo.MemberCountVO;

@Repository
public class AdminDaoImpl implements AdminDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public AdminDto login(String adminId) {
		return sqlSession.selectOne("admin.get", adminId);
	}

	@Override
	public int adminPostCount(ListSearchVO vo) {
		return sqlSession.selectOne("admin.adminPostCount", vo);
	}
	
	
	//관리자 메인페이지 시작!
	//회원 전체, 오늘 가입자 카운트
	@Override
	public MemberCountVO memberCount() {
		
		return sqlSession.selectOne("admin.memberCount");
	}
	
	
}
