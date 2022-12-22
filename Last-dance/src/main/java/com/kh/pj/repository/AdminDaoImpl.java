package com.kh.pj.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.AdminDto;
import com.kh.pj.entity.MemberDto;
import com.kh.pj.vo.BoardTopFiveVO;
import com.kh.pj.vo.BoardViewTopFiveVO;
import com.kh.pj.vo.ListSearchVO;
import com.kh.pj.vo.MemberCountVO;
import com.kh.pj.vo.RecipeTopFiveVO;
import com.kh.pj.vo.RecipeViewTopFiveVO;
import com.kh.pj.vo.TrendingSearchesVO;

@Repository
public class AdminDaoImpl implements AdminDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public AdminDto login(String adminId) {
		return sqlSession.selectOne("admin.get", adminId);
	}

	@Override
	public int adminPostCount(ListSearchVO vo) {
		return sqlSession.selectOne("admin.adminPostCount", vo);
	}

	
	
	//관리자 메인페이지 시작!
	//최근 일주일 가입자 수
	@Override
	public List<MemberCountVO> memberCount() {
		return sqlSession.selectList("admin.memberCount");
	}
	
	//오늘의 인기검색어 1~10위
	@Override
	public List<TrendingSearchesVO> trendingSearches() {
		return sqlSession.selectList("admin.trendingSearches");
	}
	
	//오늘 가장 많은 좋아요 레시피 탑5
	@Override
	public List<RecipeTopFiveVO> recipeTodayLikeTopFive() {
		return sqlSession.selectList("admin.recipeTodayLikeTopFive");
	}
	
	//최근 일주일 조회 수 높은 레시피 탑5
	@Override
	public List<RecipeTopFiveVO> latelyTopViewRecipe() {
		return sqlSession.selectList("admin.latelyTopViewRecipe");
	}
	
	//오늘 최고 조회 수 레시피 탑5
	@Override
	public List<RecipeTopFiveVO> todayTopViewRecipe() {
		return sqlSession.selectList("admin.todayTopViewRecipe");
	}
	
	//최근 일주일 좋아요 레시피 탑5
	@Override
	public List<RecipeTopFiveVO> latelyTopLikeRecipe() {
		return sqlSession.selectList("admin.latelyTopLikeRecipe");
	}
	
	//오늘 가장 많은 게시글을 쓴 사람 탑5
	@Override
	public List<BoardTopFiveVO> todayTopWriter() {
		return sqlSession.selectList("admin.todayTopWriter");
	}
	
	//레벨별 회원 분포
	@Override
	public List<MemberDto> levelCount() {
		return sqlSession.selectList("member.adminList");
	}
	
	//레시피 TOP5(좋아요 많은 순 -> 조회수 많은 순)
	@Override
	public List<RecipeViewTopFiveVO> recipeTopFive() {
		return sqlSession.selectList("admin.recipeTopFive");
	}
		
	//게시글 TOP5(좋아요 많은 순 -> 조회수 많은 순)
	@Override
		public List<BoardViewTopFiveVO> boardTopFive() {
			return sqlSession.selectList("admin.boardTopFive");
		}	
	
	
	
}
