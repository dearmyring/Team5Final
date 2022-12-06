package com.kh.pj.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.BoardDto;
import com.kh.pj.error.TargetNotFoundException;
import com.kh.pj.vo.BoardListVO;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Override
	public void write(BoardDto boardDto) {
		sqlSession.insert("board.insert", boardDto);
	}

	@Override
	public boolean edit(BoardDto boardDto) {
		int count = sqlSession.update("board.edit", boardDto);
		if (count == 0)
			throw new TargetNotFoundException();
		return count > 0;
	}

	@Override
	public boolean delete(int boardNo) {
		int count = sqlSession.delete("board.delete", boardNo);
		if (count == 0)
			throw new TargetNotFoundException();
		return count > 0;
	}

	@Override
	public BoardListVO find(int boardNo) {
		BoardListVO boardListVO = sqlSession.selectOne("board.get", boardNo);
		if (boardListVO == null)
			throw new TargetNotFoundException();
		return boardListVO;
	}


	@Override
	public List<BoardListVO> boardList(String memberNick) {
		return sqlSession.selectList("board.list");
	}

	
	
	@Override
	public BoardListVO click(int boardNo) {
		this.updateClickCount(boardNo);
		return this.find(boardNo);
	}

	@Override
	public boolean updateClickCount(int boardNo) {
		String sql = "update board set board_click = board_click + 1 where board_no=?";
		Object[] param = { boardNo };
		return jdbcTemplate.update(sql, param) > 0;
	}

}
