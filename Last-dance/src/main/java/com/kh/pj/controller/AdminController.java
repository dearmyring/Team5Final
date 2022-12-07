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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.pj.constant.SessionConstant;
import com.kh.pj.entity.AdminDto;
import com.kh.pj.entity.NoticeDto;
import com.kh.pj.entity.RecipeContentDto;
import com.kh.pj.entity.RecipeDto;
import com.kh.pj.entity.RecipeImgDto;
import com.kh.pj.entity.RecipeIngredientDto;
import com.kh.pj.repository.HashtagDao;
import com.kh.pj.repository.NoticeDao;
import com.kh.pj.repository.RecipeContentDao;
import com.kh.pj.repository.RecipeDao;
import com.kh.pj.repository.RecipeImgDao;
import com.kh.pj.repository.RecipeIngredientDao;
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
	
	@Autowired
	private RecipeIngredientDao recipeIngredientDao;
	
	@Autowired
	private RecipeImgDao recipeImgDao;
	
	@Autowired
	private NoticeDao noticeDao;
	
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
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute(SessionConstant.ID);
		session.removeAttribute(SessionConstant.NICK);
		
		return "redirect:/admin/login";
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
			@RequestParam List<String> recipeContentText,
			@RequestParam List<Integer> recipeContentAttachmentNo,
			@RequestParam List<String> recipeIngredientName,
			@RequestParam List<Integer> recipeAttachmentNo,
			RedirectAttributes attr,
			HttpSession session) {
		//레시피 번호 뽑아서 넣기
		int recipeNo = recipeDao.recipeSequence();
		recipeDto.setRecipeNo(recipeNo);
		//로그인 닉네임 뽑아서 넣기
		String loginNick = (String)session.getAttribute(SessionConstant.NICK);
		recipeDto.setRecipeNick(loginNick);
		//레시피 등록
		recipeDao.write(recipeDto);
		
		//레시피 내용 개수만큼 반복해서 레시피 내용 시퀀스 뽑고 넣기
		for(int i=0; i<recipeContentText.size(); i++){
			int recipeContentNo = recipeContentDao.sequence();
			RecipeContentDto contentDto = RecipeContentDto.builder()
						.recipeContentNo(recipeContentNo)
						.recipeNo(recipeNo)
						.recipeContentAttachmentNo(recipeContentAttachmentNo.get(i))
						.recipeContentText(recipeContentText.get(i))
					.build();
			recipeContentDao.insert(contentDto);
		}
		
		//레시피 썸네일 개수만큼 반복해서 사진 첨부
		for(int attachmentNo : recipeAttachmentNo) {
			RecipeImgDto imgDto = RecipeImgDto.builder()
						.recipeAttachmentNo(attachmentNo)
						.recipeNo(recipeNo)
					.build();
			recipeImgDao.insert(imgDto);
		}
		
		//레시피 재료 개수만큼 첨부
		for(String ingredient : recipeIngredientName) {
			RecipeIngredientDto ingredientDto = RecipeIngredientDto.builder()
					.recipeIngredientName(ingredient)
					.recipeNo(recipeNo)
			.build();
			recipeIngredientDao.insert(ingredientDto);
		}
		
		//레시피 등록완료 페이지에 파라미터 넘겨주기
		attr.addAttribute("recipeNo", recipeNo);
		
		return "redirect:/admin/write-success";
	}
	
	@GetMapping("/write-success")
	public String writeSuccess(
			@RequestParam int recipeNo,
			Model model) {
		model.addAttribute("recipeNo", recipeNo);
		return "admin/recipe-success";
	}
	
	@GetMapping("/detail/{recipeNo}")
	public String detail(
			@PathVariable int recipeNo, 
			Model model) {
		//레시피 정보
		model.addAttribute("recipeDto", recipeDao.adminDetail(recipeNo));
		//레시피 내용 정보
		model.addAttribute("recipeContentList", recipeContentDao.find(recipeNo));
		//레시피 재료 정보
		model.addAttribute("recipeIngredientList", recipeIngredientDao.find(recipeNo));
		//레시피 썸네일 사진 정보
		model.addAttribute("recipeImgList", recipeImgDao.find(recipeNo));
		return "admin/recipe-detail";
	}
	
	@GetMapping("/update")
	public String update() {
		return "admin/recipe-update";
	}
	
	@PostMapping("/update")
	public String update(
			@ModelAttribute RecipeDto recipeDto, 
			@RequestParam List<String> recipeContentText,
			@RequestParam List<Integer> recipeContentAttachmentNo,
			@RequestParam List<String> recipeIngredientName,
			@RequestParam List<Integer> recipeAttachmentNo,
			RedirectAttributes attr,
			HttpSession session) {
		
		attr.addAttribute("recipeNo", recipeDto.getRecipeNo());
		return "redirect:detail";
	}
	
	@GetMapping("/delete/{recipeNo}")
	public String delete(@PathVariable int recipeNo) {
		recipeDao.delete(recipeNo);
		return "redirect:../list";
	}
	
	@GetMapping("/notice/write")
	public String write() {
		return "admin/notice-insert";
	}
	
	@PostMapping("/notice/write")
	public String write(
			@ModelAttribute NoticeDto noticeDto,
			RedirectAttributes attr) {
		int noticeNo = noticeDao.sequence();
		noticeDto.setNoticeNo(noticeNo);
		noticeDao.insert(noticeDto);
		attr.addAttribute("noticeNo", noticeNo);
		return "redirect:write-success";
	}
	
	@GetMapping("/notice/write-success")
	public String noticeWriteSuccess(
			@RequestParam int noticeNo,
			Model model) {
		model.addAttribute("noticeNo", noticeNo);
		return "admin/notice-success";
	}
}
