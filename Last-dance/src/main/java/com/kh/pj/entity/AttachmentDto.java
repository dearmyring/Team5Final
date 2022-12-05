package com.kh.pj.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class AttachmentDto {

	private int attachmentNo;
	private String attachmentName;
	private String attachmentType;
	private Long attachmentSize;
	private Date attachmentDate;
}
