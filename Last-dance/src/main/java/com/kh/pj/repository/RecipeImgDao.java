package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.RecipeImgDto;

public interface RecipeImgDao {
	public void insert(RecipeImgDto recipeImgDto);
	
	public List<Integer> find(int recipeNo);
}
