package com.kh.pj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.pj.repository.HomeDao;

@Controller
public class HomeController {
	@Autowired
	private HomeDao homeDao;
	
	@RequestMapping("/")
	public String home(Model model) {
		model.addAttribute("addRecipeCount", homeDao.counting());
		return "home_1";
	}
	

	
}
