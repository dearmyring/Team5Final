package com.kh.pj.repository;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.IngredientDto;
import com.kh.pj.vo.RecipeIngredientVO;
import com.kh.pj.vo.RecipeListSearchResultMapVO;

@Repository
public class SearchDaoImpl implements SearchDao {
	

	@Autowired
	private SqlSession sqlSession;
	
	//검색어 추가(INSERT)
	@Override
	public void add(String SearchIngredient) {
		sqlSession.insert("search.add",SearchIngredient);
		
	}
	
	@Override
	public List<IngredientDto> searchForIngredients(String ingredientName) {
		return sqlSession.selectList("search.searchForIngredient", ingredientName);
	}
	
	@Override
	public List<RecipeListSearchResultMapVO> complexSearch(RecipeIngredientVO recipeIngredientVO) {
		return sqlSession.selectList("search.recipeListSearchFinal", recipeIngredientVO);
	}
}
