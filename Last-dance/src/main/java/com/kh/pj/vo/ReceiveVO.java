package com.kh.pj.vo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@JsonIgnoreProperties
@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ReceiveVO {
	private int type;
	private String room;
	private String text;
}
