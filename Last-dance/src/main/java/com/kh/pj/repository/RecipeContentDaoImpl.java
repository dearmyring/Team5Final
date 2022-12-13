package com.kh.pj.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.RecipeContentDto;

@Repository
public class RecipeContentDaoImpl implements RecipeContentDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private SqlSession sqlSession;

	//레시피 시퀀스 생성
	@Override
	public int sequence() {
		return sqlSession.selectOne("recipeContent.sequence");
	}
	
	//레시피 내용 추가
	@Override
	public void insert(RecipeContentDto recipeContentDto) {
		sqlSession.insert("recipeContent.insert", recipeContentDto);
	}
	
	//레시피 내용 조회
	@Override
	public List<RecipeContentDto> find(int recipeNo) {
		return sqlSession.selectList("recipeContent.find", recipeNo);
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

	//레시피 내용 추가 삭제
	@Override
	public boolean delete(int recipeContentNo) {
		String sql = "delete recipe_content where recipe_content)no=?";
		Object[] param = {recipeContentNo};
		return jdbcTemplate.update(sql, param) > 0;
	}

	@Override
	public void adminDelete(int recipeNo) {
		sqlSession.delete("recipeContent.adminDelete", recipeNo);
	}

}
