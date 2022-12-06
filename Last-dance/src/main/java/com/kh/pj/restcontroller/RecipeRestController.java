package com.kh.pj.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
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
}
