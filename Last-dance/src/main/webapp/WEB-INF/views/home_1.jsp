<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy.MM.dd E HH:mm");
%>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="냉장고를 부탁해" name="title"/>
</jsp:include>
	<style>
		.border-box {
			position: relative;
			left:60px;
		}
		
		.main-1 {
			position: relative;
			height: 645px;
		}
		
		.img-box {
			position: absolute;
			bottom: 0px;
			left: 0px;
			width: 100%;
			height: 400px;
			border-radius: 0 0 10px 10px;
			overflow: hidden;
		}
		
		.main-1-img {
			width: 100%;
			height:100%;
			object-fit:cover;
		}
		
				
		.hash-tag {
			position: relative;
			top: 50px;
			left: 20px;
		   	border: none;
		    font-size: 15px;
		    padding: 0.5em 1em 0.5em 1em;
		    display: inline-block;
		    text-align: center;
		    text-decoration: none;
		    border-radius: 10px;
		    color: #373A3C;
		    background-color: #EEEEEE;
		}
		
		.main-2 {
			height: 160px;
		}
		
		.main-3 {
			height: 200px;
		}
		
		.main-4 {
			height: 380px;
		}
		
		.main-5 {
			height: 500px;
		}
		
		.sub-heading {
			position: relative;
			bottom: 13px;
			left: 10px;
		}
		
		.megaphone {
			width: 100px;
			position: relative;
			top: 40px;
		}
		
		.main-heading {
			position: relative;
			bottom: 13px;
			left: 50px;
		}
		
		.main-heading-text {
			position: relative;
			left: 10px;
		}
		
		.customer-service {
		    border: none;
		    font-size: 15px;
		    padding: 0.75em;/*글자 크기의 0.75배*/
		    cursor: pointer;
		    /* a 태그를 버튼으로 만들기 위해 추가 */
		    display: inline-block;
		    text-align: center;
		    text-decoration: none;
		    border-radius: 5px;
	        background-color: #FEE102;
		    color: black;
		    font-weight: bold;
		}
		
		.cnt {
			font-size: 40px;
			font-weight: bold;
		}
		
		.now-date {
			font-size: 13px;
			font-weight: 100;
		}
		
		.today-add-icon {
			font-size: 20px;
			color: #6FAB5B;
			position: relative;
			top:10px;
		}
		.today-add-num {
			font-size: 20px;
			color: #6FAB5B;
			position: relative;
			top: 5px;
			left: 5px;
		}
		
		.top-ranker {
			width: 60%;
			
		}
		
		.top-ranker-nick {
			font-size: 25px;
			font-weight: bold;
		}
		
		.badge {
			width: 10%;
		}
		
		.view-count,
		.like-count {
			position: relative;
			left: 20px;
			top: 15px;
			font-size:13px;
			color: #757575;
		}
		
		.like-count {
			position: relative;
			left: 30px;
		}
		
		.recipe-title {
			color: #373A3C;
			font-size: 25px;
			font-weight: bold;
			line-height: 30px;
			padding: 20px;
		}
		
		.how-long,
		.cooking-level {
			position: relative;
			left: 20px;
		}
		
		.how-long {
			display: inline-block;
			border: none;
			background-color: #EDEDED;
			text-align: center;
			padding: 0.5em 1em 0.5em 1em;
			border-radius: 10px;
			font-weight: 600;
			color: #757575;
			font-size:15px;
		}
		
		.cooking-level {
			display: inline-block;
			border: none;
			background-color: #ECBE42;
			text-align: center;
			padding: 0.5em 1em 0.5em 1em;
			border-radius: 10px;
			font-weight: 600;
			color: white;
			font-size:15px;
		}
		
		.hashtag-box {
			position: relative;
			left: 20px;
			display: inline-block;
			border: none;
			background-color: #8BC96E;
			text-align: center;
			padding: 0.5em 1em 0.5em 1em;
			border-radius: 10px;
			font-weight: 600;
			color: white;
			font-size:15px;
		}
		
		.swiper-button-next::after,
		.swiper-button-prev::after {
		  display: none;
		}
		
		.hashtag-box-scroll {
			margin-top: 3px;
			margin-right: 10px;
			height: 90px;
			overflow: auto;
		}
		
		.hashtag-box-scroll::-webkit-scrollbar {
			width: 7px;
		}
		
		.hashtag-box-scroll::-webkit-scrollbar-track {
		  border-radius: 10px;
		  border: 1px solid #EDEDED;
		}
		
		.hashtag-box-scroll::-webkit-scrollbar-thumb {
		  border-radius: 10px;
		  border: 1px solid #EDEDED;
		}
		
	</style>
	
	<div class="container-1300">
		<div class="mt-10 mb-40 main-heading">
			<h1>
				<img class="megaphone" src="/images/main-megaphone-2.png">
				<span class="main-heading-text">냉장고 속 식재료를 입력해보세요 🔍</span>
			</h1>
		</div>
		<div class="border-box">
			<div class="swiper add-recipe-box main-box-shadow main-1 container-450 float-left">
				<div class="swiper-wrapper">
					<c:forEach var="mainRecipe" items="${mainRecipeTop5}">
						<div class="swiper-slide">
							<span class="view-count">조회수 <fmt:formatNumber value="${mainRecipe.mainRecipeListTop5VO.recipeClick}" pattern="#,###"/></span>
							<span class="like-count">좋아요 <fmt:formatNumber value="${mainRecipe.mainRecipeListTop5VO.recipeLike}" pattern="#,###"/></span>
							<div class="recipe-title mt-20"><a href="/recipe/detail?recipeNo=${mainRecipe.mainRecipeListTop5VO.recipeNo}">${mainRecipe.mainRecipeListTop5VO.recipeInfo}</a></div>
							<div class="how-long mt-5 me-5">
								<i class="fa-regular fa-clock"></i>
								${mainRecipe.mainRecipeListTop5VO.recipeTime}분 이내
							</div>
							
							<div class="cooking-level">${mainRecipe.mainRecipeListTop5VO.recipeDifficulty}</div>
							<div class="hashtag-box-scroll">
							<c:forEach var="mainRecipeIngredient" items="${mainRecipe.recipeIngredientList}">
								<div class="hashtag-box mt-10">
									<div>${mainRecipeIngredient.recipeIngredientName}</div>
								</div>
							</c:forEach>
							</div>
							<div class="img-box">
								<div class="hash-tag">${mainRecipe.mainRecipeListTop5VO.recipeHashtag}</div>
								<img class="main-1-img" src="/images/test.jpg">
							</div>
						</div>
					</c:forEach>
				</div>
	            <div class="swiper-pagination"></div>
	            <div class="swiper-button-prev"></div>
	            <div class="swiper-button-next"></div>
			</div>
			
			<div class="add-recipe-box main-box-shadow main-2 container-300 float-left">
				<div>
					<span class="left">
						<img class="main-img-size" src="/images/main-customer-service.png">
					</span>
					<span class="sub-heading">
						고객센터
					</span>
					<div class="customer-service w-100 mt-10">무엇을 도와드릴까요?</div>
				</div>
			</div>
	
			<div class="add-recipe-box main-box-shadow main-3 container-300 float-left">
				<div>
					<span class="left">
						<img class="main-img-size" src="/images/main-add-recipe.png">
					</span>
					<span class="left sub-heading">
						등록된 레시피
					</span>
					<div class="cnt mt-10">
						<fmt:formatNumber value="${addRecipeCount.cnt}" pattern="#,###"/>개
						<span class="today-add-icon">
							<i class="fa-solid fa-caret-up"></i>
						</span>
						<span class="today-add-num">
							${todayAddCount.cnt}
						</span>
					</div>
					<div class="right mt-50 now-date"><%= sf.format(nowTime) %></div>
				</div>
			</div>
			
			<div class="add-recipe-box main-box-shadow main-4 container-300 float-left">
				<div>
					<span class="left">
						<img class="main-img-size" src="/images/main-thumbs-up.png">
					</span>
					<span class="left sub-heading">
						오늘의 활동왕
					</span>
					<div class="center mt-30">
						<img class="top-ranker" src="/images/main-firecracker.png">
					</div>
					<div class="center mt-10">
						<span class="top-ranker-nick">
							${todayMemberRanking.memberNick}
						</span>
						<span>
							<c:if test="${todayMemberRanking.memberBadge == 1}">
								<img class="badge" src="/images/badge-1.png">
							</c:if>
						</span>	 
					</div>
				</div>
			</div>
			
			<div class="add-recipe-box main-box-shadow main-5 container-300 float-left mt-30 mb-30">
				<div>
					<span class="left">
						<img class="main-img-size" src="/images/main-push-recipe.png">
					</span>
					<span class="left sub-heading">
						추천 레시피
					</span>
					<div class="push-recipe-top10">
						<c:forEach var="pushRecipe" items="${pushRecipe}">
							<div class="row mt-20 ">
								<span>${pushRecipe.recipeTitle}</span><br>
							</div>
							
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
	<script>
		$(function(){
			timer = setInterval( function() {
				$.ajax({
					url:"http://localhost:8888/rest/today_add",
					method:"get",
					success:function(resp){
						$(".today-add-num").text(resp.cnt);
					}
				});
			}, 5000);
			
			var swiper = new Swiper('.swiper', {
				direction: 'horizontal',//'vertical', == 화면슬라이드 방향 가로 세로방향 설정
                loop: true,//true, == 반복여부
                speed : 1000,
                //페이징 옵션
                pagination: {
                    el: '.swiper-pagination',
                    type: "bullets",
                    clickable: true,
                },

                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },

                autoplay: {
                    delay: 5000,//자동재생 간격(ms)
                },

                effect: "slide",

         	});
		});
	</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>