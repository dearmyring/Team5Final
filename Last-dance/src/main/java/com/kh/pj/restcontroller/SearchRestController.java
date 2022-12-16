package com.kh.pj.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.entity.IngredientDto;
import com.kh.pj.repository.SearchDao;


@CrossOrigin(origins = {"http://127.0.0.1:5500"})
@RestController
@RequestMapping("/rest")
public class SearchRestController {
	
	@Autowired
	private SearchDao searchDao;
	
	@GetMapping("/search/{ingredientName}")
	public List<IngredientDto> search(@PathVariable String ingredientName) {
		return searchDao.searchForIngredients(ingredientName);
	}
}
