package com.kh.pj.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.HashtagDto;

@Repository
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
	public List<HashtagDto> selectHashtagList() {
		String sql = "select * from hashtag order by hashtag_name asc";
		return jdbcTemplate.query(sql, mapper);
	}

	@Override
	public boolean delete(String hashtagName) {
		String sql = "delete hashtag where hashtag_name=?";
		Object[] param = {hashtagName};		
		return jdbcTemplate.update(sql, param) > 0;

	}
}
		



