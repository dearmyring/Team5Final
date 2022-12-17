<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

	<title>냉장고를 부탁해</title>
	
	<!-- 폰트 noto-sans -->
	<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin><link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

    <!-- 폰트어썸 -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>

    <!-- jquery 사용 위한 라이브러리 파일 불러옴 -->
    <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
    
    <!-- js 파일 -->
    <script src="${pageContext.request.contextPath}/js/header.js"></script>
    <script src="${pageContext.request.contextPath}/js/check-icon.js"></script>
    
    <!-- Required meta tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <!-- Bootswatch CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.0.2/litera/bootstrap.min.css" integrity="sha512-WC/IImFzoPRFTlJQpUSqaM1QOKsIWIfrmhkkXRXoDeB9hlArdsUAWOURes+oFcDRPUUZhuc2QdyfaZEGXjd6kg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
    <style>
    	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
		*{ font-family: 'Noto Sans KR', sans-serif; }
		.table-link tbody tr { background-color:white; }
		.table-link tbody tr:hover { background-color:#ececec; transition: 0.3s; }
		
		.yellow-btn { background-color:#ECBE42;	color:white; }
		.btn-light:hover { background-color:#e9ecef; transition: 0.3s; }
		
		.pagination { cursor:pointer; }
		.pagination .disabled { cursor:default; }
		
		.icon-check-all,
		.icon-check-item{
			cursor: pointer;
		}
    </style>
</head>
<body>

<!-- 헤더 영역 시작 -->
<div class="container-fluid">
    <div class="col-md-10 offset-md-1">
        <!-- navbar : 드롭다운 메뉴를 제공하는 상단 메뉴바 -->
        <!-- <nav class="navbar navbar-expand-lg navbar-light bg-light"> -->

        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="col-lg-8 offset-lg-2 col-md-10 offset-md-1 container-fluid">
                <!-- brand : 로고 이미지와 대표 상호를 적는 공간 -->
                <a class="col-2 navbar-brand" href="${pageContext.request.contextPath}/admin/">
                    <img class="w-100" src="${pageContext.request.contextPath}/images/logo.png"/>
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarColor03" 
                    aria-controls="navbarColor03" 
                    aria-expanded="false"
                    aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!-- 메뉴 영역 -->
                <div class="collapse navbar-collapse" id="navbarColor03">
                    <ul class="navbar-nav me-auto">
                        <!-- 드롭다운 메뉴 -->
                        <!-- 레시피 -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button"
                                aria-haspopup="true" aria-expanded="false">레시피</a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/recipe/list">레시피 목록</a>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/recipe/write">레시피 등록</a>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/ingredient/list">재료 목록</a>
                            </div>
                        </li>
                        <!-- 유저 관리 -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button"
                                aria-haspopup="true" aria-expanded="false">매니지먼트</a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/member/list">사용자 관리</a>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/board/list">유저 게시판</a>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/notice/list">고객센터</a>
                            </div>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/">회원 페이지</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link logout-btn" href="${pageContext.request.contextPath}/admin/logout">logout</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">${loginNick}님</a>
                        </li>
                    </ul>
                </div>
            </div>
		</nav>
	</div>
</div>