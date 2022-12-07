package com.kh.pj.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ProfileImageDto {
	
	private String profileId;
	private int ProfileAttachmentNo;
	private Date profileTime;

}
