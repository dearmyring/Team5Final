package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.CategoryDto;
import com.kh.pj.vo.CategoryCountVO;

public interface CategoryDao {
	//카테고리 추가
	public void insert(CategoryDto catetoryDto);
	
	//카테고리 수정
	public boolean update(CategoryDto categoryDto);
	
	//카테고리 조회
	public List<CategoryDto> CategoryList(String CategoryMain);
	
	//카테고리 단일조회(통계용) -> 카테고리당 언급수 계산할 때 (나중에할게용)
	//public CategoryCountVO selectOne(String CategoryMain);
	
	//카테고리 삭제
	public boolean delete(String CategoryMain);
	

}
