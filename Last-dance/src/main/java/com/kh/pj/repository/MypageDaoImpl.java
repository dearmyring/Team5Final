package com.kh.pj.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.RecipeDto;

@Repository
public class MypageDaoImpl implements MypageDao {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<RecipeDto> recipeList(String memberId) {
		
		return sqlSession.selectList("mypage.viewList", memberId);
	}
	
}
