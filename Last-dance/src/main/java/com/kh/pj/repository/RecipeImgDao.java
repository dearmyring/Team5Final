package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.RecipeImgDto;

public interface RecipeImgDao {
	public void insert(RecipeImgDto recipeImgDto);
	
	public List<Integer> find(int recipeNo);
	
	//레시피 이미지 한 번에 삭제
	public void adminDelete(int recipeNo);
}
