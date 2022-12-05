package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.AttachmentDto;

public interface AttachmentDao {

	int sequence();  //시퀀스번호 미리 생성
	
	void insert(AttachmentDto attachmentDto); //삽입 
	List<AttachmentDto> selectList(); 
	AttachmentDto selectOne(int attachmentNo);//프라이머리키로 조회
	boolean delete(int attachmentNo); //프라이머리키로 삭제

//	List<AttachmentDto> selectBoardFileList(int boardAttachmentNo);


}
