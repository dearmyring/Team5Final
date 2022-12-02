package com.kh.pj.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.kh.pj.entity.HashtagDto;

public class HashtagDaoImpl implements HashtagDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;	
	
	private RowMapper<HashtagDto> mapper = (rs,idx)-> {
		return HashtagDto.builder()
				.hashtagName(rs.getString("hashtag_name"))
				.hashtagTime(rs.getDate("hashtag_time"))
				.build();
	};

	@Override
	public void insert(HashtagDto hashtagDto) {
		String sql = "insert into hashtag"
					+ "(hashtag_name)"
						+ "values(?)";
		Object[] param = {hashtagDto.getHashtagName()};
		jdbcTemplate.update(sql,param);	
		
	}

	@Override
	public boolean update(HashtagDto hashtagDto) {
		String sql = "update hashtag set hashtag_name=?";
		Object[] param = {hashtagDto.getHashtagName()};
		return jdbcTemplate.update(sql, param) > 0;	
	}

	@Override
	public List<HashtagDto> HashtagList(String HashtagName) {
		String sql = "select * from hashtag";
		Object[] param = {HashtagName};
		return jdbcTemplate.query(sql, mapper, param);
	}

	@Override
	public boolean delete(String HashtagName) {
		String sql = "delete hashtag where hashtag_name=?";
		Object[] param = {HashtagName};		
		return jdbcTemplate.update(sql, param) > 0;

	}

}
