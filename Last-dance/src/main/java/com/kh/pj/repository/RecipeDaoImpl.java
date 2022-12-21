package com.kh.pj.repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.kh.pj.entity.RecipeDto;
import com.kh.pj.entity.RecipeLikeDto;
import com.kh.pj.entity.RecipeViewDto;
import com.kh.pj.vo.RecipeCountVO;
import com.kh.pj.vo.RecipeDetailVO;
import com.kh.pj.vo.LatelyViewListVO;
import com.kh.pj.vo.ListSearchVO;
import com.kh.pj.vo.RecipeListVO;

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
	
//	//레시피 목록조회(SELECT)
//	@Override
//	public List<RecipeDto> recipeList(String recipeTitle) {
//		return sqlSession.selectList("recipe.list");
//
//	}
	
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

	@Override
	public List<RecipeDto> adminList(ListSearchVO vo) {
		return sqlSession.selectList("recipe.adminList", vo);
	}

	@Override
	public RecipeDto adminDetail(int recipeNo) {
		return sqlSession.selectOne("recipe.adminDetail", recipeNo);
	}
	
	//레시피 갯수 세기 위한 RowMapper
	private RowMapper<RecipeCountVO> countMapper = new RowMapper<RecipeCountVO>() {
		@Override
		public RecipeCountVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			RecipeCountVO recipeCountVO = new RecipeCountVO();
			recipeCountVO.setRecipeNo(rs.getInt("recipe_no"));
			recipeCountVO.setRecipeTitle(rs.getString("recipe_title"));
			recipeCountVO.setRecipeNick(rs.getString("recipe_nick"));
			recipeCountVO.setRecipeInfo(rs.getString("recipe_info"));
			recipeCountVO.setRecipeClick(rs.getInt("recipe_click"));
			recipeCountVO.setRecipeLike(rs.getInt("recipe_like"));
			recipeCountVO.setRecipeHashtag(rs.getString("recipe_hashtag"));
			recipeCountVO.setRecipeWritetime(rs.getDate("recipe_writetime"));
			recipeCountVO.setRecipeEdittime(rs.getDate("recipe_edittime"));
			recipeCountVO.setRecipeDifficulty(rs.getString("recipe_difficulty"));
			return recipeCountVO;
		}
	};
	

	//레시피 리스트 출력
	@Override
	public List<RecipeListVO> recipeList() {
		return sqlSession.selectList("recipe.recipeList");
	}

	//재료별 레시피 갯수 출력
//	@Override
//	public List<RecipeCountVO> selectRecipeList() {
//		String sql = "select COUNT(*) cnt from recipe R inner join recipe_ingredient RI "
//						+"on R.recipe_no=RI.recipe_no where recipe_ingredient_name=?";
//		return jdbcTemplate.query(sql,  countMapper);
//	}
	
	
	
	
	
	
	//여기부터 레시피 디테일
	
	//레시피 상세페이지 출력
	@Override
	public RecipeDetailVO selectDetail(int recipeNo) {
		
		return sqlSession.selectOne("recipe.detail", recipeNo);
	}
	
	//내가 본 레시피 조회
	@Override
	public RecipeViewDto myViewRecipe(RecipeViewDto recipeViewDto) {
		
		return sqlSession.selectOne("recipe.myViewRecipe", recipeViewDto);
	}
	
	//내가 본 레시피 등록
	@Override
	public void insertRecipeView(RecipeViewDto recipeViewDto) {
		sqlSession.insert("recipe.insertViewRecipe", recipeViewDto);
		
	}
	
	//내가 본 레시피 시간 업데이트
	@Override
	public boolean updateRecipeViewTime(RecipeViewDto recipeViewDto) {
		int result = sqlSession.update("recipe.updateRecipeViewTime", recipeViewDto);
		return result > 0;
	}

	@Override
	public void adminUpdate(RecipeDto recipeDto) {
		sqlSession.update("recipe.adminUpdate", recipeDto);
	}
	
	//레시피 좋아요 확인
	@Override
	public RecipeLikeDto recipeLikeOne(RecipeLikeDto dto) {
			
		return sqlSession.selectOne("recipe.selectRecipeLike", dto);
	}
	
	//좋아요 업
	@Override
	public boolean likeUp(int recipeNo) {
		int result = sqlSession.update("recipe.likeUp", recipeNo);
		return result > 0;
	}
	
	//좋아요 다운
	@Override
	public boolean likeDown(int recipeNo) {
		int result = sqlSession.update("recipe.likeDown", recipeNo);
		return result > 0;
	}

	//레시피 라이크 테이블 등록
	@Override
	public void addLike(RecipeLikeDto dto) {
		sqlSession.insert("recipe.addRecipeLike", dto);
		
	}
	
	//레시피 라이크 테이블 삭제
	@Override
	public boolean removeLike(RecipeLikeDto dto) {
		int result = sqlSession.delete("recipe.removeRecipeLike", dto);
		return result > 0;
	}

	
	//레시피 개수 출력
	@Override
	public int countLike(int recipeNo) {
		
		return sqlSession.selectOne("recipe.countLike", recipeNo);
	}

//	@Override
//	public int searchCount(String keyword) throws Exception {
//
//		HashMap<String, Object> data = new HashMap<String, Object>();
//		
//		data.put("keyword", keyword);
//		return sql.selectOne(namespace + ".searchCount", data);
//	}
	
	

	@Override
	public RecipeDto adminRecipeFind(String recipeTitle) {
		return sqlSession.selectOne("recipe.adminRecipeFind", recipeTitle);
	}
	
	//최근 본 레시피 3개
	@Override
	public List<LatelyViewListVO> latelyViewList(String memberId) {
		return sqlSession.selectList("recipe.latelyViewList", memberId);
	}

}
