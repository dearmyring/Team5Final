package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.RecipeDto;

public interface MypageDao {
	
	public List<RecipeDto> recipeList(String memberId);

}
