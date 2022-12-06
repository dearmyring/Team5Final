package com.kh.pj.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.pj.constant.SessionConstant;
import com.kh.pj.entity.AdminDto;
import com.kh.pj.entity.RecipeDto;
import com.kh.pj.repository.HashtagDao;
import com.kh.pj.repository.IngredientDao;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private HashtagDao hashtagDao;
	
	@GetMapping("/")
	public String main() {
		return "admin/main";
	}
	
	@GetMapping("/login")
	public String login() {
		return "admin/login";
	}
	
	@PostMapping("/login")
	public String login(
			@ModelAttribute AdminDto adminDto,
			HttpSession session) {
		session.setAttribute(SessionConstant.ID, adminDto.getAdminId());
		session.setAttribute(SessionConstant.NICK, adminDto.getAdminNick());
		
		return "redirect:/admin/";
	}
	
	@GetMapping("/list")
	public String list() {
		return "admin/recipe-list";
	}
	
	@GetMapping("/write")
	public String write(Model model) {
		model.addAttribute("hashtagList", hashtagDao.list());
		return "admin/recipe-insert";
	}
	
	@PostMapping("/write")
	public String write(@ModelAttribute RecipeDto recipeDto) {
		return "redirect:/admin/write-success";
	}
	
	@GetMapping("/write-success")
	public String writeSuccess() {
		return "admin/recipe-success";
	}
}
