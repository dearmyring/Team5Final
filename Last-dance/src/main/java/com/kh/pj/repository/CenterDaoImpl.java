package com.kh.pj.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.CenterDto;

@Repository
public class CenterDaoImpl implements CenterDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<CenterDto> historyList(String loginId) {
		return sqlSession.selectList("center.historyList", loginId);
	}

	@Override
	public void insert(CenterDto centerDto) {
		sqlSession.insert("center.insert", centerDto);
	}

	@Override
	public List<CenterDto> adminList() {
		return sqlSession.selectList("center.adminList");
	}
}
