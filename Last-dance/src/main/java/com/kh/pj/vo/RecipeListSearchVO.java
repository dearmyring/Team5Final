package com.kh.pj.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class RecipeListSearchVO {
	private String sort;//정렬기준
	
	private String type;//컬럼명
	private String keyword;//검색어
	
	private int p=1;//다른 일 없으면 1페이지부터 보여줌
	private int listCnt=10;//다른 일 없으면 10개씩만 보여줌
	private int pageCnt=5;//페이징은 1부터 5까지
}
