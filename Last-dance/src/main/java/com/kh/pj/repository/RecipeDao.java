package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.RecipeDto;
import com.kh.pj.entity.RecipeLikeDto;
import com.kh.pj.entity.RecipeViewDto;
import com.kh.pj.vo.RecipeCountVO;
import com.kh.pj.vo.RecipeDetailVO;
import com.kh.pj.vo.RecipeListSearchVO;
import com.kh.pj.vo.RecipeListVO;

public interface RecipeDao {
	//레시피 등록
	public void write(RecipeDto recipeDto);
	
	//레시피 등록을 위한 시퀀스 번호 반환
	public int recipeSequence();
	
	//레시피 수정
	public boolean update(RecipeDto recipeDto);
	
	//레시피 삭제
	public boolean delete(int recipeNo);
	
	//레시피 상세
	public RecipeDto selectOne(int recipeNo);
	
	//레시피 조회수 증가
	public RecipeDto click(int noticeNo);
	public boolean updateClickCount(int noticeNo);
	
	//관리자 레시피 조회
	public List<RecipeDto> adminList(RecipeListSearchVO vo);
	public RecipeDto adminDetail(int recipeNo);
	public void adminUpdate(RecipeDto recipeDto);
	
	//레시피 리스트 출력
	public List<RecipeListVO> recipeList();
//	
//	//재료별 레시피 갯수 출력
//	public int searchCount(String keyword)throws Exception;
	
	
	
	
	//여기부터 레시피 디테일
	
	//레시피 상세페이지 출력
	RecipeDetailVO selectDetail(int recipeNo);
	
	//내가 본 레시피 조회
	RecipeViewDto myViewRecipe(RecipeViewDto recipeViewDto);
	
	//내가 본 레시피 등록
	void insertRecipeView(RecipeViewDto recipeViewDto);
	
	//내가 본 레시피 시간 업데이트
	boolean updateRecipeViewTime(RecipeViewDto recipeViewDto);
	
	//레시피 좋아요 확인
	RecipeLikeDto recipeLikeOne(RecipeLikeDto dto);
	
	//좋아요 업
	boolean likeUp(int recipeNo);
	
	//좋아요 다운
	boolean likeDown(int recipeNo);
	
	//레시피 라이크 테이블 등록
	void addLike(RecipeLikeDto dto);
	
	//레시피 라이크 테이블 삭제
	boolean removeLike(RecipeLikeDto dto);
	
	//레시피 개수 출력
	int countLike(int recipeNo);
	

}