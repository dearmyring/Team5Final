<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param name="title" value="마이페이지"/>
</jsp:include>

<!-- swiper 의존성 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>

<style>
	.thumbnail-image {
		width: 600px;
		height: 400px;
	}
	
	.content-image {
		width: 600px;
		height: 400px;
	}
	
	.recipe-detail-container {
		width: 1200px;
		margin: auto;
	}
	
	.recipe-detail-titleBox {
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	
	.recipe-detail-titleBox > div {
		width: 600px;
	}
	
	.recipe-detail-titleBox > div:nth-child(1) {
		display: flex;
		justify-content: flex-end;
	}
	
	.recipe-detail-titleBox > div:nth-child(3) {
/* 		display: flex; */
/* 		flex-direction: column; */
	}
	
	.title-icon-box {
		display: flex;
		flex-direction: row;
		justify-content: space-evenly;
	}
	
	.title-icon-box > div {
		display: flex;
		flex-direction: column;
/* 		justify-content: center; */
		align-items: center;
	}
	
	.title-icon-box > div > i {
		font-size: 40px;
	}
	
	.ingredient-list-box {
		display: flex;
	    flex-wrap: wrap;
	    flex-grow: 1;
	}
	
	.ingredient-list-box li {
		background-color: #8BC96E;
	    font-size: 14px;
	    border-radius: 5px;
	    height: 26px;
	    margin-right: 10px;
	    margin-bottom: 10px;
	    padding: 4px 17px;
	    color: white;
	    font-weight: 400;
	}
	
	.recipe-detail-titleBox > div:nth-child(6) > div {
		display: flex;
		justify-content: flex-end;
	}
	
	/* 디테일 페이지 타이틀 영역 끝 */
	
	
	.recipe-detail-contentBox {
		border-top: 1px solid #CBCACA;
		margin-top: 30px;
		display: flex;
		flex-direction: column;
		flex-wrap: wrap;
		align-items: center;
	}
	
	.recipe-detail-contentBox > div:nth-child(1) {
		margin-top: 50px;
	}
	
	.recipe-detail-contentBox > div {
		display: flex;
		flex-direction: column;
		margin-bottom: 50px;
	}
	
	.recipe-detail-contentBox > div > img {
		margin-bottom: 30px;
	}
	
	.recipe-detail-contentBox > div > span {
		text-align: center;
	}
	
	
</style>

<div class="recipe-detail-container">
	<div class="recipe-detail-titleBox">
		<div>
			<span>조회수 ${recipe.recipeDto.recipeClick}</span>
			<span>좋아요 ${recipe.recipeDto.recipeLike}</span>
		</div>
		<div class="swiper">
			<div class="swiper-wrapper">
				<c:forEach var="recipeImg" items="${recipe.recipeImages}">
				<div class="swiper-slide">
				    <img class="thumbnail-image" src = "${pageContext.request.contextPath}/rest/download/${recipeImg.recipeAttachmentNo}">
				</div>
				</c:forEach>
			</div>
		</div>
		<div>
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
			<div>
				<span>${recipe.recipeDto.recipeWritetime}</span>
				<span>${recipe.recipeDto.recipeNick}</span>
			</div>
		</div>
	</div>
	<!-- 디테일 제목 영역 끝  -->
	
	<div class="recipe-detail-contentBox">
		<c:forEach var="recipeContent" begin="0" end="${fn:length(recipe.recipeContentList)}" items="${recipe.recipeContentList}">
			<div>
				<img class="content-image" src = "${pageContext.request.contextPath}/rest/download/${recipeContent.recipeContentAttachmentNo}">
				<span>${recipeContent.recipeContentText}</span>
			</div>
		</c:forEach>
	</div>
	<!-- 디테일 컨텐츠 영역 끝 -->
	
</div>

<script type="text/javascript">

$(function(){
    var swiper = new Swiper('.swiper', {
        // Optional parameters
        direction: 'horizontal', // 슬라이드 방향
        loop: true, // 반복 여부

        //페이징
        pagination: {
            el: '.swiper-pagination', //페이징 적용 대상
            type: "bullets", //페이징 도구 모양
            clickable: true //클릭 가능 여부
        },

        //자동 재생 옵션
        autoplay: {
            delay: 3500,//자동 재생 간격(ms)
        },

        //effect:"slide", //슬라이드 방식(기본)
        //effect:"fade",//페이드인-아웃 효과
        effect:"fade",//카드 전환 효과

        });
});

</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>