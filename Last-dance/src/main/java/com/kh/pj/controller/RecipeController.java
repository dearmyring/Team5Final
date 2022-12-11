package com.kh.pj.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.pj.entity.RecipeViewDto;
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
	
	
	
	
	//여기부터 레시피 디테일
	
	@GetMapping("/detail")
	public String recipeDetail(Model model, @RequestParam int recipeNo, HttpSession session) {
		
		RecipeViewDto recipeViewDto = RecipeViewDto.builder()
					.recipeViewId((String)session.getAttribute("loginId"))
					.recipeViewNo(recipeNo)
					.build();
		
		//내가 본 레시피 조회
		if(recipeDao.myViewRecipe(recipeViewDto) == null) {
			
			//내가 본 레시피 등록
			recipeDao.insertRecipeView(recipeViewDto);
			System.err.println("등록 실행");
		}
		else {
			recipeDao.updateRecipeViewTime(recipeViewDto);
			System.err.println("수정 실행");
		}
		
		model.addAttribute("recipe", recipeDao.selectDetail(recipeNo));
		
		return "recipe/detail";
	}
	
	
	
	
	
	
}





