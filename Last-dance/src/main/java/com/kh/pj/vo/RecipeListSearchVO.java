package com.kh.pj.vo;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class RecipeListSearchVO {
	private int recipeNo, recipeClick, recipeLike, recipeTime, rn;
	private String recipeInfo, recipeHashtag, recipeDifficulty;
	private Date recipeWritetime;
}
