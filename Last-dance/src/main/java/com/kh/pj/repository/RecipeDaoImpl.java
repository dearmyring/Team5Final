package com.kh.pj.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.RecipeDto;

@Repository
public class RecipeDaoImpl implements RecipeDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	//레시피 등록 관련 시퀀스
	@Override
	public int recipeSequence() {
		return sqlSession.selectOne("recipe.recipeNo");
	}
	
	//레시피 등록(INSERT)
	@Override
	public void write(RecipeDto recipeDto) {
		sqlSession.insert("recipe.write", recipeDto);

	}
	
	//레시피 수정(UPDATE)
	@Override
	public boolean update(RecipeDto recipeDto) {
		int count = sqlSession.update("recipe.edit", recipeDto);
		return count > 0;

	}
	
	//레시피 목록조회(SELECT)
	@Override
	public List<RecipeDto> recipeList(String recipeTitle) {
		return sqlSession.selectList("recipe.list");

	}
	//레시피 삭제(DELETE)
	@Override
	public boolean delete(int recipeNo) {
		int count = sqlSession.delete("recipe.delete", recipeNo);
		return count > 0;

	}
	
	//레시피 상세(DETAIL)
	@Override
	public RecipeDto selectOne(int recipeNo) {
		return sqlSession.selectOne("recipe.detail", recipeNo);

	}
	
	//레시피 조회수 
	@Override
	public RecipeDto click(int recipeNo) {
		this.updateClickCount(recipeNo);
		return this.selectOne(recipeNo);
	}
	
	//레시피 조회수 증가
	@Override
	public boolean updateClickCount(int recipeNo) {
		String sql = "update recipe "
						+ "set recipe_click = recipe_click + 1 "
							+ "where recipe_no=?";
		Object[] param = {recipeNo};
		return jdbcTemplate.update(sql,param) > 0;
	}

}


