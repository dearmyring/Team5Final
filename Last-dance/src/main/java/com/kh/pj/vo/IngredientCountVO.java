package com.kh.pj.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class IngredientCountVO {
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
	private int cnt; //재료갯수가 포함된 VO

}
