package com.kh.pj.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.BoardDto;
import com.kh.pj.vo.BoardVO;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void write(BoardDto boardDto){
		sqlSession.insert("board.insert",boardDto);
	}

	@Override
	public List<BoardVO> list() {
		return sqlSession.selectList("board.list");
	}

	@Override
	public boolean edit(BoardDto boardDto) {
		int count = sqlSession.update("board.edit",boardDto);
		return count>0;
	}

	@Override
	public boolean delete(int boardNo) {
		int count = sqlSession.delete("board.delete",boardNo);
		return count>0;
	}

	@Override
	public BoardVO find(int boardNo) {
		return sqlSession.selectOne("board.detail",boardNo);
	}

}
