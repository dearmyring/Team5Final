package com.kh.pj.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class TodayMemberRankingVO {
	private String memberNick;
	private String memberBadge;
	private int rn;
}
