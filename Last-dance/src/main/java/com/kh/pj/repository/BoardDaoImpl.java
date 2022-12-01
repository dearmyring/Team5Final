package com.kh.pj.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.BoardDto;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(BoardDto boardDto) {
		sqlSession.insert("board.insert",boardDto);
	}
	
	@Override
	public List<BoardDto> selectList() {
		return sqlSession.selectList("board.list");
	}
	
	
	@Override
	public BoardDto selectOne(int boardNo) {
		return sqlSession.selectOne("board.get",boardNo);
	}

	@Override
	public boolean edit(BoardDto boardDto) {
		
		return false;
	}

	@Override
	public boolean delete(int boardDto) {
		// TODO Auto-generated method stub
		return false;
	}

}
