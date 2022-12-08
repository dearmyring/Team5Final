package com.kh.pj.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.AttachmentDto;
import com.kh.pj.entity.BoardDto;
import com.kh.pj.entity.MemberDto;
import com.kh.pj.entity.ProfileImageDto;
import com.kh.pj.entity.RecipeDto;
import com.kh.pj.vo.RecipeListVO;

@Repository
public class MypageDaoImpl implements MypageDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	//유저 정보
	@Override
	public MemberDto myInfo(String memberId) {
		
		return sqlSession.selectOne("mypage.userInfo", memberId);
	}
	
	//프로필 이미지 출력
	@Override
	public AttachmentDto profileImg(String memberId) {
		
		return sqlSession.selectOne("mypage.profileImg", memberId);
	}
	
	//프로필 이미지 등록
	@Override
	public void addProfileImage(ProfileImageDto profileImageDto) {
		sqlSession.insert("mypage.addProfileImage", profileImageDto);
		
	}
	
	//프로필 이미지 수정
	@Override
	public boolean editProfileImage(ProfileImageDto profileImageDto) {
		int result = sqlSession.update("mypage.edtiProfileImage", profileImageDto);
		return result > 0;
	}
	
	//유저 정보 변경(비밀번호 포함)
	@Override
	public boolean myInfoEdit(MemberDto memberDto) {
		String encode = passwordEncoder.encode(memberDto.getMemberPw());
		memberDto.setMemberPw(encode);
		
		int result = sqlSession.update("mypage.editInfo", memberDto);
		
		return result > 0;
	}
	
	//유저 정보 변경(비밀번호 미포함)
	@Override
	public boolean myInfoEdit2(MemberDto memberDto) {
		int result = sqlSession.update("mypage.editInfo2", memberDto);
		return result > 0;
	}
	
	
	//회원 탈퇴
	@Override
	public boolean memberWithdrawal(String memberId) {
		int result = sqlSession.delete("mypage.memberWithdrawal", memberId);
		
		return result > 0;
	}
	

	//내가 최근에 본 레시피
	@Override
	public List<RecipeListVO> viewRecipeList(String memberId) {
		
		return sqlSession.selectList("mypage.viewList", memberId);
	}
	
	//좋아요 한 레시피 리스트
	@Override
	public List<RecipeListVO> likeRecipeList(String memberId) {
		
		return sqlSession.selectList("mypage.likeRecipeList", memberId);
	}
	
	//내가 쓴 글 리스트
	@Override
	public List<BoardDto> writeList(String memberId) {
		
		return sqlSession.selectList("mypage.myRrite", memberId);
	}
	
	
	//내가 좋아요 한 레시피 카운트
	@Override
	public int myLikeListCount(String memberId) {
		
		return sqlSession.selectOne("mypage.myLikeListCount", memberId);
	}
	
	//내가 쓴 글 카운트
	@Override
	public int myWriteCount(String memberId) {
		
		return sqlSession.selectOne("mypage.myWriteCount", memberId);
	}
	
	//내가 읽은 레시피 카운트
	@Override
	public int readRecipeCount(String memberId) {
		
		return sqlSession.selectOne("mypage.readRecipeCount", memberId);
	}
	
	//비밀번호 확인
	@Override
	public MemberDto pwConfirm(String memberId) {
		
		return sqlSession.selectOne("mypage.pwConfirm", memberId);
	}
	
	
}
