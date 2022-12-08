package com.kh.pj.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.AttachmentDto;

@Repository
public class AttachmentDaoImpl implements AttachmentDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("attachment.sequence");
	}

	@Override
	public void insert(AttachmentDto attachmentDto) {
		sqlSession.insert("attachment.insert", attachmentDto);
	}

	@Override
	public AttachmentDto find(int attachmentNo) {
		return sqlSession.selectOne("attachment.find", attachmentNo);
	}

	@Override
	public void delete(int attachmentNo) {
		sqlSession.delete("attachment.delete", attachmentNo);
	}
}
