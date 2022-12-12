package com.kh.pj.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class PushRecipeListVO {
	private int recipeAttachmentNo, recipeNo, cal, rn;
	private String recipeTitle, recipeInfo;
}
