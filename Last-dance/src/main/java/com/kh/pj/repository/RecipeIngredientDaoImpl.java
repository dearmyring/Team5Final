package com.kh.pj.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import com.kh.pj.entity.RecipeIngredientDto;

public class RecipeIngredientDaoImpl implements RecipeIngredientDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Override
	public void insert(RecipeIngredientDto recipeIngredientDto) {
		String sql = "insert into recipe_ingredient "
					+ "recipe_ingredient_name "
						+"values(?)";
		Object[] param = {recipeIngredientDto.getRecipeIngredientName(),
										recipeIngredientDto.getRecipeNo()
		};
		jdbcTemplate.update(sql, param);	
	}

	@Override
	public boolean update(String recipeIngredientName) {
		String sql = "update recipe_ingredient set "
					+ "recipe_ingredient_name "
						+ "where recipe_no=?";
		Object[] param = {recipeIngredientName};
		return jdbcTemplate.update(sql, param) > 0;
	}

	@Override
	public List<RecipeIngredientDto> RecipeIngredientList(String recipeIngredientName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean delete(String recipeIngredientName) {
		String sql = "delete recipe_ingredient where recipe_ingredient_name=?";
		Object[] param = {recipeIngredientName};
		return jdbcTemplate.update(sql, param) > 0;
	}

}
