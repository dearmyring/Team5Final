<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param name="title" value="����������"/>
</jsp:include>

<h1>������ ��������</h1>

����: ${recipe.recipeTitle}
�ۼ���: ${recipe.recipeNick}
�Ұ�: ${recipe.recipeInfo}
�ҿ�ð�: ${recipe.recipeTime}
��ȸ��: ${recipe.recipeClick}
���ƿ�: ${recipe.recipeLike}
�ؽ��±�: ${recipe.recipeHashtag}
�ۼ���: ${recipe.recipeWritetime}
������: ${recipe.recipeEdittime}
���̵�: ${recipe.recipeDifficulty}
>>>>>>> refs/remotes/origin/main

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>