package com.kh.pj.repository;


import java.util.List;

import com.kh.pj.vo.MainRecipeListTop5VO;
import com.kh.pj.vo.MainRecipeTop5MergingVO;
import com.kh.pj.vo.PushRecipeListVO;
import com.kh.pj.vo.RecipeTotalCountVO;
import com.kh.pj.vo.TodayMemberRankingVO;

public interface HomeDao {
	RecipeTotalCountVO counting(); 
	RecipeTotalCountVO todayCounting();
	TodayMemberRankingVO ranking();
	List<PushRecipeListVO> pushRecipe();
	List<MainRecipeTop5MergingVO> mainRecipeTop5();
}
