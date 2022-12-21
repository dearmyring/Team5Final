package com.kh.pj.restcontroller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.pj.entity.AdminDto;
import com.kh.pj.entity.MemberDto;
import com.kh.pj.repository.AdminDao;
import com.kh.pj.repository.RecipeDao;
import com.kh.pj.vo.BoardTopFiveVO;
import com.kh.pj.vo.ListSearchVO;
import com.kh.pj.vo.MemberCountVO;
import com.kh.pj.vo.RecipeTopFiveVO;
import com.kh.pj.vo.RecipeViewTopFiveVO;
import com.kh.pj.vo.TrendingSearchesVO;

@CrossOrigin(origins = "http://127.0.0.1:5500")
@RequestMapping("/rest")
@RestController
public class AdminRestController {

	@Autowired
	private AdminDao adminDao;
	
	@PostMapping("/admin")
	public String login(
			@RequestBody AdminDto adminDto) {
		AdminDto findDto = adminDao.login(adminDto.getAdminId());
		
		if(findDto == null) {
			return "fail";
		}
		
		if(findDto.getAdminPw().equals(adminDto.getAdminPw())) {
			return findDto.getAdminNick();
		}
		return "fail";
	}
	
	@PostMapping("/admin-count")
	public ListSearchVO adminCount(@RequestBody ListSearchVO vo) {
		vo.setCount(adminDao.adminPostCount(vo));
		vo.setFirstBlock(vo.startBlock());
		vo.setLastBlock(vo.endBlock());
		vo.setHavePrev(vo.hasPrev());
		vo.setHaveNext(vo.hasNext());
		return vo;
	}
	
	//최근 일주일 가입자 수
	@GetMapping("member-count")
	public List<MemberCountVO>  memberCount() {
		return  adminDao.memberCount();
	}
	
	//오늘의 인기 검색어 1~10위
	@GetMapping("trending-searches")
	public List<TrendingSearchesVO> trendingSearches() {
		return adminDao.trendingSearches();
	}
	
	//오늘 가장 많은 좋아요 레시피 탑5
	@GetMapping("recipe-today-like-top")
	public List<RecipeTopFiveVO> recipeTodayLikeTopFive() {
		return adminDao.recipeTodayLikeTopFive();
	}
	
	//최근 일주일 조회 수 높은 레시피 탑5
	@GetMapping("lately-top-view-recipe")
	public List<RecipeTopFiveVO> latelyTopViewRecipe() {
		return adminDao.latelyTopViewRecipe();
	}
	
	//오늘 최고 조회 수 레시피 탑5
	@GetMapping("today-top-view-recipe")
	public List<RecipeTopFiveVO> todayTopViewRecipe() {
		return adminDao.todayTopViewRecipe();
	}
	
	//최근 일주일 좋아요 레시피 탑5
	@GetMapping("lately-top-like-recipe")
	public List<RecipeTopFiveVO> latelyTopLikeRecipe() {
		return adminDao.latelyTopLikeRecipe();
	}
	
	//오늘 가장 많은 게시글을 쓴 사람 탑5
	@GetMapping("today-top-writer")
	public List<BoardTopFiveVO> todayTopWriter() {
		return adminDao.todayTopWriter();
	}
	
	//레벨별 회원 분포
	@GetMapping("level-count")
	public List<MemberDto> levelCount() {
		return adminDao.levelCount();
	}
	
	
	
}

