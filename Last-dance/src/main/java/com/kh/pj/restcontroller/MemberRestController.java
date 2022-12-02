package com.kh.pj.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.entity.MemberDto;
import com.kh.pj.repository.MemberDao;

@CrossOrigin(origins = "http://127.0.0.1:5500")
@RestController
@RequestMapping("/rest/member")
public class MemberRestController {
	@Autowired
	private MemberDao memberDao;
	
	@RequestMapping("/id")
	public String findId(@RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOneId(memberId);
		if(memberDto == null) {
			return "NNNNY";
		} else {
			return "NNNNN";
		}
	}
	// http://localhost:8888/rest/member/id?memberId=test01@naver.com <-- 출력가능
	
	@RequestMapping("/nick")
	public String findNick(@RequestParam String memberNick) {
		MemberDto memberDto = memberDao.selectOneNick(memberNick);
		if(memberDto == null) {
			return "NNNNY";
		} else {
			return "NNNNN";
		}
	}
	// http://localhost:8888/rest/member/nick?memberNick=테스트 <-- 출력가능
	
	@RequestMapping("/phone")
	public String findPhone(@RequestParam String memberPhone) {
		MemberDto memberDto = memberDao.selectOnePhone(memberPhone);
		if(memberDto == null) {
			return "NNNNY";
		} else {
			return "NNNNN";
		}
	}
	// http://localhost:8888/rest/member/phone?memberPhone=01011111111 <-- 출력가능
}
