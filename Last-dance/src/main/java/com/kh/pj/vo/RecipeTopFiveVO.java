package com.kh.pj.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class RecipeTopFiveVO {
	private String recipeTitle;
	private int cnt, rn;
}
