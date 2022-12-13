
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="login" value="${loginId != null}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>냉장고를 부탁해</title>

	<!-- 글꼴 Noto Sans Korean -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

    <!-- css 파일 -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/commons.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/commons-ring-join.css">

    <!-- 폰트어썸 -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>

    <!-- jquery 사용 위한 라이브러리 파일 불러옴 -->
    <script src="https://code.jquery.com/jquery-3.6.1.js"></script>

    <!-- js 파일 -->
    <script src="${pageContext.request.contextPath}/js/header.js"></script>
    
</head>
<body>

	<!-- 헤더 영역 시작 -->
	<header class="header-fixed">
	    <div id="header">
	        <div>
	           <div class="logo-box">
	                <div>
	                    <a href="/"><img src="${pageContext.request.contextPath}/images/logo.png" class="logo"/></a>
	                </div>
	           </div>
	           <div class="menu-list-box">
	                <ul class="menu-list">
	                    <li><a href="/recipe/list">전체보기</a></li>
	                    <li><a href="#">통합검색</a></li>
	                    <li><a href="#">커뮤니티</a></li>
	                </ul>
	           </div>
	           <div class="sign-tab">
		           <nav>
		                <ul class="dropdown-nav">
		                	<c:choose>
		                		<c:when test="${login}">
				                    <li class="right-menu">
				                    	${loginNick}
				                    	<ul>
		             						<li><a href="/mypage/list">마이페이지</a></li>
											<li><a href="/member/logout">로그아웃</a></li>
				                    	</ul>
				                    </li>
		                		</c:when>
		                		<c:otherwise>
		        					<li><a href="/member/login">로그인</a></li>
				                    <li><a href="/member/join">회원가입</a></li>
		                		</c:otherwise>
		                	</c:choose>
		                </ul>
		           </nav>
	           </div>
	        </div>
	    </div>
	    <div class="header-area">
		<!-- 헤더 영역 끝-->
	    </div>
    </header>
    <!-- 컨텐츠 영역 시작 -->
    <div class="content-area">
    </div>
  