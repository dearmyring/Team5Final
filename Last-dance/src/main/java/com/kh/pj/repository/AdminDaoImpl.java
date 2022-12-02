package com.kh.pj.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.AdminDto;

@Repository
public class AdminDaoImpl implements AdminDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public AdminDto login(String adminId) {
		return sqlSession.selectOne("admin.get", adminId);
	}
	
	
}
