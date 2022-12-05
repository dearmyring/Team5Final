package com.kh.pj.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.RecipeContentImgDto;

@Repository
public class RecipeContentImgDaoImpl implements RecipeContentImgDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(RecipeContentImgDto recipeContentImgDto) {
		sqlSession.insert("recipeContentImg.insert", recipeContentImgDto);
	}
	
	
}
