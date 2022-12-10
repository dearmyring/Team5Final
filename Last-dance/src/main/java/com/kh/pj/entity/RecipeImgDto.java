package com.kh.pj.entity;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class RecipeImgDto{
	private int recipeAttachmentNo;
	private int recipeNo;
}
