package com.kh.pj.vo;

import java.sql.Date;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class RecipeListVO {
	private int recipeNo;
	private String recipeNick;
	private String recipeTitle;
	private String recipeInfo;
	private int recipeTime;
	private int recipeClick;
	private int recipeLike;
	private String recipeHashtag;
	private Date recipeWritetime;
	private Date recipeEdittime;
	private String recipeDifficulty;	
	private String ingredientName;

}
