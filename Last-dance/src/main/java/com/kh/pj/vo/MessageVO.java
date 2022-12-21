package com.kh.pj.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@JsonIgnoreProperties
@Data @Builder @NoArgsConstructor @AllArgsConstructor
public class MessageVO {
	private String centerId;
	private String centerContent;
	private Date centerTime;
} 