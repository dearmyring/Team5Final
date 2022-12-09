
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="회원가입" name="title"/>
</jsp:include>

<style>

</style>
<div class = "container-1200 mt-40 mb-40">
	<div class = "row center">
		<h1>레시피 리스트</h1>
	</div>
		
		<div class="container-280">
	<div class="row mt-60">

			<c:forEach var = "recipeListVO" items = "${recipeList}">
				
					<div>${recipeListVO.recipeDto.recipeNo}</div>
					<div>
					<a href = "detail?recipeNo=${recipeListVO.recipeDto.recipeNo}">${recipeListVO.recipeDto.recipeHashtag} / ${recipeListVO.recipeDto.recipeTitle}</a>
					</div>

					<c:forEach var="ingredient" items="${recipeListVO.recipeIngredientList}">
		                 <span> ${ingredient.recipeIngredientName}</span>
		            </c:forEach>

					<div>${recipeListVO.recipeDto.recipeNick}</div>		
					<div>${recipeListVO.recipeDto.recipeWritetime}</div>	
					<div>${recipeListVO.recipeDto.recipeClick}</div>	
					<div>${recipeListVO.recipeDto.recipeLike}</div>	
				
				</c:forEach>
				</div>

		</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

	


