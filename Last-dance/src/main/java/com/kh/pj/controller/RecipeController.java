package com.kh.pj.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.pj.constant.SessionConstant;
import com.kh.pj.entity.RecipeDto;
import com.kh.pj.repository.RecipeDao;

@Controller
@RequestMapping("/recipe")
public class RecipeController {
	
	//레시피 의존성
	@Autowired
	private RecipeDao recipeDao;
	
	//레시피 등록(INSERT)처리 (관리자 권한설정 이후 필요)
	public String write(@ModelAttribute RecipeDto recipeDto,
									RedirectAttributes attr,
									HttpSession session
									) throws IllegalStateException, IOException{
		//HttpSession에서 로그인 중인 회원 아이디를 반환
		String recipeId = (String)session.getAttribute(SessionConstant.ID);
		
		//반환한 회원 아이디를 문의글 작성자로 설정
		recipeDto.setRecipeId(recipeId);
		
		//레시피 번호(recipeNo)를 위해 다음 시퀀스 번호 반환
		int recipeNo = recipeDao.recipeSequence();		
		
		//반환한 시퀀스 번호를 View에서 입력받은 RecipeDto의 recipeNo로 설정
		recipeDto.setRecipeNo(recipeNo);
		
		//작성한 레시피 상세 Mapping으로 강제 이동(redirect)
		return "redirect:detail";
	}
		
	//레시피 수정
	//1)레시피 수정 페이지로 연결
	@GetMapping("/edit")
	public String recipeEdit(HttpSession session, Model model, @RequestParam int recipeNo, 
												RedirectAttributes attr) {
		//HttpSession에서 로그인 중인 회원 아이디를 반환
		String loginId = (String)session.getAttribute(SessionConstant.ID);
		
		//반환한 recipe를 매개변수로 상세조회 실행 후 그 결과를 변수 recipeDto에 저장
		RecipeDto recipeDto = recipeDao.selectone(recipeNo);
		
		//recipeDto에서 레시피 작성자(recipeId) 반환
		String recipeId = recipeDto.getRecipeId();
		
		//수정 Mapping의 접근자가 해당 공지 작성자인지 확인(관리자인 경우)
		if(loginId.equals(recipeId)) {
			//recipeDto를 Model에 첨부
			model.addAttribute("recipeDto", recipeDto);
			
			//레시피 수정 페이지(edit.jsp)로 연결
			return "recipe/edit";
		}
		else {
			//해당 레시피 글의 상세 Mapping으로 강제 이동
			return "redirect:detail";
		}
		
		
	}
		

	
	//레시피 목록
	@GetMapping("/list")
	public String recipeList(Model model, HttpSession session) {
		String recipeTitle =(String)session.getAttribute("recipeTitle");
		//model에 조회 유형에 따른 조회 결과를 첨부
		model.addAttribute("recipeList", recipeDao.recipeList(recipeTitle));		
		return "recipe/list";
	}
	
	
  
}







