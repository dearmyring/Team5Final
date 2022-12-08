package com.kh.pj.controller;

<<<<<<< Jenn
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
=======

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
>>>>>>> main
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.pj.entity.SearchDto;
import com.kh.pj.repository.SearchDao;

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
