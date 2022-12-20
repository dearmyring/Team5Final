package com.kh.pj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.pj.repository.CenterDao;
import com.kh.pj.repository.HomeDao;

@Controller
public class HomeController {
	
	@Autowired
	private HomeDao homeDao;
	
	@Autowired
	private CenterDao centerDao;
	
	@RequestMapping("/")
	public String home(Model model) {
		model.addAttribute("addRecipeCount", homeDao.counting());
		model.addAttribute("todayAddCount",homeDao.todayCounting());
		model.addAttribute("todayMemberRanking", homeDao.ranking());
		model.addAttribute("pushRecipe", homeDao.pushRecipe());
		model.addAttribute("mainRecipeTop5", homeDao.mainRecipeTop5());
		return "home_1";
	}
	
}