package com.kh.pj.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class NoticeDto {
	private int noticeNo;
	private String noticeNick;
	private String noticeTitle;
	private String noticeContent;
	private int noticeClick;
	private Date noticeWritetime;
	private Date noticeEdittime;
}
