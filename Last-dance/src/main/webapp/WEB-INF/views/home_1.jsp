<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		
		
		.main-1 {
			height: 645px;
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
		
	</style>
	
	<div class="container-1300">
			<div class="mt-10 mb-40 main-heading">
				<h1>
					<img class="megaphone" src="/images/main-megaphone-2.png">
					<span class="main-heading-text">냉장고 속 식재료를 입력해보세요 🔍</span>
				</h1>
			</div>
	
			<div class="add-recipe-box main-box-shadow main-1 container-450 float-left">
				
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
					<div class="right"><%= sf.format(nowTime) %></div>
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
				</div>
			</div>
		
	</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>