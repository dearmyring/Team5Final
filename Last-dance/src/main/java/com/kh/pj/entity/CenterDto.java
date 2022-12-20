package com.kh.pj.entity;


import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class CenterDto {
	private String centerMemberId;
	private String centerId;
	private String centerContent;
	private Date centerTime;
}
