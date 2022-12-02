package com.kh.pj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.pj.entity.MemberDto;
import com.kh.pj.repository.MemberDao;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberDao memberDao;
	
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		memberDao.Join(memberDto);
		return "redirect:join_success";
	}
	
	@GetMapping("/join_success")
	public String joinSuccess() {
		return "member/success";
	}
}
