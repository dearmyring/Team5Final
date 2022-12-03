package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.RecipeDto;

public interface RecipeDao {
	//레시피 등록
	void insert(RecipeDto recipeDto);
	
	//레시피 수정
	boolean update(int recipeNo);
	
	//레시피 조회
	List<RecipeDto> recipeList(int recipeNo);
	
	//레시피 삭제
	boolean delete(int recipeNo);

}
