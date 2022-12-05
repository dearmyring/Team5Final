package com.kh.pj.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.RecipeDto;

@Repository
public class RecipeDaoImpl implements RecipeDao {
	
	@Override
	public int recipeSequence() {
		String sql = "select recipe_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
//	private RowMapper<RecipeDto> mapper = (rs, idx)-> {
//		return RecipeDto.builder()
//				.recipeNo(rs.getInt("recpie_no"))
//				.recipeNick(rs.getString("recipe_nick"))
//				.recipeTitle(rs.getString("recipe_title"))
//				.recipeInfo(rs.getString("recipe_info"))
//				.recipeTime(rs.getInt("recipe_time"))
//				.recipeClick(rs.getInt("recipe_click"))
//				.recipeLike(rs.getInt("recipe_like"))
//				.recipeHashtag(rs.getString("recipe_hashtag"))
//				.recipeWritetime(rs.getDate("recipe_writetime"))
//				.recipeEdittime(rs.getDate("recipe_edittime"))
//				.recipeDifficulty(rs.getString("recipe_difficulty"))			
//				.build();		
//	};
	
	private ResultSetExtractor<RecipeDto> extractor = new ResultSetExtractor<RecipeDto>() {
		
		@Override
		public RecipeDto extractData(ResultSet rs) throws SQLException, DataAccessException {
			if(rs.next()) {
				return RecipeDto.builder()
						.recipeNo(rs.getInt("recpie_no"))
						.recipeNick(rs.getString("recipe_nick"))
						.recipeTitle(rs.getString("recipe_title"))
						.recipeInfo(rs.getString("recipe_info"))
						.recipeTime(rs.getInt("recipe_time"))
						.recipeClick(rs.getInt("recipe_click"))
						.recipeLike(rs.getInt("recipe_like"))
						.recipeHashtag(rs.getString("recipe_hashtag"))
						.recipeWritetime(rs.getDate("recipe_writetime"))
						.recipeEdittime(rs.getDate("recipe_edittime"))
						.recipeDifficulty(rs.getString("recipe_difficulty"))			
						.build();	
			}
			else {			
			return null;
			}
		}
	};
	
	//레시피 등록(INSERT)
	@Override
	public void write(RecipeDto recipeDto) {
		String sql = "insert into recipe "
					+ "(recipe_no, recipe_nick, recipe_title, recipe_info) "
					+ "(recipe_time, recipe_click, recipe_like, recipe_hashtag) "
					+ "(recipe_writetime, recipe_edittime, recipe_difficulty) "
						+ "values(recipe_seq.nextval, ?,?,?,?,?,?,?,?,?,?,?)";
		Object[] param = {recipeDto.getRecipeNo(),	recipeDto.getRecipeNick(),
										recipeDto.getRecipeTitle(),recipeDto.getRecipeInfo(),
										recipeDto.getRecipeTime(),recipeDto.getRecipeClick(),
										recipeDto.getRecipeLike(),recipeDto.getRecipeHashtag(),
										recipeDto.getRecipeWritetime(),recipeDto.getRecipeEdittime(),
										recipeDto.getRecipeDifficulty()
		};
		jdbcTemplate.update(sql, param);
	}
	//레시피 수정
	@Override
	public boolean update(int recipeNo) {
		String sql = "update recipe set "
				+"recipe_nick, recipe_title, recipe_info, recipe_time, recipe_hashtag, recipe_difficulty"
					+ "where recipe_no=?";
				return false;
	}
	//레시피 목록조회
	@Override
	public List<RecipeDto> recipeList(String recipeTitle) {
		String sql = "select * from recipe where recipe_no=?";
		Object[] param = {recipeTitle};
		return null;
	}
	//레시피 삭제
	@Override
	public boolean delete(int recipeNo) {
		String sql = "delete recipe where recipe_no=?";
		Object[] param = {recipeNo};
		return jdbcTemplate.update(sql, param) > 0;
	}
	
	//레시피 상세(DETAIL)
	@Override
	public RecipeDto selectone(int recipeNo) {
		String sql = "select * from recipe where recipe_no=?";
		Object[] param = {recipeNo};
		return jdbcTemplate.query(sql, extractor,param);
	}

}
