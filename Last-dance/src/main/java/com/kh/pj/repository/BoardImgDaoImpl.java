package com.kh.pj.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.BoardImgDto;

@Repository
public class BoardImgDaoImpl implements BoardImgDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(BoardImgDto boardImgDto) {
		sqlSession.insert("boardImg.insert", boardImgDto);
	}

	@Override
	public BoardImgDto find(int boardNo) {
		return sqlSession.selectOne("boardImg.find", boardNo);
	}
	
	//썸네일 변경
		@Override
		public boolean editThumbnail(BoardImgDto boardImgDto) {
			int result = sqlSession.update("boardImg.editThumbnail", boardImgDto);
			return result > 0;
		}
}
