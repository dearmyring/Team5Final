package com.kh.pj.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class ReplyDto {
	private int replyNo;
	private int replyBoardNo;
	private String replyId;
	private String replyContent;
	private Date replyWriteTime;
	private Date replyEditTime;
	private String replyBlind;
	
}
