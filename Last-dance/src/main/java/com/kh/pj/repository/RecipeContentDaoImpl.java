package com.kh.pj.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.kh.pj.entity.RecipeContentDto;

public class RecipeContentDaoImpl implements RecipeContentDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	//레시피 내용 mapper 생성
	private RowMapper<RecipeContentDto> mapper = (rs, idx)->{
		return RecipeContentDto.builder()
				.recipeContentNo(rs.getInt("recipe_content_no"))	
				.recipeNo(rs.getInt("recipe_no"))
				.recipeContentText(rs.getString("recipe_context_text"))				
				.build();
	};

	//레시피 내용 추가
	@Override
	public void insert(RecipeContentDto recipeContentDto) {
		String sql = "insert into recipe_content "
					+ "(recipe_content_no, recipe_no, recipe_content_text) "
						+ "values(?, ?, ?)";
		Object[] param = {recipeContentDto.getRecipeContentNo(),
									recipeContentDto.getRecipeNo(),
									recipeContentDto.getRecipeContentText()
		};
		jdbcTemplate.update(sql, param);
	}
	
	//레시피 내용 수정
	@Override
	public boolean update(int recipeContentNo) {
		String sql = "update recipe_content set "
						+ "recipe_content_text"
							+ "where recipe_content_no=?";
		Object[] param = {recipeContentNo};
		return jdbcTemplate.update(sql, param) > 0;
	}

	//레시피 내용 조회
	@Override
	public List<RecipeContentDto> RecipeContentList(int recipeContentNo) {
		String sql = "select * from recipe_content where recipe_content_no=?";
		Object[] param = {recipeContentNo};
		return jdbcTemplate.query(sql, mapper, param);
	}

	//레시피 내용 추가 삭제
	@Override
	public boolean delete(int recipeContentNo) {
		String sql = "delete recipe_content where recipe_content)no=?";
		Object[] param = {recipeContentNo};
		return jdbcTemplate.update(sql, param) > 0;
	}

}
