package com.kh.pj.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.NoticeDto;

@Repository
public class NoticeDaoImpl implements NoticeDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int sequence() {
		return sqlSession.selectOne("notice.sequence");
	}

	@Override
	public void insert(NoticeDto noticeDto) {
		sqlSession.insert("notice.insert", noticeDto);
	}

	@Override
	public List<NoticeDto> list() {
		return sqlSession.selectList("notice.list");
	}

	@Override
	public NoticeDto find(int noticeNo) {
		return sqlSession.selectOne("notice.find", noticeNo);
	}

	@Override
	public void update(NoticeDto noticeDto) {
		sqlSession.update("notice.update", noticeDto);
	}
}
