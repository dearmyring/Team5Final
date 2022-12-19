package com.kh.pj.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.MemberDto;
import com.kh.pj.vo.ListSearchVO;

@Repository
public class MemberDaoImpl implements MemberDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Override
	public void Join(MemberDto memberDto) {
		String memberPw = memberDto.getMemberPw();
		String enc = encoder.encode(memberPw);
		memberDto.setMemberPw(enc);
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
	
	@Override
	public boolean updateLoginTime(String memberId) {
		int result = sqlSession.update("member.updateLoginTime", memberId);
		return result > 0;
	}
	
	@Override
	public boolean editPw(MemberDto memberDto) {
		String enc = encoder.encode(memberDto.getMemberPw());
		memberDto.setMemberPw(enc);
		int result = sqlSession.update("member.editPw", memberDto);
		return result > 0;
	}

	@Override
	public List<MemberDto> adminList(ListSearchVO vo) {
		return sqlSession.selectList("member.adminList");
	}
}
