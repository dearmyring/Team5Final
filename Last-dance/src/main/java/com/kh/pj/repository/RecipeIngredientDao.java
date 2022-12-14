package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.RecipeIngredientDto;

public interface RecipeIngredientDao {
	//레시피 재료 등록
	public void insert(RecipeIngredientDto recipeIngredientDto);
	
	//레시피 재료 수정
	public boolean update(String recipeIngredientName);
	
	//레시피 재료 조회
	public List<RecipeIngredientDto> RecipeIngredientList(String recipeIngredientName);
	
	//레시피 재료 삭제
	public boolean delete(String recipeIngredientName);
	
	//레시피 디테일에 전체 재료 출력
	public List<String> find(int recipeNo);
	
	//레시피 재료 한 번에 삭제
	public void adminDelete(int recipeNo);
}
