package com.kh.pj.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kh.pj.constant.SessionConstant;
import com.kh.pj.repository.BoardLikeDao;

@Controller
public class BoardLikeController {

	@Autowired
	private BoardLikeDao boardLikeDao;
	
	@GetMapping("/like")
	public String like(HttpSession session, Model model) {
		
		String boardLikeId = (String)session.getAttribute(SessionConstant.ID);
		
		return "/board/like";
	}
}
