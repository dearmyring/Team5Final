package com.kh.pj.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.IngredientDto;
import com.kh.pj.vo.ListSearchVO;

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
	public void update(Map<String, String> data) {
		sqlSession.update("ingredient.adminUpdate", data);
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
	public List<IngredientDto> adminList(ListSearchVO vo) {
		return sqlSession.selectList("ingredient.adminList", vo);
	}

	@Override
	public List<String> cate() {
		return sqlSession.selectList("ingredient.cate");
	}

	@Override
	public List<String> searchList(String search) {
		return sqlSession.selectList("ingredient.searchList", search);
	}

	@Override
	public String adminSelect(String ingredientName) {
		return sqlSession.selectOne("ingredient.adminSelect", ingredientName);
	}

//	@Override
//	public IngredientDto findIngredient(String ingredientName) {
//		return sqlSession.selectOne("ingredient.get",ingredientName);
//	}

}
