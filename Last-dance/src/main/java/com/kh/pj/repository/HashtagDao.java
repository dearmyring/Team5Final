package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.HashtagDto;

public interface HashtagDao {
	//해시태그 추가
	void insert(HashtagDto hashtagDto);
	
	//해시태그 수정
	boolean update(HashtagDto hashtagDto);
	
	//해시태그 조회
	List<HashtagDto> HashtagList(String HashtagName);
	
	//해시태그 단일조회 -> 해시태그 언급수 계산할 때 (나중에 할게용)
	//HashtagCountVO selectOne(String HashtagName);
	
	//해시태그 삭제
	boolean delete(String HaghtagName);

	//관리자 레시피 등록시 해시태그 리스트 조회
	List<HashtagDto> list();
}
