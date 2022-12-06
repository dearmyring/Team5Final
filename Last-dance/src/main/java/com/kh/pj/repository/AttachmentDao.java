package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.AttachmentDto;

public interface AttachmentDao {
	int sequence();
	void insert(AttachmentDto attachmentDto);
	AttachmentDto find(int attachmentNo);
	
	
	boolean delete(int filesNo); //프라이머리키로 삭제
	List<AttachmentDto> selectBoardFileList(int boardAttachmentNo);
}
