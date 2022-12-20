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
import com.kh.pj.entity.BoardLikeDto;
import com.kh.pj.entity.NoticeDto;
import com.kh.pj.entity.RecipeContentDto;
import com.kh.pj.entity.RecipeDto;
import com.kh.pj.entity.RecipeImgDto;
import com.kh.pj.entity.RecipeIngredientDto;
import com.kh.pj.repository.AdminDao;
import com.kh.pj.repository.AttachmentDao;
import com.kh.pj.repository.BoardDao;
import com.kh.pj.repository.BoardImgDao;
import com.kh.pj.repository.BoardLikeDao;
import com.kh.pj.repository.CategoryDao;
import com.kh.pj.repository.HashtagDao;
import com.kh.pj.repository.IngredientDao;
import com.kh.pj.repository.MemberDao;
import com.kh.pj.repository.NoticeDao;
import com.kh.pj.repository.RecipeContentDao;
import com.kh.pj.repository.RecipeDao;
import com.kh.pj.repository.RecipeImgDao;
import com.kh.pj.repository.RecipeIngredientDao;
import com.kh.pj.repository.ReplyDao;
import com.kh.pj.vo.IngredientListSearchVO;
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
	private BoardImgDao boardImgDao;
	
	@Autowired
	private ReplyDao replyDao;
	
	@Autowired
	private AttachmentDao attachmentDao;
	
	@Autowired
	private BoardLikeDao boardLikeDao;
	
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
		session.setAttribute(SessionConstant.NICK, adminDao.login(adminDto.getAdminId()).getAdminNick());
		
		return "redirect:/admin/";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute(SessionConstant.ID);
		session.removeAttribute(SessionConstant.NICK);
		
		return "redirect:/admin/login";
	}
	
	//관리자 레시피 컨트롤러
	@GetMapping("/recipe/list")
	public String list(
			@ModelAttribute(name="voPagination") ListSearchVO vo, 
			Model model) {
		vo.setTable("recipe");
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
		//레시피 번호 뽑아서 넣기
		int recipeNo = recipeDao.recipeSequence();
		recipeDto.setRecipeTitle(recipeDto.getRecipeTitle().replace(" ", ""));
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
	
	@GetMapping("/recipe/update")
	public String update(
			Model model,
			@RequestParam int recipeNo) {
		//레시피 정보
		model.addAttribute("recipeDto", recipeDao.adminDetail(recipeNo));
		//레시피 내용 정보
		model.addAttribute("recipeContentList", recipeContentDao.find(recipeNo));
		//레시피 재료 정보
		model.addAttribute("recipeIngredientList", recipeIngredientDao.find(recipeNo));
		//레시피 썸네일 사진 정보
		model.addAttribute("recipeImgList", recipeImgDao.find(recipeNo));
		//레시피 해시태그 정보
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
		//recipe 업데이트
		String loginNick = (String)session.getAttribute(SessionConstant.NICK);
		recipeDto.setRecipeNick(loginNick);
		recipeDao.adminUpdate(recipeDto);
		
		int recipeNo = recipeDto.getRecipeNo();
		
		//recipeContent 다 지우고 다시 넣기
		recipeContentDao.adminDelete(recipeNo);
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
		
		//recipeImg 다 지우고 다시 넣기
		recipeImgDao.adminDelete(recipeNo);
		//레시피 썸네일 개수만큼 반복해서 사진 첨부
		for(int attachmentNo : recipeAttachmentNo) {
			RecipeImgDto imgDto = RecipeImgDto.builder()
						.recipeAttachmentNo(attachmentNo)
						.recipeNo(recipeNo)
					.build();
			recipeImgDao.insert(imgDto);
		}
		
		//recipeIngredient 다 지우고 다시 넣기
		recipeIngredientDao.adminDelete(recipeNo);
		//레시피 재료 개수만큼 첨부
		for(String ingredient : recipeIngredientName) {
			RecipeIngredientDto ingredientDto = RecipeIngredientDto.builder()
					.recipeIngredientName(ingredient)
					.recipeNo(recipeNo)
			.build();
			recipeIngredientDao.insert(ingredientDto);
		}
		
		return "redirect:detail/"+recipeNo;
	}
	
	@GetMapping("/delete/{recipeNo}")
	public String delete(@PathVariable int recipeNo) {
		recipeDao.delete(recipeNo);
		return "redirect:../list";
	}
	
	//관리자 공지사항 컨트롤러
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
	
	//관리자 재료 컨트롤러
	@GetMapping("/ingredient/list")
	public String ingredientList(Model model) {
		IngredientListSearchVO vo = IngredientListSearchVO.builder().build();
		model.addAttribute("ingredientList", ingredientDao.adminList(vo));
		model.addAttribute("categoryList", categoryDao.adminList());
		return "admin/ingredient-list";
	}
	
	//관리자 사용자 컨트롤러
	@GetMapping("/member/list")
	public String memberList(Model model) {
		model.addAttribute("memberList", memberDao.adminList());
		return "admin/member-list";
	}
	
	//관리자 게시판 컨트롤러
	@GetMapping("/board/list")
	public String boardList(Model model) {
		model.addAttribute("boardList", boardDao.boardList(null));
		return "admin/board-list";
	}
	
	//관리자 게시판 상세
	@GetMapping("/board/detail/{boardNo}")
	public String boardDetail(@PathVariable int boardNo, Model model,
											HttpSession session) {
		
		//모델로 첨부
		model.addAttribute("boardDto", boardDao.selectOne(boardNo));  //상세
		model.addAttribute("boardImgDto", boardImgDao.find(boardNo)); //이미지
		model.addAttribute("replyList",replyDao.selectList(boardNo)); //댓글
		model.addAttribute("filesList", attachmentDao.selectBoardFileList(boardNo)); //첨부파일

		return "admin/board-detail";
		}
		
}
