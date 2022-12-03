package com.kh.pj.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class RecipeContentDto {
	private int recipeContentNo;
	private int recipeNo;
	private String recipeContentText;
	
}
