package com.kh.pj.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.pj.entity.RecipeLikeDto;
import com.kh.pj.entity.RecipeViewDto;
import com.kh.pj.repository.RecipeDao;
import com.kh.pj.repository.SearchDao;
import com.kh.pj.vo.RecipeIngredientVO;

@Controller
@RequestMapping("/recipe")
public class RecipeController {

	
	//레시피 의존성
	@Autowired
	private RecipeDao recipeDao;
	
	@Autowired
	private SearchDao searchDao;
		
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
		
		if(session.getAttribute("loginId") != null) {
		//본적이 있는 글인지 확인
		RecipeViewDto recipeViewDto = RecipeViewDto.builder()
					.recipeViewId((String)session.getAttribute("loginId"))
					.recipeViewNo(recipeNo)
					.build();
		
		//내가 본 레시피 조회
		if(recipeDao.myViewRecipe(recipeViewDto) == null) {
			
			//내가 본 레시피 등록
			recipeDao.insertRecipeView(recipeViewDto);
//			System.err.println("등록 실행");
		}
		else {
			recipeDao.updateRecipeViewTime(recipeViewDto);
//			System.err.println("수정 실행");
		}
		
		//좋아요 한적이 있는지 확인
		RecipeLikeDto recipeLikeDto = RecipeLikeDto.builder()
								.recipeLikeNo(recipeNo)
								.recipeLikeId((String) session.getAttribute("loginId"))
								.build();
		
		recipeDao.recipeLikeOne(recipeLikeDto);
		
		
		model.addAttribute("like", recipeDao.recipeLikeOne(recipeLikeDto));
		}
		model.addAttribute("recipe", recipeDao.selectDetail(recipeNo));
		return "recipe/detail";
	}
	
	@GetMapping("/searchList")
	public String searchList(
			Model model,
			@ModelAttribute RecipeIngredientVO recipeIngredientVO) {
		model.addAttribute("complexSearch", searchDao.complexSearch(recipeIngredientVO));
		return "recipe/searchList";
	}
}