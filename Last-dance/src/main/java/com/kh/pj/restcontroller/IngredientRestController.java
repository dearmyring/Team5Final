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
@RequestMapping("/rest")
@RestController
public class IngredientRestController {

	@Autowired
	private IngredientDao ingredientDao;
	
	@GetMapping("/ingredient/{search}")
	public List<String> ingredient(@PathVariable String search){
		return ingredientDao.list(search);
	}
}
