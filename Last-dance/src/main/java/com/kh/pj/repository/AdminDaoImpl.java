package com.kh.pj.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.AdminDto;
import com.kh.pj.vo.ListSearchVO;
import com.kh.pj.vo.ListSearchVO2;

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

	@Override
	public int adminBoardCount(ListSearchVO2 vo2) {
		return sqlSession.selectOne("admin.adminBoardCount", vo2);
	}
	
	
}
