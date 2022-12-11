package com.kh.pj.vo;


import java.sql.Date;


import java.util.List;

import com.kh.pj.entity.RecipeDto;
import com.kh.pj.entity.RecipeIngredientDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class RecipeListVO {

	private RecipeDto recipeDto;
	private List<RecipeIngredientDto> recipeIngredientList;


}
