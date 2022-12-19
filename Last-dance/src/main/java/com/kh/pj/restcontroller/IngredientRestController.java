	package com.kh.pj.restcontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.entity.IngredientDto;
import com.kh.pj.repository.IngredientDao;
import com.kh.pj.vo.ListSearchVO;

@CrossOrigin(origins = "http://127.0.0.1:5500")
@RequestMapping("/rest")
@RestController
public class IngredientRestController {

	@Autowired
	private IngredientDao ingredientDao;
	
	//단어 포함 재료 찍어줄 때
	@GetMapping("/ingredient")
	public List<IngredientDto> ingredient(
			@RequestParam String type,
			@RequestParam String keyword,
			@RequestParam(required = false) String sort){
		ListSearchVO vo = ListSearchVO.builder()
										.type(type)
										.keyword(keyword)
										.sort(sort)
									.build();
		return ingredientDao.adminList(vo);
	}
	
	//정확히 일치하는 재료 찍어줄 때
	@GetMapping("/ingredient/{keyword}")
	public String ingredient(@PathVariable String keyword) {
		return ingredientDao.adminSelect(keyword);
	}
	
	@PostMapping("/ingredient")
	public List<IngredientDto> ingredient(
//			@RequestBody(required = false) ListSearchVO vo,
			@RequestBody List<IngredientDto> ingredientList){
		for(IngredientDto ingredient : ingredientList) {
			ingredientDao.insert(ingredient);
		}
		ListSearchVO vo = new ListSearchVO();
		vo.setSort("ingredient_name asc");
		return ingredientDao.adminList(vo);
	}
	
	//검색 & 정렬 있을 시 삭제할 때 처리 추가하기
	@DeleteMapping("/ingredient_delete")
	public List<IngredientDto> ingredientDelete(@RequestParam List<String> ingredientName) {
		for(String ingredient : ingredientName) {
			ingredientDao.delete(ingredient);
		}
		ListSearchVO vo = ListSearchVO.builder()
								.sort("ingredient_name asc")
							.build();
		return ingredientDao.adminList(vo);
	}
	
	@PutMapping("/ingredient")
	public List<IngredientDto> ingredient(
//			@RequestBody(required = false) ListSearchVO vo,
			@RequestBody Map<String, String> data){
		ingredientDao.update(data);

		ListSearchVO vo = new ListSearchVO();
		vo.setSort("ingredient_name asc");
		return ingredientDao.adminList(vo);
	}
}
