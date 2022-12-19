package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.IngredientDto;
import com.kh.pj.entity.SearchDto;
import com.kh.pj.vo.RecipeKeywordListSearchVO;
import com.kh.pj.vo.RecipeSearchListVO;

public interface SearchDao {
	//검색어 추가
	void add(String SearchIngredient);
	
	//검색어 조회로 레시피 검색 결과 보여주기
	 List<SearchDto> searchList(String SearchIngredient);
	
	//식재료 검색을 위한 메소드
	List<IngredientDto> searchForIngredients(String ingredientName);
	

	

}
