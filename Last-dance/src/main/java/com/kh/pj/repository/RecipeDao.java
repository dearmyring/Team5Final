package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.RecipeDto;
import com.kh.pj.vo.RecipeCountVO;
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
	
<<<<<<< HEAD
	//재료별 레시피 리스트 출력
	List<RecipeListVO> recipeList(String ingredientName);
	
	//재료별 레시피 갯수 출력
	List<RecipeCountVO> selectRecipeList();

=======
>>>>>>> refs/remotes/origin/main
	//관리자 레시피 조회
	public List<RecipeDto> adminList(RecipeListSearchVO vo);
	public RecipeDto adminDetail(int recipeNo);
<<<<<<< HEAD
=======
	
	//레시피 리스트 출력
	public List<RecipeListVO> recipeList();
	
	//재료별 레시피 갯수 출력
	public List<RecipeCountVO> selectRecipeList();

>>>>>>> refs/remotes/origin/main
}
