package com.kh.pj.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class BoardVO {

	private int boardNo;
	private String memberNick;
	private String boardId;
	private String boardTitle;
	private String boardContent;
	private int boardClick;
	private int boardLike;
	private Date boardWriteTime;
	private Date boardEditTime;
	private String boardBlind;
	
}
