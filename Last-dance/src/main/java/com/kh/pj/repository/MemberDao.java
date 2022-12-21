package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.MemberDto;
import com.kh.pj.vo.ListSearchVO;

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
	// 비밀번호 변경
	boolean editPw(MemberDto memberDto);
	
	//관리자 회원 목록 조회
	List<MemberDto> adminList(ListSearchVO vo);
}
