package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.IngredientDto;
import com.kh.pj.vo.IngredientListSearchVO;

public interface IngredientDao {
	//재료 추가
	public void insert(IngredientDto ingredientDto);
	
	//재료 수정
	public boolean update(IngredientDto ingredientDto);
	
	//재료 조회
	public List<IngredientDto> IngredientList(String IngredientName);
	
//	//재료 가져오기
//	IngredientDto findIngredient(String ingredientName);
	
	//재료 삭제
	public boolean delete(String IngredientName);

	//재료 전체 조회 - 관리자 레시피 등록 시 출력용
	List<IngredientDto> adminList(IngredientListSearchVO vo);
	List<String> cate();
	String adminSelect(String ingredientName);
	
	//재료 전체 조회 - 검색어 등록시 출력용
	List<String> searchList(String search);
	


}
