<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param name="title" value="마이페이지"/>
</jsp:include>

<h1>레시피 상세페이지</h1>

제목: ${recipe.recipeTitle}
작성자: ${recipe.recipeNick}
소개: ${recipe.recipeInfo}
소요시간: ${recipe.recipeTime}
조회수: ${recipe.recipeClick}
좋아요: ${recipe.recipeLike}
해시태그: ${recipe.recipeHashtag}
작성일: ${recipe.recipeWritetime}
수정일: ${recipe.recipeEdittime}
난이도: ${recipe.recipeDifficulty}
>>>>>>> refs/remotes/origin/main

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>