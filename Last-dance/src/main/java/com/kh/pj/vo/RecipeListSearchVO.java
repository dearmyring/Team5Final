package com.kh.pj.vo;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class RecipeListSearchVO {
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
	
	private String sort;
	private String type;
	private String keyword;
}
