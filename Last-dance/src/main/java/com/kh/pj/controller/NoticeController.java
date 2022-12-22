package com.kh.pj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.pj.repository.NoticeDao;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	private NoticeDao noticeDao;
	
	@GetMapping("/detail/{noticeNo}")
	public String detail(
			@PathVariable int noticeNo,
			Model model) {
		model.addAttribute("noticeDto", noticeDao.find(noticeNo));
		return "notice/detail";
	}
}
