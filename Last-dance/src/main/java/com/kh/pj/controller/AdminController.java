package com.kh.pj.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.pj.constant.SessionConstant;
import com.kh.pj.entity.AdminDto;
import com.kh.pj.entity.RecipeContentDto;
import com.kh.pj.entity.RecipeDto;
import com.kh.pj.repository.HashtagDao;
import com.kh.pj.repository.RecipeContentDao;
import com.kh.pj.repository.RecipeDao;
import com.kh.pj.vo.RecipeListSearchVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private HashtagDao hashtagDao;
	
	@Autowired
	private RecipeDao recipeDao;
	
	@Autowired
	private RecipeContentDao recipeContentDao;
	
	@GetMapping("/")
	public String main() {
		return "admin/main";
	}
	
	@GetMapping("/login")
	public String login() {
		return "admin/login";
	}
	
	@PostMapping("/login")
	public String login(
			@ModelAttribute AdminDto adminDto,
			HttpSession session) {
		session.setAttribute(SessionConstant.ID, adminDto.getAdminId());
		session.setAttribute(SessionConstant.NICK, adminDto.getAdminNick());
		
		return "redirect:/admin/";
	}
	
	@GetMapping("/list")
	public String list(
			@ModelAttribute(name="voPagination") RecipeListSearchVO vo, 
			Model model) {
		model.addAttribute("recipeList", recipeDao.adminList(vo));
		return "admin/recipe-list";
	}
	
	@GetMapping("/write")
	public String write(Model model) {
		model.addAttribute("hashtagList", hashtagDao.list());
		return "admin/recipe-insert";
	}
	
	@PostMapping("/write")
	public String write(
			@ModelAttribute RecipeDto recipeDto, 
			@ModelAttribute List<RecipeContentDto> recipeContentList) {
		//레시피 번호 뽑기 넣기
		int recipeNo = recipeDao.recipeSequence();
		recipeDto.setRecipeNo(recipeNo);
		recipeDao.write(recipeDto);
		
		//레시피 내용 개수만큼 반복해서 레시피 내용 시퀀스 뽑고 넣기
		for(RecipeContentDto content : recipeContentList) {
			int recipeContentNo = recipeContentDao.sequence();  
			content.setRecipeContentNo(recipeContentNo);
			content.setRecipeNo(recipeNo);
			recipeContentDao.insert(content);
		}
		
		return "redirect:/admin/write-success";
	}
	
	@GetMapping("/write-success")
	public String writeSuccess() {
		return "admin/recipe-success";
	}
	
	@GetMapping("/detail/{recipeNo}")
	public String detail(
			@PathVariable int recipeNo, 
			Model model) {
		model.addAttribute("recipeDto", recipeDao.adminDetail(recipeNo));
		return "admin/recipe-detail";
	}
}
