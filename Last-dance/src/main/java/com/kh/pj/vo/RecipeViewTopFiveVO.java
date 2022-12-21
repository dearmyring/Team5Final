package com.kh.pj.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder

public class RecipeViewTopFiveVO {
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
	private int rn;

}
