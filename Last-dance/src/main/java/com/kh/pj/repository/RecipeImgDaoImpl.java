package com.kh.pj.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.RecipeImgDto;

@Repository
public class RecipeImgDaoImpl implements RecipeImgDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(RecipeImgDto recipeImgDto) {
		sqlSession.insert("recipeImg.insert", recipeImgDto);
	}

	@Override
	public List<Integer> find(int recipeNo) {
		return sqlSession.selectList("recipeImg.find", recipeNo);
	}

	@Override
	public void adminDelete(int recipeNo) {
		sqlSession.delete("recipeImg.adminDelete", recipeNo);
	}

}
