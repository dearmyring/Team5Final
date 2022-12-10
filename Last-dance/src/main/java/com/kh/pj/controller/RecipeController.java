package com.kh.pj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.pj.repository.RecipeDao;


@Controller
@RequestMapping("/recipe")
public class RecipeController {

	
	//레시피 의존성
	@Autowired
	private RecipeDao recipeDao;
		
	//레시피 목록
	@GetMapping("/list")
	public String recipeList(Model model) {
		
		//model에 조회 유형에 따른 조회 결과를 첨부
		model.addAttribute("recipeList", recipeDao.recipeList());		
		return "recipe/list";
	}
	
}





