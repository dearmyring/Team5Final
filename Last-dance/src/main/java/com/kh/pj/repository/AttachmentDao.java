package com.kh.pj.repository;

import com.kh.pj.entity.AttachmentDto;

public interface AttachmentDao {
	int sequence();
	void insert(AttachmentDto attachmentDto);
	AttachmentDto find(int attachmentNo);
}
