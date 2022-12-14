package com.kh.pj.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.ReplyDto;
import com.kh.pj.vo.ReplyListVO;

@Repository
public class ReplyDaoImpl implements ReplyDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<ReplyListVO> listMapper = new RowMapper<ReplyListVO>() {
		@Override
		public ReplyListVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			return ReplyListVO.builder()
										.replyNo(rs.getInt("reply_no"))
										.replyBoardNo(rs.getInt("reply_board_no"))
										.replyId(rs.getString("reply_id"))
										.memberNick(rs.getString("member_nick"))			
										.replyContent(rs.getString("reply_content"))
										.replyWriteTime(rs.getDate("reply_writetime"))
										.replyEditTime(rs.getDate("reply_edittime"))
										.replyBlind(rs.getString("reply_blind"))
										.memberBadge(rs.getString("member_badge"))
//										.profileAttachmentNo(rs.getInt("profile_attachment_no"))
									.build();
		}
	};
	private ResultSetExtractor<ReplyDto> extractor = new ResultSetExtractor<ReplyDto>() {
		@Override
		public ReplyDto extractData(ResultSet rs) throws SQLException, DataAccessException {
			if(rs.next()) {
				return ReplyDto.builder()
						.replyNo(rs.getInt("reply_no"))
						.replyBoardNo(rs.getInt("reply_board_no"))
						.replyId(rs.getString("reply_id"))
						.replyContent(rs.getString("reply_content"))
						.replyWriteTime(rs.getDate("reply_writetime"))
						.replyEditTime(rs.getDate("reply_edittime"))
						.replyBlind(rs.getString("reply_blind") != null)
					.build();
			}
			else {
				return null;
			}
		}
	};
	
	
	@Override
	public void insert(ReplyDto replyDto) {
		String sql = "insert into reply("
							+ "reply_no, reply_board_no, reply_id, reply_content)"
							+ "values(reply_seq.nextval, ?, ?, ?)";
		Object[] param = {
				replyDto.getReplyBoardNo(), replyDto.getReplyId(), 
				replyDto.getReplyContent()
		};
		jdbcTemplate.update(sql, param);
	}

	@Override
	public List<ReplyListVO> selectList(int replyBoardNo) {
		String sql = "select R.*, M.member_nick,M.member_badge "
				+ "from reply R left outer join member M on R.reply_id = M.member_id "
				+ "where reply_board_no = ? "
				+ "order by reply_no asc";
		Object[] param = {replyBoardNo};
		return jdbcTemplate.query(sql, listMapper, param);
	}

	@Override
	public ReplyDto selectOne(int replyNo) {
			String sql = "select * from reply where reply_no=?";
			Object[]param = {replyNo};
			return jdbcTemplate.query(sql, extractor,param);
	}

	@Override
	public boolean update(ReplyDto replyDto) {
		String sql = "update reply "
				+ "set reply_content=? "
				+ "where reply_no=?";
		Object[] param = {
				replyDto.getReplyContent(), replyDto.getReplyNo()	
					};
			return jdbcTemplate.update(sql, param) > 0;
}

	@Override
	public boolean delete(int replyNo) {
		String sql = "delete reply where reply_no = ?";
		Object[] param = {replyNo};
		return jdbcTemplate.update(sql, param) > 0;
	}

	@Override
	public boolean updateBlind(int replyNo, boolean blind) {
		String sql = "update reply "
				+ "set reply_blind = ? "
				+ "where reply_no = ?";
		String replyBlind = blind ? "Y" : null;//삼항연산
		Object[] param = {replyBlind, replyNo};
		return jdbcTemplate.update(sql, param) > 0;
	}
}
