package com.kh.pj.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class RecipeIngredientDto {
	String recipeIngredientName;
	int recipeNo;
	
}
