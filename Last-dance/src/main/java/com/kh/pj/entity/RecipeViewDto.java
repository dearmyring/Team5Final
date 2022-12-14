package com.kh.pj.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class RecipeViewDto {
	private String recipeViewId;
	private int recipeViewNo;
	private Date recipeViewTime;

}
