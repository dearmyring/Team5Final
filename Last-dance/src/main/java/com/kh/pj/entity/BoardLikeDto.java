package com.kh.pj.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BoardLikeDto {

	private int boardLikeNo;
	private String boardLikeId;
	private Date boardLikeTime;
}
