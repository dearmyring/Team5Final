package com.kh.pj.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class RecipeLikeDto {
	private int recipeLikeNo;
	private String recipeLikeId;
	private Date recipeLikeTime;
}
