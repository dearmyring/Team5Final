package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.RecipeImgDto;

public interface RecipeImgDao {
	void insert(RecipeImgDto recipeImgDto);
	
	List<Integer> find(int recipeNo);
}
