<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class = "container-1200">

<form action = "write" method = "post">
	<div class = "row">
	<input name = "recipeTitle" class="input input-underline w-50" placeholder="레시피 제목">
	</div>
	
	<div class = "row">
		<textarea name = "recipeContent" class="input w-100 fix-size mt-10" rows="8" placeholder="레시피 내용을 입력해 주세요."></textarea>
	</div>
	
	
	<div class = "row right">
				<a href="list" class="btn btn-neutral">취소</a>
				<button type = "submit" class="btn">작성</button>
	</div>
</form>
</div>