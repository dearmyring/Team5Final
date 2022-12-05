package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.RecipeDto;

public interface RecipeDao {
	//레시피 등록
	void write(RecipeDto recipeDto);
	
	//레시피 등록을 위한 시퀀스 번호 반환
	int recipeSequence();
	
	//레시피 수정
	boolean update(int recipeNo);
	
	//레시피 조회
	List<RecipeDto> recipeList(String recipeTitle);
	
	//레시피 삭제
	boolean delete(int recipeNo);
	
	//레시피 상세
	RecipeDto selectone(int recipeNo);

}
