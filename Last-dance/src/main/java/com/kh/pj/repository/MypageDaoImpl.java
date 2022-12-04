package com.kh.pj.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.BoardDto;
import com.kh.pj.entity.MemberDto;
import com.kh.pj.entity.RecipeDto;
import com.kh.pj.vo.MyLikeListCountVO;

@Repository
public class MypageDaoImpl implements MypageDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	//유저 정보
	@Override
	public MemberDto myInfo(String memberId) {
		
		return sqlSession.selectOne("mypage.userInfo", memberId);
	}

	//내가 최근에 본 레시피
	@Override
	public List<RecipeDto> viewRecipeList(String memberId) {
		
		return sqlSession.selectList("mypage.viewList", memberId);
	}
	
	//좋아요 한 레시피 리스트
	@Override
	public List<RecipeDto> likeRecipeList(String memberId) {
		
		return sqlSession.selectList("mypage.likeList", memberId);
	}
	
	//내가 쓴 글 리시트
	@Override
	public List<BoardDto> writeList(String memberId) {
		
		return sqlSession.selectList("mypage.myRrite", memberId);
	}
	
	
	//내가 좋아요 한 레시피
	@Override
	public MyLikeListCountVO myLikeListCount(String memberId) {
		
		return sqlSession.selectOne("mypage.myLikeListCount", memberId);
	}
	
	
}
