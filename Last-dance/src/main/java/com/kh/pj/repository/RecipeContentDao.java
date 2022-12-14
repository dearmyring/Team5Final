package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.RecipeContentDto;

public interface RecipeContentDao {
	//레시피 내용 시퀀스
	public int sequence();
	
	//레시피 내용 추가
	public void insert(RecipeContentDto recipeContentDto);
	
	//레시피 내용 조회
	public List<RecipeContentDto> find(int recipeNo);
	
	//레시피 내용 수정
	public boolean update(int recipeContentNo);
	
	//레시피 내용 삭제
	public boolean delete(int recipeContentNo);

	//레시피 내용 한 번에 삭제
	public void adminDelete(int recipeNo);
}
