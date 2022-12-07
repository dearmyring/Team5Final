package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.IngredientDto;

public interface IngredientDao {
	//재료 추가
	public void insert(IngredientDto ingredientDto);
	
	//재료 수정
	public boolean update(IngredientDto ingredientDto);
	
	//재료 조회
	public List<IngredientDto> IngredientList(String IngredientName);
	
	//재료 삭제
	public boolean delete(String IngredientName);

	//재료 전체 조회 - 관리자 레시피 등록 시 출력용
	public List<String> list(String search);
	public List<String> cate();
}
