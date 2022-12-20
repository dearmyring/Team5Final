package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.AdminDto;
import com.kh.pj.vo.BoardTopFiveVO;
import com.kh.pj.vo.ListSearchVO;
import com.kh.pj.vo.MemberCountVO;
import com.kh.pj.vo.RecipeTopFiveVO;
import com.kh.pj.vo.RecipeViewTopFiveVO;
import com.kh.pj.vo.TrendingSearchesVO;
import com.kh.pj.vo.ListSearchVO2;

public interface AdminDao {
	public AdminDto login(String adminId);
	public int adminPostCount(ListSearchVO vo);

	
	//관리자 메인페이지 시작!
	//최근 일주일 가입자 수
	List<MemberCountVO> memberCount();
	//오늘의 인기검색어 1~10위
	List<TrendingSearchesVO> trendingSearches();
	//오늘 가장 많은 좋아요 레시피 탑5
	List<RecipeTopFiveVO> recipeTodayLikeTopFive();
	//최근 일주일 조회 수 높은 레시피 탑5
	List<RecipeTopFiveVO> latelyTopViewRecipe();
	//오늘 최고 조회 수 레시피 탑5
	List<RecipeTopFiveVO> todayTopViewRecipe();
	//최근 일주일 좋아요 레시피 탑5
	List<RecipeTopFiveVO> latelyTopLikeRecipe();
	//오늘 가장 많은 게시글을 쓴 사람 탑5
	List<BoardTopFiveVO> todayTopWriter();
	
	//레시피 TOP5(좋아요 많은 순 -> 조회수 많은 순)
	List<RecipeViewTopFiveVO> recipeTopFive();
 	
	public int adminBoardCount(ListSearchVO2 vo2);
}
