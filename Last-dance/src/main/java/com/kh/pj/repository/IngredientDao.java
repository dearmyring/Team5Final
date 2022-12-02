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
	
	//재료 삭제
	boolean delete(String IngredientName);

}
