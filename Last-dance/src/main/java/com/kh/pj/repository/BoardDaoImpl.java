package com.kh.pj.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
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
	public int sequence() {
		String sql = "select board_seq.nextval from dual";
		int boardNo = jdbcTemplate.queryForObject(sql, int.class);
		return boardNo;
	}
	
	@Override
	public int insert2(BoardDto boardDto) {
		//번호를 미리 생성한 뒤 등록하는 기능
		String sql = "select board_seq.nextval from dual";
		int boardNo = jdbcTemplate.queryForObject(sql, int.class);
		
		//등록 시퀀스 생성 xx
		sql = "insert into board(board_no, board_id, "
				+ "board_title, board_content) "
				+ "values(?, ?, ?, ?)";
		Object[] param = {
				boardNo, boardDto.getBoardId(),
				boardDto.getBoardTitle(), boardDto.getBoardContent()
		};
		jdbcTemplate.update(sql, param);
		
		return boardNo;
	}
	
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

	
private ResultSetExtractor<BoardListVO> detailExtractor = new ResultSetExtractor<BoardListVO>() {
		
		@Override
		public BoardListVO extractData(ResultSet rs) throws SQLException, DataAccessException {
			if(rs.next()) {
				return BoardListVO.builder()
						.boardNo(rs.getInt("board_no"))
						.memberNick(rs.getString("member_nick"))
						.boardId(rs.getString("board_id"))
						.boardTitle(rs.getString("board_title"))
						.boardContent(rs.getString("board_content"))
						.boardClick(rs.getInt("board_click"))
						.boardLike(rs.getInt("board_like"))
						.boardWriteTime(rs.getDate("board_writetime"))
						.boardEditTime(rs.getDate("board_edittime"))
						.boardBlind(rs.getString("board_blind"))
						.memberBadge(rs.getString("member_badge"))
//						.replyNo(rs.getInt("reply_no"))
//						.profileAttachmentNo(rs.getInt("profile_attachment_no"))
//						.attachment_no(rs.getInt("attachment_no"))
						.build();
			}
			else {
				return null;
			}
		}
	};
	
	
	
	@Override
	public BoardListVO selectOne(int boardNo) {
		String sql="select"
				+ " board.*,member_nick,member_badge"
				+ " from board left outer join member on board_id=member_id where board_no=?";
		Object[]param = {boardNo};
		return jdbcTemplate.query(sql, detailExtractor,param);
		}

	@Override
	public List<BoardListVO> boardList(String memberNick) {
		return sqlSession.selectList("board.list");
	}

	@Override
	public BoardListVO click(int boardNo) {
		this.updateClickCount(boardNo);
		return this.selectOne(boardNo);
	}

	@Override
	public boolean updateClickCount(int boardNo) {
		String sql = "update board set board_click = board_click + 1 where board_no=?";
		Object[] param = { boardNo };
		return jdbcTemplate.update(sql, param) > 0;
	}
	
	@Override
	public void connectAttachment(int boardNo, int boardAttachmentNo) {
		String sql = "insert into board_img("
							+ "board_no, board_attachment_no"
						+ ") values(?, ?)";
		Object[] param = {boardNo, boardAttachmentNo};
		jdbcTemplate.update(sql, param);
	}


}
