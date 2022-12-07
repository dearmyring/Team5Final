package com.kh.pj.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.pj.entity.MemberDto;
import com.kh.pj.repository.MemberDao;
import com.kh.pj.service.EmailService;
import com.kh.pj.constant.SessionConstant;
import com.kh.pj.entity.CertDto;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	
	@PostMapping("/join")
	public String join(
			@ModelAttribute MemberDto memberDto) {
		memberDao.Join(memberDto);
		return "redirect:join_success";
	}
	
	@PostMapping("/send_email")
	@ResponseBody
	public void sendEmail(@RequestParam String certWho) {
		emailService.sendCertMail(certWho);
	}
	
	@PostMapping("/confirm_email")
	@ResponseBody
	public boolean confirmEmail(@ModelAttribute CertDto certDto) {
		return emailService.checkCert(certDto);
	}
	
	@GetMapping("/join_success")
	public String joinSuccess() {
		return "member/join_success";
	}
	
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	@PostMapping("/login")
	public String login(HttpSession session, @ModelAttribute MemberDto inputDto) {
		MemberDto findDto = memberDao.selectOneId(inputDto.getMemberId());
		if(findDto == null) {
			return "redirect:login?error";
		}
		boolean judge = encoder.matches(inputDto.getMemberPw(), findDto.getMemberPw());
		
		if(judge) {
			session.setAttribute(SessionConstant.ID, findDto.getMemberId());
			session.setAttribute(SessionConstant.NICK, findDto.getMemberNick());
			// 로그인 시각 업데이트
			memberDao.updateLoginTime(inputDto.getMemberId());
			return "redirect:/";
		} 
		else {
			return "redirect:login?error";
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute(SessionConstant.ID);
		session.removeAttribute(SessionConstant.NICK);
		return "redirect:/";
	}
	
	@GetMapping("/find_pw")
	public String findPw() {
		return "member/find_pw";
	}
	
	@PostMapping("/find_pw")
	public String findPw(
			Model model,
			@RequestParam String memberId,
			RedirectAttributes attr) {
		model.addAttribute("memberDto", memberDao.selectOneId(memberId));
		attr.addAttribute("memberId", memberId);
		return "redirect:edit_pw";
	}
	
	@GetMapping("/edit_pw")
	public String editPw(Model model,
			@RequestParam(required = false) String memberId) {
		model.addAttribute("memberDto", memberDao.selectOneId(memberId));
		return "member/edit_pw";
	}
	
	@PostMapping("/edit_pw")
	public String editPw(@ModelAttribute MemberDto memberDto) {
		memberDao.editPw(memberDto);
		return "redirect:edit_success";
	}
	
	@GetMapping("/edit_success")
	public String editSuccess() {
		return "member/edit_success";
	}
	
	
}
