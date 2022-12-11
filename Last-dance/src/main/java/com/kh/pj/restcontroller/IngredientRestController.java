package com.kh.pj.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.entity.IngredientDto;
import com.kh.pj.repository.IngredientDao;
import com.kh.pj.vo.IngredientListSearchVO;

@CrossOrigin(origins = "http://127.0.0.1:5500")
@RequestMapping("/rest")
@RestController
public class IngredientRestController {

	@Autowired
	private IngredientDao ingredientDao;
	
	@GetMapping("/ingredient")
	public List<IngredientDto> ingredient(
			@RequestParam String type,
			@RequestParam String keyword,
			@RequestParam(required = false) String sort){
		IngredientListSearchVO vo = IngredientListSearchVO.builder()
															.type(type)
															.keyword(keyword)
															.sort(sort)
														.build();
		return ingredientDao.adminList(vo);
	}
	
	@PostMapping("/ingredient")
	public List<IngredientDto> ingredient(
			@ModelAttribute IngredientDto ingredientDto,
			@ModelAttribute IngredientListSearchVO vo){
		ingredientDao.insert(ingredientDto);
		return ingredientDao.adminList(vo);
	}
	
	//검색 & 정렬 있을 시 삭제할 때 처리 추가하기
	@DeleteMapping("/ingredient")
	public List<IngredientDto> ingredient(@RequestParam List<String> ingredientName) {
		for(String ingredient : ingredientName) {
			ingredientDao.delete(ingredient);
		}
		IngredientListSearchVO vo = IngredientListSearchVO.builder().build();
		return ingredientDao.adminList(vo);
	}
}
