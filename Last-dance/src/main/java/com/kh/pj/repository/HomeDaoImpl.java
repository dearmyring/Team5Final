package com.kh.pj.repository;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pj.vo.RecipeTotalCountVO;

@Repository
public class HomeDaoImpl implements HomeDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public RecipeTotalCountVO counting() {
		return sqlSession.selectOne("home.totalCount");
	}
}
