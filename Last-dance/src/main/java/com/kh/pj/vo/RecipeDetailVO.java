package com.kh.pj.vo;

import java.util.List;

import com.kh.pj.entity.RecipeContentDto;
import com.kh.pj.entity.RecipeDto;
import com.kh.pj.entity.RecipeImgDto;
import com.kh.pj.entity.RecipeIngredientDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class RecipeDetailVO {
	private RecipeDto recipeDto;
	private List<RecipeIngredientDto> recipeDetailIngredientList;
	private List<RecipeImgDto> recipeImages;
	private List<RecipeContentDto> recipeContentList;
}
