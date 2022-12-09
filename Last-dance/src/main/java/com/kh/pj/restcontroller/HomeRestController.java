package com.kh.pj.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;


import com.kh.pj.repository.IngredientDao;

@CrossOrigin(origins = "http://127.0.0.1:5500")
@RestController
@RequestMapping("/rest")
public class HomeRestController {
	
	@Autowired
	private IngredientDao ingredientDao;
	
//	@GetMapping("/ingredient/{searchList}")
//	public List<String> putIngredient(@PathVariable String search) {
//		return ingredientDao.searchList(search);
//	}
//	
	
//	@PostMapping("/??")
//	public String find(
//			@RequestParam List<String> recipeIngredientName) {	
//	//레시피 재료 개수만큼 첨부
//	for(String ingredient : recipeIngredientName) {
//		RecipeIngredientDto ingredientDto = RecipeIngredientDto.builder()
//				.recipeIngredientName(ingredient)
//				.recipeIngredientName(ingredient)
//					.build();
//		recipeIngredientDao.
//	}

}

