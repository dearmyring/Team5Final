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
	
	@Override
	public void connectAttachment(int boardOriginNo, int boardAttachmentNo) {
		String sql = "insert into board_img("
							+ "board_origin_no, board_attachment_no"
						+ ") values(?, ?)";
		Object[] param = {boardOriginNo, boardAttachmentNo};
		jdbcTemplate.update(sql, param);
	}

}
