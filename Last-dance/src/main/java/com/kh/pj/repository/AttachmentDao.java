package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.AttachmentDto;

public interface AttachmentDao {


	int sequence();
	void insert(AttachmentDto attachmentDto);
	AttachmentDto find(int attachmentNo);
	
	
	public void delete(int attachmentNo);
	List<AttachmentDto> selectBoardFileList(int boardAttachmentNo);


}
