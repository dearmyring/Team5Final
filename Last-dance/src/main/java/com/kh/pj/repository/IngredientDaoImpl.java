package com.kh.pj.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.IngredientDto;

@Repository
public class IngredientDaoImpl implements IngredientDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private SqlSession sqlSession;
	
	private RowMapper<IngredientDto>mapper = (rs,idx)-> {
		return IngredientDto.builder()
				.ingredientCategory(rs.getString("ingredient_category"))
				.ingredientName(rs.getString("ingredient_name"))
				.build();
	};
	
	//재료 추가
	@Override
	public void insert(IngredientDto ingredientDto) {
		String sql = "insert into Ingredient"
					+ "(ingredient_category, ingredient_name) "
						+ "values(?, ?)";
		Object[] param = {ingredientDto.getIngredientCategory(),
										ingredientDto.getIngredientName()};
		jdbcTemplate.update(sql, param);
	}
  
	//재료 수정
	@Override
	public boolean update(IngredientDto ingredientDto) {
		String sql = "update Ingredient set ingredient_name=?";
		Object[] param = {ingredientDto.getIngredientName()};
		return jdbcTemplate.update(sql, param) > 0;
	}
	
	//재료 조회
	@Override
	public List<IngredientDto> IngredientList(String IngredientName) {
		String sql = "select * from ingredient where ingredien_name=?";
		Object[] param = {IngredientName};
		return jdbcTemplate.query(sql, mapper,param);
	}

	//재료 삭제
	@Override
	public boolean delete(String IngredientName) {
		String sql = "delete Ingredient where ingredient_name=?";
		Object[] param = {IngredientName};
		return jdbcTemplate.update(sql, param) > 0;
	}

	@Override
	public List<String> list(String search) {
		return sqlSession.selectList("ingredient.list", search);
	}

	@Override
	public List<String> cate() {
		return sqlSession.selectList("ingredient.cate");
	}

}
