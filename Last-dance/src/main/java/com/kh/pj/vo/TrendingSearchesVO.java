package com.kh.pj.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class TrendingSearchesVO {
	private String searchIngredient;
	private int cnt, rn;

}
