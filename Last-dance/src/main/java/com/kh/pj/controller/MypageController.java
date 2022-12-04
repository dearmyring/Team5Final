package com.kh.pj.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.pj.repository.MypageDao;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	@Autowired
	private MypageDao mypageDao;
	
	@GetMapping("/list")
	public String mypageHome(HttpSession session, Model model) {
		session.setAttribute("loginId", "test01@naver.com");
		
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
	public String pwConfirm(@RequestParam String memberId) {
		
		return "redirect:mypage/myInfo?memberId="+memberId;
	}
	
	@GetMapping("/myInfo")
	public String myInfo() {
		
		return "mypage/myInfo";
	}
	
	
	
	
	

}
