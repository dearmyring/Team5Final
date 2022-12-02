package com.kh.pj.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void Join(MemberDto memberDto) {
		sqlSession.insert("member.join", memberDto);
	}
	
	@Override
	public MemberDto selectOneId(String memberId) {
		return sqlSession.selectOne("member.getId", memberId);
	}
	
	@Override
	public MemberDto selectOneNick(String memberNick) {
		return sqlSession.selectOne("member.getNick", memberNick);
	}
	
	@Override
	public MemberDto selectOnePhone(String memberPhone) {
		return sqlSession.selectOne("member.getPhone", memberPhone);
	}
}
