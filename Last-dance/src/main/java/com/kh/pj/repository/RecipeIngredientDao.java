package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.RecipeIngredientDto;

public interface RecipeIngredientDao {
	//레시피 재료 등록
	void insert(RecipeIngredientDto recipeIngredientDto);
	
	//레시피 재료 수정
	boolean update(String recipeIngredientName);
	
	//레시피 재료 조회
	List<RecipeIngredientDto> RecipeIngredientList(String recipeIngredientName);
	
	//레시피 재료 삭제
	boolean delete(String recipeIngredientName);
	

}
