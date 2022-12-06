package com.kh.pj.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.BoardLikeDto;

@Repository
public class BoardLikeDaoImpl implements BoardLikeDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Override
	public void insert(BoardLikeDto dto) {
		String sql = "insert into board_like"
							+ "(board_like_id, board_like_no) values(?, ?)";
		Object[] param = {dto.getBoardLikeId(), dto.getBoardLikeNo()};
		jdbcTemplate.update(sql, param);
	}
	
	@Override
	public void delete(BoardLikeDto dto) {
		String sql = "delete board_like "
						+ "where board_like_id = ? and board_like_no = ?";
		Object[] param = {dto.getBoardLikeId(), dto.getBoardLikeNo()};
		jdbcTemplate.update(sql, param);
	}
	
	@Override
	public boolean check(BoardLikeDto dto) {
		String sql = "select count(*) from board_like "
							+ "where board_like_id = ? and board_like_no = ?";
		Object[] param = {dto.getBoardLikeId(), dto.getBoardLikeNo()};
		int count = jdbcTemplate.queryForObject(sql, int.class, param);
		return count == 1;//좋아요 상태면 1 아니면 0
	}
	
	@Override
	public int count(int boardLikeNo) {
		String sql = "select count(*) from board_like "
								+ "where board_like_no = ?";
		Object[] param = {boardLikeNo};
		return jdbcTemplate.queryForObject(sql, int.class, param);
	}
	
	@Override
	public void refresh(int boardNo) {
		String sql = "update board set board_like = ("
							+ "select count(*) from board_like "
							+ "where board_like_no = ?"
						+ ") where board_no = ?";
		Object[] param = {boardNo, boardNo};
		jdbcTemplate.update(sql, param);
	}
}
