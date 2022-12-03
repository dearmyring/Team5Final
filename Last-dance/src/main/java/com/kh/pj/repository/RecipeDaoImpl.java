package com.kh.pj.repository;

import java.security.interfaces.RSAKey;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.kh.pj.entity.RecipeDto;

public class RecipeDaoImpl implements RecipeDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<RecipeDto> mapper = (rs, idx)-> {
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
	};

	@Override
	public void insert(RecipeDto recipeDto) {
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

	@Override
	public boolean update(int recipeNo) {
		String sql = "update recipe set "
				+"recipe_nick, recipe_title, recipe_info, recipe_time, recipe_hashtag, recipe_difficulty"
					+ "where recipe_no=?";
				return false;
	}

	@Override
	public List<RecipeDto> recipeList(int recipeNo) {
		String sql = "select * from recipe where recipe_no=?";
		Object[] param = {recipeNo};
		return null;
	}

	@Override
	public boolean delete(int recipeNo) {
		String sql = "delete recipe where recipe_no=?";
		Object[] param = {recipeNo};
		return jdbcTemplate.update(sql, param) > 0;
	}

}
