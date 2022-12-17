package com.kh.pj.restcontroller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.entity.RecipeDto;
import com.kh.pj.entity.RecipeLikeDto;
import com.kh.pj.repository.AdminDao;
import com.kh.pj.repository.RecipeDao;
import com.kh.pj.vo.ListSearchVO;

@CrossOrigin(origins = "http://127.0.0.1:5500")
@RequestMapping("/rest")
@RestController
public class RecipeRestController {
	
	@Autowired
	private RecipeDao recipeDao;
	@Autowired
	private AdminDao adminDao;
	
	@PostMapping("/recipe")
	public List<RecipeDto> adminList(
			@RequestBody ListSearchVO vo){
		vo.setTable("recipe");
		vo.setCount(adminDao.adminPostCount(vo));
		vo.setStartPost(vo.startRow());
		vo.setEndPost(vo.endRow());
		return recipeDao.adminList(vo); 
	}
	
	//검색 & 정렬 있을 시 삭제할 때 처리 추가하기
	@DeleteMapping("/recipe")
	public List<RecipeDto> adminDeleteList(
			@RequestParam List<String> recipeNo){
		for(String no : recipeNo) {
			recipeDao.delete(Integer.parseInt(no));
		}
		ListSearchVO vo = ListSearchVO.builder().table("recipe").build();
		vo.setCount(adminDao.adminPostCount(vo));
		return recipeDao.adminList(vo);
	}
	
	@GetMapping("/recipe_find")
	public RecipeDto adminRecipeFind(@RequestParam String recipeTitle) {
		System.out.println(recipeTitle);
		return recipeDao.adminRecipeFind(recipeTitle.replace(" ", ""));
	}

	//레시피 좋아요
	@GetMapping("/recipe_like/{recipeNo}")
	public int likeUpdate(@PathVariable int recipeNo, HttpSession session) {
		RecipeLikeDto recipeLikeDto = RecipeLikeDto.builder()
														.recipeLikeNo(recipeNo)
														.recipeLikeId((String) session.getAttribute("loginId"))
														.build();
		if(recipeDao.recipeLikeOne(recipeLikeDto) == null) {
			recipeDao.likeUp(recipeNo);
			recipeDao.addLike(recipeLikeDto);
		}
		else {
			recipeDao.likeDown(recipeNo);
			recipeDao.removeLike(recipeLikeDto);
		}//if~else end
		
		return recipeDao.countLike(recipeNo);
		
	}//likeUpdate() end
	
}
