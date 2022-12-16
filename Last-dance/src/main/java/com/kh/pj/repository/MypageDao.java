package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.AttachmentDto;
import com.kh.pj.entity.BoardDto;
import com.kh.pj.entity.MemberDto;
import com.kh.pj.entity.ProfileImageDto;
import com.kh.pj.entity.RecipeDto;
import com.kh.pj.vo.BoardListAddImgVO;
import com.kh.pj.vo.RecipeListVO;

public interface MypageDao {
	
	//유저 정보 출력
	MemberDto myInfo(String memberId);
	
	//프로필 사진 출력
	AttachmentDto profileImg(String memberId);
	
	//프로필 사진 등록
	void addProfileImage(ProfileImageDto profileImageDto);
	
	//프로필 사진 변경
	boolean editProfileImage(ProfileImageDto profileImageDto);
	
	//유저 정보 변경(비밀번호 포함)
	boolean myInfoEdit(MemberDto memberDto);
	//유저 정보 변경(비밀번호 미포함)
	boolean myInfoEdit2(MemberDto memberDto);
	
	//회원 탈퇴
	boolean memberWithdrawal(String memberId);
	
	//최근 본 레시피 리스트
	//List<RecipeDto> viewRecipeList(String memberId);
	List<RecipeListVO> viewRecipeList(String memberId);
	//좋아요 한 레시피 리스트
	//List<RecipeDto> likeRecipeList(String memberId);
	List<RecipeListVO> likeRecipeList(String memberId);
	//내가 쓴 글 리스트
	List<BoardListAddImgVO> writeList(String memberId);
	
	//내가 좋아요 한 글 카운트
	int myLikeListCount(String memberId);
	//내가 쓴 글 카운트
	int myWriteCount(String memberId);
	//내가 읽은 레시피 카운트
	int readRecipeCount(String memberId);
	
	//비밀번호 확인
	MemberDto pwConfirm(String memberId);

}
