package com.kh.pj.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.entity.IngredientDto;
import com.kh.pj.repository.IngredientDao;

@CrossOrigin(origins = "http://127.0.0.1:5500")
@RestController
@RequestMapping("/rest")
public class HomeRestController {
	
	@Autowired
	private IngredientDao ingredientDao;
	
	@PostMapping("/ingredient")
	public String ingredient(@RequestBody IngredientDto ingredientDto) {
		IngredientDto findDto = ingredientDao.findIngredient(ingredientDto.getIngredientName());
		
		if(findDto == null) {
			return "fail";
		}
		
		if(findDto.getIngredientName().equals(findDto.getIngredientName())) {
			return findDto.getIngredientName();
		}
		return "fail";
	}
}

