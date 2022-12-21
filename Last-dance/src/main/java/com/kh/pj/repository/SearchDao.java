package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.IngredientDto;
import com.kh.pj.vo.RecipeIngredientVO;
import com.kh.pj.vo.RecipeListSearchResultMapVO;

public interface SearchDao {
	// 검색어 추가
	void add(String SearchIngredient);
	
	// 검색 기능 메소드
	List<RecipeListSearchResultMapVO> complexSearch(RecipeIngredientVO recipeIngredientVO);
	
	// 식재료 유사 검색어 조회를 위한 메소드
	List<IngredientDto> searchForIngredients(String ingredientName);
}
