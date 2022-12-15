package com.kh.pj.vo;

import java.util.List;

import com.kh.pj.entity.BoardDto;
import com.kh.pj.entity.BoardImgDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class BoardListAddImgVO {
	
	private BoardDto boardDto;
	private List<BoardImgDto> boardImgList;
	private ReplyCountVO replyCountVO;

}
