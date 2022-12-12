package com.kh.pj.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MainRecipeListTop5VO {
	private int recipeNo, recipeClick, recipeLike, recipeTime, cal, recipeAttachmentNo, rn;
	private String recipeInfo, recipeHashtag, recipeDifficulty;
}
