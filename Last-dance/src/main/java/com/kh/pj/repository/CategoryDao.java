package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.CategoryDto;
import com.kh.pj.vo.CategoryCountVO;

public interface CategoryDao {
	//카테고리 추가
	void insert(CategoryDto catetoryDto);
	
	//카테고리 수정
	boolean update(CategoryDto categoryDto);
	
	//카테고리 조회
	List<CategoryDto> CategoryList(String CategoryMain);
	
	//카테고리 단일조회(통계용) -> 카테고리당 언급수 계산할 때 (나중에할게용)
	//CategoryCountVO selectOne(String CategoryMain);
	
	//카테고리 삭제
	boolean delete(String CategoryMain);
	

}
