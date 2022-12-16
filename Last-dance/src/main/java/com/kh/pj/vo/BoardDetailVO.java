package com.kh.pj.vo;

import com.kh.pj.entity.BoardDto;
import com.kh.pj.entity.ProfileImageDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class BoardDetailVO {
	private BoardDto boardDto;
	private ProfileImageDto profileImageDto;
}
