package com.kh.pj.repository;

import com.kh.pj.entity.MemberDto;

public interface MemberDao {
	// 회원가입
	void Join(MemberDto memberDto);
	// 아이디 중복검사, 로그인 단일 조회
	MemberDto selectOneId(String memberId);
	// 닉네임 중복검사
	MemberDto selectOneNick(String memberNick);
	// 핸드폰번호 중복검사
	MemberDto selectOnePhone(String memberPhone);
	// 로그인 시각 업데이트
	boolean updateLoginTime(String memberId);
}
