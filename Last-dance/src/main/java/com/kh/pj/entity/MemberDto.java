package com.kh.pj.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberDto {
	private String memberId;
	private String memberPw;
	private String memberPhone;
	private String memberNick;
	private String memberGender;
	private int memberPoint;
	private String memberDisabled;
	private String badge;
	private Date memberJoin, memberLogin;
}
