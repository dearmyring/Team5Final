package com.kh.pj.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.AttachmentDto;

@Repository
public class AttachmentDaoImpl implements AttachmentDao{

	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	
	
	@Override
	public int sequence() {
		return sqlSession.selectOne("attachment.sequence");
	}

	@Override
	public void insert(AttachmentDto attachmentDto) {
		sqlSession.insert("attachment.insert", attachmentDto);
	}

	@Override
	public AttachmentDto find(int attachmentNo) {
		return sqlSession.selectOne("attachment.find", attachmentNo);
	}

	
	
	private RowMapper<AttachmentDto> mapper = new RowMapper<>(){

		@Override
		public AttachmentDto mapRow(ResultSet rs, int rowNum) throws SQLException {
			
			return AttachmentDto.builder()
					.attachmentNo(rs.getInt("attachment_no"))
					.attachmentName(rs.getString("attchment_name"))
					.attachmentType(rs.getString("attachment_type"))
					.attachmentSize(rs.getLong("attachment_size"))
					.build();
		}
		
	};
	private ResultSetExtractor<AttachmentDto> extractor = new ResultSetExtractor<AttachmentDto>() {

		@Override
		public AttachmentDto extractData(ResultSet rs) throws SQLException, DataAccessException {
			if(rs.next()) {
				return AttachmentDto.builder()
						.attachmentNo(rs.getInt("attachment_no"))
						.attachmentName(rs.getString("attchment_name"))
						.attachmentType(rs.getString("attachment_type"))
						.attachmentSize(rs.getLong("attachment_size"))
						.build();
			}
			else {
				return null;				
			}
		}
		
	};
	
	


	@Override
	public List<AttachmentDto> selectBoardFileList(int boardAttachmentNo) {
		String sql = "select * from board_attachment_view "
				+ "where board_attachment_no = ?";
		Object[] param = {boardAttachmentNo};
		return jdbcTemplate.query(sql, mapper, param);
=======
	@Override
	public void delete(int attachmentNo) {
		sqlSession.delete("attachment.delete", attachmentNo);

	}
}
