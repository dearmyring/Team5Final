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
import com.kh.pj.entity.BoardImgDto;
import com.kh.pj.entity.BoardLikeDto;
import com.kh.pj.entity.MemberDto;
import com.kh.pj.entity.NoticeDto;
import com.kh.pj.error.TargetNotFoundException;
import com.kh.pj.vo.BoardListSearchVO;
import com.kh.pj.vo.BoardListVO;
import com.kh.pj.vo.ListSearchVO2;

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
	public BoardListVO selectOne(int boardNo) {
		return sqlSession.selectOne("board.detail",boardNo);
	}

	
	@Override
	public List<BoardListVO> boardList(BoardListSearchVO vo) {
		return sqlSession.selectList("board.list", vo);
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

	@Override
	public void updatePoint(MemberDto memberDto) {
		sqlSession.update("board.updatePoint",memberDto);	
	}
	
	@Override
	public void deletePoint(MemberDto memberDto) {
		sqlSession.update("board.deletePoint",memberDto);
	}

	@Override
	public int boardCNT(MemberDto memberDto) {
		return sqlSession.selectOne("board.boardCNT",memberDto);
	}
	
	@Override
	public int replyCNT(MemberDto memberDto) {
		return sqlSession.selectOne("board.replyCNT",memberDto);
	}

	@Override
	public List<BoardDto> adminList(ListSearchVO2 vo2) {
		return sqlSession.selectList("recipe.adminList", vo2);
	}

	@Override
	public boolean blind(BoardDto boardDto) {
		int count = sqlSession.update("board.blind", boardDto);
		if (count == 0)
			throw new TargetNotFoundException();
		return count > 0;
	}
	

	@Override
	public List<NoticeDto> noticeList(NoticeDto noticeDto) {
		return sqlSession.selectList("board.noticelist",noticeDto);
	}

	
	@Override
	public BoardLikeDto boardLikeOne(BoardLikeDto dto) {
		
		return sqlSession.selectOne("board.selectBoardLike",dto);
	}

	@Override
	public boolean likeUp(int boardNo) {
		int result = sqlSession.update("board.likeUp", boardNo);
		return result > 0;
	}

	@Override
	public boolean likeDown(int boardNo) {
		int result = sqlSession.update("board.likeDown", boardNo);
		return result > 0;
	}

	@Override
	public void addLike(BoardLikeDto dto) {
		sqlSession.insert("board.addBoardLike", dto);
		
	}

	@Override
	public boolean removeLike(BoardLikeDto dto) {
		int result = sqlSession.delete("board.removeBoardLike", dto);
		return result > 0;
	}

	@Override
	public int countLike(int boardNo) {
		return sqlSession.selectOne("board.countLike", boardNo);
	}

	@Override
	public int boardTotal(BoardListSearchVO vo) {
		return sqlSession.selectOne("board.boardcount");
		
	}


}
