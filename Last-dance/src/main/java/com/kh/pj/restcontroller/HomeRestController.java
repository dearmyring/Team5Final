package com.kh.pj.restcontroller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.repository.HomeDao;
import com.kh.pj.vo.PushRecipeListVO;
import com.kh.pj.vo.RecipeTotalCountVO;


@RestController
@RequestMapping("/rest")
public class HomeRestController {
	
	@Autowired
	private HomeDao homeDao;
	
	@GetMapping("/today_add")
	public RecipeTotalCountVO list(){
		return homeDao.todayCounting();
	}
	
	@GetMapping("/push_recipe")
	public List<PushRecipeListVO> pushList() {
		return homeDao.pushRecipe();
	}
	
}