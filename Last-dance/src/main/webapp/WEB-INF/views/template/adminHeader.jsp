<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

	<title>냉장고를 부탁해</title>

    <!-- 폰트어썸 -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>

    <!-- jquery 사용 위한 라이브러리 파일 불러옴 -->
    <script src="https://code.jquery.com/jquery-3.6.1.js"></script>

    <!-- Required meta tags -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <!-- Bootswatch CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.0.2/litera/bootstrap.min.css" integrity="sha512-WC/IImFzoPRFTlJQpUSqaM1QOKsIWIfrmhkkXRXoDeB9hlArdsUAWOURes+oFcDRPUUZhuc2QdyfaZEGXjd6kg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
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
                <a class="col-lg-3 col-md-4 navbar-brand" href="${pageContext.request.contextPath}/admin/">
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

                        <!--
                            메뉴 항목
                            - .active는 활성화된 메뉴 (현재 메뉴), 상황에 따라 맞는 메뉴에 추가
                        -->
                        <li class="nav-item">
                            <a class="nav-link active" href="#">Home
                                <span class="visually-hidden">(current)</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Page</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Pricing</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">About</a>
                        </li>

                        <!-- 드롭다운 메뉴 -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button"
                                aria-haspopup="true" aria-expanded="false">레시피</a>
                            <div class="dropdown-menu">
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/list">목록</a>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/write">등록</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
</div>

<div class="mt-5">&nbsp;</div>