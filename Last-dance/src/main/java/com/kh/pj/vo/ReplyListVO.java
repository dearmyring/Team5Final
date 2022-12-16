package com.kh.pj.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class ReplyListVO {

	private int replyNo;
	private int replyBoardNo;
	private String replyId;
	private String memberNick;
	private String replyContent;
	private Date replyWriteTime;
	private Date replyEditTime;
	private String replyBlind;
	private String memberBadge;
	private int profileAttachmentNo;
}
