package com.kh.pj.repository;

import java.util.List;

import com.kh.pj.entity.BoardDto;
import com.kh.pj.entity.BoardLikeDto;
import com.kh.pj.entity.MemberDto;
import com.kh.pj.entity.NoticeDto;
import com.kh.pj.vo.BoardListSearchVO;
import com.kh.pj.vo.BoardListVO;

public interface BoardDao {
   
   int sequence();//시퀀스 발행 메소드
   
   public List<BoardListVO> boardList(BoardListSearchVO vo);
   public List<NoticeDto>noticeList(NoticeDto noticeDto);
   
   public void write(BoardDto boardDto);
   boolean edit(BoardDto boardDto);
   boolean delete(int boardNo);
   
   public void updatePoint(MemberDto memberDto);//회원 포인트 업데이트
   public void deletePoint(MemberDto memberDto);//회원 포인트 삭제
   public int boardCNT(MemberDto memberDto);//유저 게시판 등록 카운트(당일)
   public int replyCNT(MemberDto memberDto);//댓글 수 등록 카운트
   public int boardTotal(BoardListSearchVO vo);//게시글 총 카운트
   
   //상세,좋아요
   public BoardListVO selectOne(int boardNo);
   BoardListVO click(int boardNo);
   boolean updateClickCount(int boardNo);

   //첨부파일 관련 기능
      void connectAttachment(int boardOriginNo, int boardAttachmentNo);
      int insert2(BoardDto boardDto);
      
   //관리자 유저게시판 조회
      public List<BoardDto> adminList(BoardListSearchVO vo);
   //관리자 유저게시글 블라인드
      boolean blind(BoardDto boardDto);
      

      
      
      //레시피 좋아요 확인
      BoardLikeDto boardLikeOne(BoardLikeDto dto);
      
      //좋아요 업
      boolean likeUp(int boardNo);
      
      //좋아요 다운
      boolean likeDown(int boardNo);
      
      //게시판 라이크 테이블 등록
      void addLike(BoardLikeDto dto);
      
      //게시판 라이크 테이블 삭제
      boolean removeLike(BoardLikeDto dto);
      
      //게시판 개수 출력
      int countLike(int boardNo);

}