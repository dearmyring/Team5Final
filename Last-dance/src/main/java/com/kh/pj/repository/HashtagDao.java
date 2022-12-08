package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.HashtagDto;

public interface HashtagDao {
	//해시태그 추가
	public void insert(HashtagDto hashtagDto);
	
	//해시태그 수정
	public boolean update(HashtagDto hashtagDto);
	
	//해시태그 조회
	public List<HashtagDto> selectHashtagList();
	
//	//해시태그 선택 관련 리스트 조회?출력?
//	public List<HashtagListVO> selectHashtagList(String hashtagName);
	
	
	//해시태그 단일조회 -> 해시태그 언급수 계산할 때 (나중에 할게용)
	//public HashtagCountVO selectOne(String HashtagName);
	
	//해시태그 삭제
	public boolean delete(String hashtagName);

	//관리자 레시피 등록시 해시태그 리스트 조회
	public List<HashtagDto> list();
}
