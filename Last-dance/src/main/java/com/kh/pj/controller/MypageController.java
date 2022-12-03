package com.kh.pj.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.pj.repository.MypageDao;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	@Autowired
	private MypageDao mypageDao;
	
	@GetMapping("/list")
	public String mypageHome(HttpSession session) {
		session.setAttribute("loginId", "test01@naver.com");
		
		
		
		session.setAttribute("list", mypageDao.recipeList((String) session.getAttribute("loginId")));
		return "mypage/list";
	}

}
