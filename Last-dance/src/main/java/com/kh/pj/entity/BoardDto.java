package com.kh.pj.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BoardDto {

	private int boardNo;
	private String boardId;
	private String boardTitle;
	private String boardContent;
	private int boardClick;
	private int boardLike;
	private Date boardWriteTime;
	private Date boardEditTime;
	private String boardBlind;
	
	
}
