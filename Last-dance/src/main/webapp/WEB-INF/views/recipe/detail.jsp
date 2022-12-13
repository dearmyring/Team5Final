<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param name="title" value="마이페이지"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/recipe-detail.css">

<!-- swiper 의존성 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>

<!-- js 불러옴 -->
<script src="/js/recipe-detail.js"></script>

<style>
	
</style>

<div class="recipe-detail-container">
	<div class="recipe-detail-titleBox">
		<div class="recipe-popularity">
			<span>조회수 ${recipe.recipeDto.recipeClick}</span>
			<span>좋아요 ${recipe.recipeDto.recipeLike}</span>
		</div>
		<div class="swiper recipe-detail-thumbnail">
			<div class="swiper-wrapper">
				<c:forEach var="recipeImg" items="${recipe.recipeImages}">
				<div class="swiper-slide">
				    <img class="thumbnail-image" src = "${pageContext.request.contextPath}/rest/download/${recipeImg.recipeAttachmentNo}">
				</div>
				</c:forEach>
			</div>
		</div>
		<div class="recipe-detail-info">
			<h1>${recipe.recipeDto.recipeTitle}</h1>
			<span>${recipe.recipeDto.recipeInfo}</span>
		</div>
		<div class="title-icon-box">
			<div>
				<i class="fa-regular fa-clock"></i>
				<span>${recipe.recipeDto.recipeTime}</span>
			</div>
			<div>
				<i class="fa-regular fa-hashtag"></i>
				<span>${recipe.recipeDto.recipeHashtag}</span>
			</div>
			<div>
				<i class="fa-solid fa-kitchen-set"></i>
				<span>${recipe.recipeDto.recipeDifficulty}</span>
			</div>
		</div>
		<div class="ingredient-list-box">
			<c:forEach var="ingredient" items="${recipe.recipeDetailIngredientList}">
			    <ul>
			    	<li>
					    ${ingredient.recipeIngredientName}
			    	</li>
			    </ul>
			</c:forEach>
		</div>
		<div>
			<div class="recipe-detail-write-info">
				<span>작성일: ${recipe.recipeDto.recipeWritetime}</span>
				<span>요리사: ${recipe.recipeDto.recipeNick}</span>
			</div>
		</div>
	</div>
	<!-- 디테일 제목 영역 끝  -->
	<div class="recipe-detail-contentBox">
		<div class="w-100">
			<h2>조리 방법</h2>
		</div>
		<c:forEach var="recipeContent" begin="0" end="${fn:length(recipe.recipeContentList)-1}" step="1" items="${recipe.recipeContentList}">
		<c:set var="num" value="${num+1}"></c:set>
		<div class="recipe-detail-content">
			<img class="content-image" src = "${pageContext.request.contextPath}/rest/download/${recipeContent.recipeContentAttachmentNo}">
			<span>
				<div>${num}</div>
				${recipeContent.recipeContentText}
			</span>
		</div>
		</c:forEach>
	</div>
	<!-- 디테일 컨텐츠 영역 끝 -->
	<div class="btn-box">
		<a href="#" class="btn btn-positive">다른 요리 보러가기</a>
	</div>
	
</div>

<script type="text/javascript">

</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>