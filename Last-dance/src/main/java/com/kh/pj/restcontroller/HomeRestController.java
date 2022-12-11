package com.kh.pj.restcontroller;


import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

@CrossOrigin(origins = "http://127.0.0.1:5500")
@RestController
@RequestMapping("/rest")
public class HomeRestController {
//	
//	@Autowired
//	private IngredientDao ingredientDao;
	
//	@GetMapping("/ingredient/{searchList}") -> 민영이 주소랑 겹침 바꾸기
//	public List<String> putIngredient(@PathVariable String search) {
//		return ingredientDao.searchList(search);
//	}
	
	
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

