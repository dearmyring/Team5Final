package com.kh.pj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.pj.repository.AdminDao;

@Controller
@RequestMapping("/admin")
public class AdminController {

//	@Autowired
//	private AdminDao adminDao;
	
	@GetMapping("/")
	public String main() {
		return "admin/main";
	}
	
	@GetMapping("/login")
	public String login() {
		return "admin/login";
	}
}
