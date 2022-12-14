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
			left:100px;
		}
		
		.main-1 {
			position: relative;
			height: 500px;
		}
		
		.img-box {
			position: absolute;
			top: 0px;
			left: 0px;
			width: 100%;
			height: 300px;
			border-radius: 10px 10px 0 0;
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
			left: 400px;
		}
		
		.main-heading-text {
			position: relative;
		}
		

		
		.cnt {
			font-size: 40px;
			font-weight: bold;
		}

		
		.view-count,
		.like-count {
			position: relative;
			left: 10px;
			top: 290px;
			font-size:13px;
			color: #757575;
		}
		
		.like-count {
			position: relative;
			left: 30px;
		}
		
		.recipe-title {
			color: #373A3C;
			font-size: 23px;
			font-weight: bold;
			line-height: 550px;
			padding: 15px;
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
		

		

		
	</style>
	
	<div class="container-1300">
		<div class="mt-10 mb-40 main-heading">
			<h1>
				<span class="main-heading-text">${loginNick}님이 당장 할  수 있는 요리를 추천해드릴게요.</span>
			</h1>
		</div>
		
		<div class="border-box">
			<div class="add-recipe-box main-box-shadow main-1 container-300 float-left">
				<div class="img-box">
						<div class="hash-tag">매콤한</div>
						<img class="main-1-img" src="/images/test.jpg">
					</div>
					
							<span class="view-count">조회수 10,000 </span>
							<span class="like-count">좋아요 1,000</span>
							<div class="recipe-title mt-20">매콤한 제육볶음 만들기</div>
							<div class="how-long mt-10 me-5">
								<i class="fa-regular fa-clock"></i>
								10분 이내
							</div>
							<div class="cooking-level">재료가 충분해요</div>							
								<div class="hashtag-box mt-10">
									재료명(반복문)
							</div>
						</div>

				</div>
			</div>
			
					<div class="border-box">
			<div class="add-recipe-box main-box-shadow main-1 container-300 float-left">

								<div class="img-box">
								<div class="hash-tag">매콤한</div>
								<img class="main-1-img" src="/images/test.jpg">
							</div>
							<span class="view-count">조회수 10,000 </span>
							<span class="like-count">좋아요 1,000</span>
							<div class="recipe-title mt-20">recipe info</div>
							<div class="how-long mt-10 me-5">
								<i class="fa-regular fa-clock"></i>
								10분 이내
							</div>
							<div class="cooking-level">재료가 충분해요</div>							
								<div class="hashtag-box mt-10">
									<div>재료명(반복문)</div>
								</div>
						</div>
				</div>
				
									<div class="border-box">
			<div class="add-recipe-box main-box-shadow main-1 container-300 float-left">

								<div class="img-box">
								<div class="hash-tag">매콤한</div>
								<img class="main-1-img" src="/images/test.jpg">
							</div>
							<span class="view-count">조회수 10,000 </span>
							<span class="like-count">좋아요 1,000</span>
							<div class="recipe-title mt-20">recipe info</div>
							<div class="how-long mt-10 me-5">
								<i class="fa-regular fa-clock"></i>
								10분 이내
							</div>
							<div class="cooking-level">재료가 충분해요</div>							
								<div class="hashtag-box mt-10">
									<div>재료명(반복문)</div>
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

	


