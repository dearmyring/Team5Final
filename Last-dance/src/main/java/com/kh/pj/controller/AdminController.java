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
import com.kh.pj.repository.AdminDao;
import com.kh.pj.repository.AttachmentDao;
import com.kh.pj.repository.BoardDao;
import com.kh.pj.repository.BoardImgDao;
import com.kh.pj.repository.CategoryDao;
import com.kh.pj.repository.CenterDao;
import com.kh.pj.repository.HashtagDao;
import com.kh.pj.repository.IngredientDao;
import com.kh.pj.repository.MemberDao;
import com.kh.pj.repository.NoticeDao;
import com.kh.pj.repository.RecipeContentDao;
import com.kh.pj.repository.RecipeDao;
import com.kh.pj.repository.RecipeImgDao;
import com.kh.pj.repository.RecipeIngredientDao;
import com.kh.pj.repository.ReplyDao;
import com.kh.pj.vo.ListSearchVO;

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
	
	@Autowired
	private IngredientDao ingredientDao;
	
	@Autowired
	private CategoryDao categoryDao;
	
	@Autowired
	private BoardDao boardDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private CenterDao centerDao;
	
	@Autowired
	private BoardImgDao boardImgDao;
	
	@Autowired
	private ReplyDao replyDao;
	
	@Autowired
	private AttachmentDao attachmentDao;

	@GetMapping("/")
	public String main(Model model) {
		
		//????????? TOP5(????????? ?????? ??? -> ????????? ?????? ???)
		model.addAttribute("recipeTopFive",adminDao.recipeTopFive());
		//????????? TOP5(????????? ?????? ??? -> ????????? ?????? ???)
		model.addAttribute("boardTopFive", adminDao.boardTopFive());
		
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
		session.setAttribute(SessionConstant.NICK, adminDao.login(adminDto.getAdminId()).getAdminNick());
		
		return "redirect:/admin/";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute(SessionConstant.ID);
		session.removeAttribute(SessionConstant.NICK);
		
		return "redirect:/admin/login";
	}
	
	//????????? ????????? ????????????
	@GetMapping("/recipe/list")
	public String list(
			@ModelAttribute(name="voPagination") ListSearchVO vo, 
			Model model) {
		vo.setTable("recipe");
		vo.setSort("recipe_no desc");
		vo.setCount(adminDao.adminPostCount(vo));
		model.addAttribute("recipeList", recipeDao.adminList(vo));
		return "admin/recipe-list";
	}
	
	@GetMapping("/recipe/write")
	public String write(Model model) {
		model.addAttribute("hashtagList", hashtagDao.list());
		model.addAttribute("categoryList", categoryDao.adminList());
		return "admin/recipe-insert";
	}
	
	@PostMapping("/recipe/write")
	public String write(
			@ModelAttribute RecipeDto recipeDto, 
			@RequestParam List<String> recipeContentText,
			@RequestParam List<Integer> recipeContentAttachmentNo,
			@RequestParam List<String> recipeIngredientName,
			@RequestParam List<Integer> recipeAttachmentNo,
			RedirectAttributes attr,
			HttpSession session) {
		//????????? ?????? ????????? ??????
		int recipeNo = recipeDao.recipeSequence();
		recipeDto.setRecipeTitle(recipeDto.getRecipeTitle().replace(" ", ""));
		recipeDto.setRecipeNo(recipeNo);
		//????????? ????????? ????????? ??????
		String loginNick = (String)session.getAttribute(SessionConstant.NICK);
		recipeDto.setRecipeNick(loginNick);
		//????????? ??????
		recipeDao.write(recipeDto);
		
		//????????? ?????? ???????????? ???????????? ????????? ?????? ????????? ?????? ??????
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
		
		//????????? ????????? ???????????? ???????????? ?????? ??????
		for(int attachmentNo : recipeAttachmentNo) {
			RecipeImgDto imgDto = RecipeImgDto.builder()
						.recipeAttachmentNo(attachmentNo)
						.recipeNo(recipeNo)
					.build();
			recipeImgDao.insert(imgDto);
		}
		
		//????????? ?????? ???????????? ??????
		for(String ingredient : recipeIngredientName) {
			RecipeIngredientDto ingredientDto = RecipeIngredientDto.builder()
					.recipeIngredientName(ingredient)
					.recipeNo(recipeNo)
			.build();
			recipeIngredientDao.insert(ingredientDto);
		}
		
		//????????? ???????????? ???????????? ???????????? ????????????
		attr.addAttribute("recipeNo", recipeNo);
		
		return "redirect:write-success";
	}
	
	@GetMapping("/recipe/write-success")
	public String writeSuccess(
			@RequestParam int recipeNo,
			Model model) {
		model.addAttribute("recipeNo", recipeNo);
		return "admin/recipe-success";
	}
	
	@GetMapping("/recipe/detail/{recipeNo}")
	public String detail(
			@PathVariable int recipeNo, 
			Model model) {
		//????????? ??????
		model.addAttribute("recipeDto", recipeDao.adminDetail(recipeNo));
		//????????? ?????? ??????
		model.addAttribute("recipeContentList", recipeContentDao.find(recipeNo));
		//????????? ?????? ??????
		model.addAttribute("recipeIngredientList", recipeIngredientDao.find(recipeNo));
		//????????? ????????? ?????? ??????
		model.addAttribute("recipeImgList", recipeImgDao.find(recipeNo));
		return "admin/recipe-detail";
	}
	
	@GetMapping("/recipe/update")
	public String update(
			Model model,
			@RequestParam int recipeNo) {
		//????????? ??????
		model.addAttribute("recipeDto", recipeDao.adminDetail(recipeNo));
		//????????? ?????? ??????
		model.addAttribute("recipeContentList", recipeContentDao.find(recipeNo));
		//????????? ?????? ??????
		model.addAttribute("recipeIngredientList", recipeIngredientDao.find(recipeNo));
		//????????? ????????? ?????? ??????
		model.addAttribute("recipeImgList", recipeImgDao.find(recipeNo));
		//????????? ???????????? ??????
		model.addAttribute("hashtagList", hashtagDao.list());
		return "admin/recipe-update";
	}
	
	@PostMapping("/recipe/update")
	public String update(
			@ModelAttribute RecipeDto recipeDto, 
			@RequestParam List<String> recipeContentText,
			@RequestParam List<Integer> recipeContentAttachmentNo,
			@RequestParam List<String> recipeIngredientName,
			@RequestParam List<Integer> recipeAttachmentNo,
			HttpSession session) {
		//recipe ????????????
		String loginNick = (String)session.getAttribute(SessionConstant.NICK);
		recipeDto.setRecipeNick(loginNick);
		recipeDao.adminUpdate(recipeDto);
		
		int recipeNo = recipeDto.getRecipeNo();
		
		//recipeContent ??? ????????? ?????? ??????
		recipeContentDao.adminDelete(recipeNo);
		//????????? ?????? ???????????? ???????????? ????????? ?????? ????????? ?????? ??????
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
		
		//recipeImg ??? ????????? ?????? ??????
		recipeImgDao.adminDelete(recipeNo);
		//????????? ????????? ???????????? ???????????? ?????? ??????
		for(int attachmentNo : recipeAttachmentNo) {
			RecipeImgDto imgDto = RecipeImgDto.builder()
						.recipeAttachmentNo(attachmentNo)
						.recipeNo(recipeNo)
					.build();
			recipeImgDao.insert(imgDto);
		}
		
		//recipeIngredient ??? ????????? ?????? ??????
		recipeIngredientDao.adminDelete(recipeNo);
		//????????? ?????? ???????????? ??????
		for(String ingredient : recipeIngredientName) {
			RecipeIngredientDto ingredientDto = RecipeIngredientDto.builder()
					.recipeIngredientName(ingredient)
					.recipeNo(recipeNo)
			.build();
			recipeIngredientDao.insert(ingredientDto);
		}
		
		return "redirect:detail/"+recipeNo;
	}
	
	@GetMapping("/recipe/delete/{recipeNo}")
	public String delete(@PathVariable int recipeNo) {
		recipeDao.delete(recipeNo);
		return "redirect:../list";
	}
	
	//????????? ???????????? ????????????
	@GetMapping("/notice/write")
	public String write() {
		return "admin/notice-insert";
	}
	
	@PostMapping("/notice/write")
	public String write(
			@ModelAttribute NoticeDto noticeDto,
			RedirectAttributes attr,
			HttpSession session) {
		String loginNick = (String)session.getAttribute(SessionConstant.NICK);
		noticeDto.setNoticeNick(loginNick);
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
	
	@GetMapping("/notice/list")
	public String noticeList(Model model) {
		model.addAttribute("noticeList", noticeDao.list());
		return "admin/notice-list";
	}
	
	@GetMapping("/notice/detail/{noticeNo}")
	public String noticeDetail(
			@PathVariable int noticeNo,
			Model model) {
		model.addAttribute("noticeDto", noticeDao.find(noticeNo));
		return "admin/notice-detail";
	}
	
	@GetMapping("/notice/update")
	public String noticeUpdate(
			@RequestParam int noticeNo,
			Model model) {
		NoticeDto findDto = noticeDao.find(noticeNo);
		model.addAttribute("noticeDto", findDto);
		return "admin/notice-update";
	}
	
	@PostMapping("/notice/update")
	public String noticeUpdate(
			@ModelAttribute NoticeDto noticeDto,
			RedirectAttributes attr) {
		noticeDao.update(noticeDto);
		return "redirect:detail/"+noticeDto.getNoticeNo();
	}
	
	@GetMapping("/delete/{noticeNo}")
	public String noticeDelete(@PathVariable int noticeNo) {
		noticeDao.delete(noticeNo);
		return "redirect:../list";
	}
	
	//????????? ?????? ????????????
	@GetMapping("/ingredient/list")
	public String ingredientList(
			@ModelAttribute(name="voPagination") ListSearchVO vo,
			Model model) {
		vo.setTable("ingredient");
		if(vo.getSort() == null) {
			vo.setSort("ingredient_name asc");
		}
		vo.setCount(adminDao.adminPostCount(vo));
		vo.setStartPost(vo.startRow());
		vo.setEndPost(vo.endRow());
		model.addAttribute("ingredientList", ingredientDao.adminList(vo));
		model.addAttribute("categoryList", categoryDao.adminList());
		return "admin/ingredient-list";
	}
	
	//????????? ????????? ????????????
	@GetMapping("/member/list")
	public String memberList(
			Model model, 
			@ModelAttribute(name="voPagination") ListSearchVO vo) {
		vo.setTable("member");
		if(vo.getSort() == null) {
			vo.setSort("member_id asc");
		}
		vo.setCount(adminDao.adminPostCount(vo));
		vo.setStartPost(vo.startRow());
		vo.setEndPost(vo.endRow());
		model.addAttribute("memberList", memberDao.adminList(vo));
		return "admin/member-list";
	}
	
	//????????? ????????? ????????????
	@GetMapping("/board/list")
	public String boardList(Model model) {
		model.addAttribute("boardList", boardDao.adminList(null));
		return "admin/board-list";
	}
	
	@GetMapping("/center/list")
	public String centerList(Model model) {
		model.addAttribute("centerList", centerDao.adminList());
		return "admin/center-list";
	}
	
	//????????? ????????? ??????
	@GetMapping("/board/detail/{boardNo}")
	public String boardDetail(@PathVariable int boardNo, Model model,
											HttpSession session) {
		
		//????????? ??????
		model.addAttribute("boardDto", boardDao.selectOne(boardNo));  //??????
		model.addAttribute("boardImgDto", boardImgDao.find(boardNo)); //?????????
		model.addAttribute("replyList",replyDao.selectList(boardNo)); //??????
		model.addAttribute("filesList", attachmentDao.selectBoardFileList(boardNo)); //????????????

		return "admin/board-detail";
		}
}