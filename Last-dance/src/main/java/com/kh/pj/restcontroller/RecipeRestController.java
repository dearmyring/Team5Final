package com.kh.pj.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.entity.RecipeDto;
import com.kh.pj.repository.RecipeDao;
import com.kh.pj.vo.RecipeListSearchVO;

@CrossOrigin(origins = "http://127.0.0.1:5500")
@RequestMapping("/rest")
@RestController
public class RecipeRestController {
	
	@Autowired
	private RecipeDao recipeDao;
	
	@PostMapping("/recipe")
	public List<RecipeDto> adminList(
			@RequestBody RecipeListSearchVO vo){
		return recipeDao.adminList(vo); 
	}
	
	//검색 & 정렬 있을 시 삭제할 때 처리 추가하기
	@DeleteMapping("/recipe")
	public List<RecipeDto> adminDeleteList(
			@RequestParam List<String> recipeNo){
		for(String no : recipeNo) {
			recipeDao.delete(Integer.parseInt(no));
		}
		return recipeDao.adminList(null);
	}
	
	@GetMapping("/recipe")
	public RecipeDto adminRecipeFind(@RequestParam String recipeTitle) {
		return recipeDao.adminRecipeFind(recipeTitle.replace(" ", ""));
	}
}
