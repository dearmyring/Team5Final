package com.kh.pj.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.pj.entity.MemberDto;
import com.kh.pj.repository.MypageDao;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	@Autowired
	private MypageDao mypageDao;
	
	@GetMapping("/list")
	public String mypageHome(HttpSession session, Model model) {
		session.setAttribute("loginId", "test10@naver.com"); //구현 완료 후 삭제 예정 코드@@@@@@@@@@@@@@@@@@@
		
		model.addAttribute("myInfo", mypageDao.myInfo((String) session.getAttribute("loginId")));
		
		model.addAttribute("viewList", mypageDao.viewRecipeList((String) session.getAttribute("loginId")));
		model.addAttribute("likeList", mypageDao.likeRecipeList((String) session.getAttribute("loginId")));
		model.addAttribute("writeList", mypageDao.writeList((String) session.getAttribute("loginId")));
		
		model.addAttribute("myLike", mypageDao.myLikeListCount((String) session.getAttribute("loginId")));
		return "mypage/list";
	}
	
	@GetMapping("/pwConfirm")
	public String pwConfirm() {
		
		return "mypage/pwConfirm";
	}
	
	@PostMapping("/pwConfirm")
	public String pwConfirm(@RequestParam String inputPw, HttpSession session) {
		session.setAttribute("loginId", "test10@naver.com"); //구현 완료 후 삭제 예정 코드@@@@@@@@@@@@@@@@@@@
		String loginId = (String) session.getAttribute("loginId");
		String memberPw = mypageDao.pwConfirm(loginId);
		
		if(memberPw.equals(inputPw)) {
			return "redirect:myInfo?memberId="+loginId;
		}
		else {
			return "redirect:pwConfirm";
		}
		
	}
	
	@GetMapping("/myInfo")
	public String myInfo(HttpSession session, Model model) {
		session.setAttribute("loginId", "test10@naver.com"); //구현 완료 후 삭제 예정 코드@@@@@@@@@@@@@@@@@@@
		
		String memberId = (String) session.getAttribute("loginId");
		
		model.addAttribute("userInfo", mypageDao.myInfo(memberId));
		
		return "mypage/myInfo";
	}
	
	@PostMapping("/infoEdit")
	public String infoEdit(@ModelAttribute MemberDto memberDto, RedirectAttributes attr, HttpSession session) {
		session.setAttribute("loginId", "test10@naver.com"); //구현 완료 후 삭제 예정 코드@@@@@@@@@@@@@@@@@@@
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
		session.setAttribute("loginId", "test10@naver.com"); //구현 완료 후 삭제 예정 코드@@@@@@@@@@@@@@@@@@@
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
