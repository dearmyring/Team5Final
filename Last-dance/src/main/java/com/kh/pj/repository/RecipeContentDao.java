package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.RecipeContentDto;

public interface RecipeContentDao {
	//레시피 내용 추가
	void insert(RecipeContentDto recipeContentDto);
	
	//레시피 내용 수정
	boolean update(int recipeContentNo);
	
	//레시피 내용 조회
	List<RecipeContentDto> RecipeContentList(int recipeContentNo);
	
	//레시피 내용 삭제
	boolean delete(int recipeContentNo);

}
