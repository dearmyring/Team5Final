package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.IngredientDto;

public interface IngredientDao {
	//재료 추가
	void insert(IngredientDto ingredientDto);
	
	//재료 수정
	boolean update(IngredientDto ingredientDto);
	
	//재료 조회
	List<IngredientDto> IngredientList(String IngredientName);
	
//	//재료 가져오기
//	IngredientDto findIngredient(String ingredientName);
	
	//재료 삭제
	boolean delete(String IngredientName);

	//재료 전체 조회 - 관리자 레시피 등록 시 출력용
	List<String> list(String search);
	List<String> cate();
	
	//재료 전체 조회 - 검색어 등록시 출력용
	List<String> searchList(String search);
	

}
