package com.kh.pj.vo;

import java.util.List;

import com.kh.pj.entity.RecipeImgDto;
import com.kh.pj.entity.RecipeIngredientDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RecipeListSearchResultMapVO {
	private RecipeListSearchVO recipeListSearchVO;
	private List<RecipeIngredientDto> recipeIngredientList;
	private List<RecipeImgDto> recipeImgList;
}
