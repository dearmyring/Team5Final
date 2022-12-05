package com.kh.pj.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class RecipeDto {
	int recipeNo;
	String recipeNick;
	String recipeTitle;
	String recipeInfo;
	String recipeId;
	int recipeTime;
	int recipeClick;
	int recipeLike;
	String recipeHashtag;
	Date recipeWritetime;
	Date recipeEdittime;
	String recipeDifficulty;	

}
