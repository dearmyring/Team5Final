package com.kh.pj.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.RecipeIngredientDto;

@Repository
public class RecipeIngredientDaoImpl implements RecipeIngredientDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(RecipeIngredientDto recipeIngredientDto) {
		sqlSession.insert("recipeIngredient.insert", recipeIngredientDto);	
	}
	
	@Override
	public List<String> find(int recipeNo) {
		return sqlSession.selectList("recipeIngredient.find", recipeNo);
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

	@Override
	public void adminDelete(int recipeNo) {
		sqlSession.delete("recipeIngredient.adminDelete", recipeNo);
	}

}
