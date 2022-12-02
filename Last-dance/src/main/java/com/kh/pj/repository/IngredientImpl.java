package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.IngredientDto;

public class IngredientImpl implements IngredientDao {
	//재료 추가
	@Override
	public void insert(IngredientDto ingredientDto) {
		// TODO Auto-generated method stub
		
	}
  
	//재료 수정
	@Override
	public boolean update(IngredientDto ingredientDto) {
		// TODO Auto-generated method stub
		return false;
	}
	
	//재료 조회
	@Override
	public List<IngredientDto> IngredientList(String IngredientName) {
		// TODO Auto-generated method stub
		return null;
	}

	//재료 삭제
	@Override
	public boolean delete(String IngredientName) {
		// TODO Auto-generated method stub
		return false;
	}

}
