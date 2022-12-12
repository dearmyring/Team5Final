package com.kh.pj.repository;

import com.kh.pj.entity.AttachmentDto;

public interface AttachmentDao {
	public int sequence();
	public void insert(AttachmentDto attachmentDto);
	public AttachmentDto find(int attachmentNo);
	public void delete(int attachmentNo);
}
