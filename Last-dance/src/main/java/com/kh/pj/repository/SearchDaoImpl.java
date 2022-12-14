package com.kh.pj.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.IngredientDto;
import com.kh.pj.entity.SearchDto;
@Repository
public class SearchDaoImpl implements SearchDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private SqlSession sqlSession;
	
	//검색어 추가(INSERT)
	@Override
	public void add(SearchDto searchDto) {
		sqlSession.insert("search.add",searchDto);
		
	}
	
	private RowMapper<SearchDto> mapper = (rs,idx)-> {
		return SearchDto.builder()
				.searchIngredient(rs.getString("search_ingredient"))
				.searchTime(rs.getDate("search_time"))
				.build();
	};

	@Override
	public List<SearchDto> searchList(String SearchIngredient) {
		String sql = "select R.* ,RI.recipe_ingredient_name from recipe R inner join recipe_ingredient RI on R.recipe_no=RI.recipe_no where recipe_ingredient_name=?";
		Object[] param = {SearchIngredient};
		return jdbcTemplate.query(sql, mapper,param);

	}
	
	@Override
	public List<IngredientDto> searchForIngredients(String ingredientName) {
		return sqlSession.selectList("search.searchForIngredient", ingredientName);
	}
}
