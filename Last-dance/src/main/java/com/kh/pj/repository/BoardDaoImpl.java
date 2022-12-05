package com.kh.pj.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.BoardDto;
import com.kh.pj.vo.BoardListSearchVO;
import com.kh.pj.vo.BoardListVO;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	private SqlSession sqlSession;

	
	@Override
	public boolean edit(BoardDto boardDto) {
		String sql = "update board set board_title=?, board_content=? where board_no=?";
		Object[] param = {
			boardDto.getBoardTitle(), boardDto.getBoardContent(), boardDto.getBoardNo()
		};
		
	return jdbcTemplate.update(sql, param) > 0;
	}
	
	@Override
	public boolean delete(int boardNo) {
		String sql = "delete board where board_no = ?";
		Object[] param = {boardNo};
		return jdbcTemplate.update(sql,param) > 0;
	}


	// 여기서부터 jdbc 사용해서 게시판 구현

	private RowMapper<BoardListVO> listMapper = new RowMapper<BoardListVO>() {
		@Override
		public BoardListVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			return BoardListVO.builder().boardNo(rs.getInt("board_no")).memberNick(rs.getString("member_nick"))
					.boardId(rs.getString("board_id")).boardTitle(rs.getString("board_title"))
					.boardContent(rs.getString("board_content")).boardClick(rs.getInt("board_click"))
					.boardLike(rs.getInt("board_like")).boardWriteTime(rs.getDate("board_write_time"))
					.boardEditTime(rs.getDate("board_edit_time")).boardBlind(rs.getString("board_blind"))
					.member_badge(rs.getString("board_badge")).replyNo(rs.getInt("reply_no")).build();
		}
	};

	@Override
	public List<BoardListVO> selectList(BoardListSearchVO vo) {
		if (vo.isSearch()) {// 검색이라면
			return search(vo);
		} else {// 목록이라면
			return list(vo);
		}
	}

	@Override
	public List<BoardListVO> list(BoardListSearchVO vo) {
		String sql = "";//리스트 조인문 sql작성
		Object[] param = { vo.startRow(), vo.endRow() };
		return jdbcTemplate.query(sql, listMapper, param);
	}

	@Override
	public List<BoardListVO> search(BoardListSearchVO vo) {
		String sql = "";// 검색 조인문 sql문 추가해야함
		sql = sql.replace("#1", vo.getType());
		Object[] param = { vo.getKeyword(), vo.startRow(), vo.endRow() };
		return jdbcTemplate.query(sql, listMapper, param);
	}

	@Override
	public int count(BoardListSearchVO vo) {
		if (vo.isSearch()) {// 검색이라면
			return searchCount(vo); // 검색 카운트 구하는 메소드
		} else {
			return listCount(vo);
		}
	}

	@Override
	public int searchCount(BoardListSearchVO vo) {
		String sql = "select count(*) from board where instr(#1, ?) > 0";
		sql = sql.replace("#1", vo.getType());
		Object[] param = { vo.getKeyword() };
		return jdbcTemplate.queryForObject(sql, int.class, param);
	}

	@Override
	public int listCount(BoardListSearchVO vo) {
		String sql = "select count(*) from board";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	// 조회수
	@Override
	public boolean updateReadcount(int boardNo) {
		String sql = "update board set board_view_cnt = " + "board_view_cnt + 1 " + "where board_no = ?";
		Object[] param = { boardNo };
		return jdbcTemplate.update(sql, param) > 0;
	}
	
	@Override
	public void connectFiles(int boardAttachmentNo, int boardOriginNo) {
		String sql = "insert into board_img("
				+ "board_attachment_no, board_origin_no"
				+ ") values(?, ?)";
		Object[] param = {boardAttachmentNo, boardOriginNo};
		jdbcTemplate.update(sql, param);
	}


}
