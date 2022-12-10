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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.pj.constant.SessionConstant;
import com.kh.pj.entity.MemberDto;
import com.kh.pj.repository.MypageDao;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	@Autowired
	private MypageDao mypageDao;
	
	@Autowired
	private PasswordEncoder encoder;
	
	
	@GetMapping("/list")
	public String mypageHome(HttpSession session, Model model) {
		String loginId = (String) session.getAttribute("loginId");
		model.addAttribute("myInfo", mypageDao.myInfo(loginId));
		model.addAttribute("profileImg", mypageDao.profileImg(loginId));
		
		model.addAttribute("viewList", mypageDao.viewRecipeList(loginId));
		model.addAttribute("likeList", mypageDao.likeRecipeList(loginId));
		model.addAttribute("writeList", mypageDao.writeList(loginId));
		
		model.addAttribute("myLike", mypageDao.myLikeListCount(loginId));
		return "mypage/list";
	}
	
	@GetMapping("/pwConfirm")
	public String pwConfirm() {
		
		return "mypage/pwConfirm";
	}
	
	@PostMapping("/pwConfirm")
	public String pwConfirm(@RequestParam String inputPw, HttpSession session) {
		String loginId = (String) session.getAttribute("loginId");
		
		//디비에서 가져온 비밀번호
		MemberDto memberPw = mypageDao.pwConfirm(loginId);
		
		
		boolean judge = encoder.matches(inputPw, memberPw.getMemberPw());
		
		if(judge) {
			return "redirect:myInfo?memberId="+loginId;
		}
		else {
			return "redirect:pwConfirm";
		}
		
	}
	
	@GetMapping("/myInfo")
	public String myInfo(HttpSession session, Model model) {
		
		String memberId = (String) session.getAttribute("loginId");
		
		model.addAttribute("userInfo", mypageDao.myInfo(memberId));
		
		return "mypage/myInfo";
	}
	
	@PostMapping("/infoEdit")
	public String infoEdit(@ModelAttribute MemberDto memberDto, RedirectAttributes attr, HttpSession session) {
		boolean result = mypageDao.myInfoEdit(memberDto);
		if(result) {
			return "redirect:list";
		}
		else {
			attr.addAttribute("memberId", session.getAttribute("loginId"));
			return "redirect:myInfo";
		}
	}
	
	
	@GetMapping("/deleteMember")
	public String deleteMember(HttpSession session, RedirectAttributes attr) {
		boolean result = mypageDao.memberWithdrawal((String) session.getAttribute("loginId"));
		
		if(result) {
			session.removeAttribute("loginId");
			return "redirect:/";
		}
		else {
			attr.addAttribute("memberId", session.getAttribute("loginId"));
			return "redirect:myInfo";
		}
		
	}
	
	
	
	
	

}
