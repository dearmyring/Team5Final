package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.AttachmentDto;
import com.kh.pj.entity.BoardDto;
import com.kh.pj.entity.MemberDto;
import com.kh.pj.entity.ProfileImageDto;
import com.kh.pj.entity.RecipeDto;
import com.kh.pj.vo.MyLikeListCountVO;

public interface MypageDao {
	
	//유저 정보 출력
	public MemberDto myInfo(String memberId);
	
	//프로필 사진 출력
	public AttachmentDto profileImg(String memberId);
	
	//프로필 사진 등록
	public void addProfileImage(ProfileImageDto profileImageDto);
	
	//프로필 사진 변경
	public boolean editProfileImage(ProfileImageDto profileImageDto);
	
	//유저 정보 변경
	public boolean myInfoEdit(MemberDto memberDto);
	
	//회원 탈퇴
	public boolean memberWithdrawal(String memberId);
	
	//최근 본 레시피 리스트
	public List<RecipeDto> viewRecipeList(String memberId);
	//좋아요 한 레시피 리스트
	public List<RecipeDto> likeRecipeList(String memberId);
	//내가 쓴 글 리시트
	public List<BoardDto> writeList(String memberId);
	
	//내가 좋아요 한 글
	public MyLikeListCountVO myLikeListCount(String memberId);
	
	//비밀번호 확인
	public String pwConfirm(String memberId);

}
