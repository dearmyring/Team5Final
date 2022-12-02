package com.kh.pj.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.kh.pj.entity.CategoryDto;

public class CategoryDaoImpl implements CategoryDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<CategoryDto> mapper = (rs,idx)-> {
		return CategoryDto.builder()
				.CategoryMain(rs.getString("category_main"))				
				.build();
	};
	
	//카테고리 추가
	@Override
	public void insert(CategoryDto categoryDto) {
		String sql = "insert into category"
					+ "(category_main)"
						+ "values(?)";
		Object[] param = {categoryDto.getCategoryMain()};
		jdbcTemplate.update(sql,param);
		
	}
	
	//카테고리 수정
	@Override
	public boolean update(CategoryDto categoryDto) {
		String sql = "update category set category_main=?";
		Object[] param = {categoryDto.getCategoryMain()};
		return jdbcTemplate.update(sql, param) > 0;
	}
	
	//카테고리 조회
	@Override
	public List<CategoryDto> CategoryList(String categoryMain) {
		String sql = "select * from catetory";
		Object[] param = {categoryMain};
		return jdbcTemplate.query(sql, mapper, param);
	}
	
	//카테고리 삭제
	@Override
	public boolean delete(String categoryMain) {
		String sql = "delete category where category_main=?";
		Object[] param = {categoryMain};
		return jdbcTemplate.update(sql, param) > 0;
	}

}
