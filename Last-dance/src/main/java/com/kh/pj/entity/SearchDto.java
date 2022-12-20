package com.kh.pj.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data @Builder @AllArgsConstructor @NoArgsConstructor
public class SearchDto {
	String searchIngredient;
	Date searchTime;
}
