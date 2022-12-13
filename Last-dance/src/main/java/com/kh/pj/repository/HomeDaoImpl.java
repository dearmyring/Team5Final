package com.kh.pj.repository;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pj.vo.MainRecipeTop5MergingVO;
import com.kh.pj.vo.PushRecipeListVO;
import com.kh.pj.vo.RecipeTotalCountVO;
import com.kh.pj.vo.TodayMemberRankingVO;

@Repository
public class HomeDaoImpl implements HomeDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public RecipeTotalCountVO counting() {
		return sqlSession.selectOne("home.totalCount");
	}
	
	@Override
	public RecipeTotalCountVO todayCounting() {
		return sqlSession.selectOne("home.todayAddCount");
	}
	
	@Override
	public TodayMemberRankingVO ranking() {
		return sqlSession.selectOne("home.todayMemberRanking"); 
	}
	
	@Override
	public List<PushRecipeListVO> pushRecipe() {
		return sqlSession.selectList("home.pushRecipeForMain");
	}
	
	@Override
	public List<MainRecipeTop5MergingVO> mainRecipeTop5() {
		return sqlSession.selectList("home.mainRecipeTop5");
	}
}
