package com.kh.pj.vo;

import java.util.List;

import com.kh.pj.entity.RecipeImgDto;
import com.kh.pj.entity.RecipeIngredientDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MainRecipeTop5MergingVO {
	private MainRecipeListTop5VO mainRecipeListTop5VO;
	private List<RecipeIngredientDto> recipeIngredientList;
	private List<RecipeImgDto> recipeImgList;
}
