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
    
    <!-- 상대 경로 설정을 위한 변수 선언 -->
    <script>
	   var root = "${pageContext.request.contextPath}";
	</script>
    
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
    	/* 폰트 */
		@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
		*{ font-family: 'Noto Sans KR', sans-serif; }
		p{ font-family: 'Noto Sans KR', sans-serif !important; }
		    
		/* 테이블 호버 수정 */
		.table-link tbody tr { background-color:white; }
		.table-link tbody tr:hover { background-color:#ececec; transition: 0.3s; }
		
		/* 노란버튼, 기본 버튼 수정 */
		.yellow-btn { background-color:#ECBE42;	color:white; }
		.btn-light:hover { background-color:#e9ecef; transition: 0.3s; }
		
		/* 체크박스 이벤트 */
		.icon-check-all,
		.icon-check-item{
			cursor: pointer;
		}
		
		/* 헤더 관리자 닉네임 포인터 금지 */
		.admin-nick,
		.admin-nick:hover {
			cursor: default;
			color: #737373;
		}
		
		/* 검색창 돋보기 추가 */
		.btn-search {
			background-color: white;
			border: 1px solid rgba(0,0,0,.1);
			border-top-right-radius: 10%;
			border-bottom-right-radius: 10%;
			border-left: none;
			padding: 0 0.5em 0.2em 0.5em;
		}
		.input-keyword{
			border-right: none;
		}
		
		/* 재료 수정하기 css */
		.edit-btn{ color: white; cursor: pointer; }
		.edit-btn:hover{ color: black; }
		
		/* 멤버 비활성화 보기 */
		.only-disabled{ background-color: grey; color: white; }
		.only-disabled:hover{
			background-color: #EAECEF !important;
			color: black !important;
			transition: 0.3s !important;
		}
		
		/* 페이지네이션 css */
		.pagination { cursor:pointer; }
		.pagination .disabled { cursor:default; }
		.disabled-list:hover{ background-color: grey; color: white; }
		.custom-pagination.pagination > .page-item{
			color: #637688;
		}
		.custom-pagination.pagination > .page-item.disabled{
			color: #b2bcc7;
		}
		.custom-pagination.pagination > .page-item > .page-link{
			color: inherit;
		}
		.custom-pagination.pagination > .active > a:hover{
			background: #a2cc85;
			border-color: #a2cc85;
			color: white!important;
		}
		.custom-pagination.pagination > .active > a, 
		.custom-pagination.pagination > .active > a:focus{
			background: #98C778;
			border-color: #98C778;
			color: white!important;
		}
		
		.history-link,
		.history-link a{
			color: grey;
			font-size: 14px;
		}
    </style>
</head>
<body>

<!-- 헤더 영역 시작 -->
<div class="container-fluid">
    <div class="col-md-10 offset-md-1">
        <!-- navbar : 드롭다운 메뉴를 제공하는 상단 메뉴바 -->
        <!-- <nav class="navbar navbar-expand-lg navbar-light bg-light"> -->

        <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top d-lg-flex 
        	pt-0 pb-0 flex-column align-items-lg-center">
            <div class="container-fluid">
            	<div class="col-lg-8 offset-lg-2 d-lg-flex flex-row align-items-center">
	                <!-- brand : 로고 이미지와 대표 상호를 적는 공간 -->
	                <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/">
	                    <img width="200px" src="${pageContext.request.contextPath}/images/logo.png"/>
	                </a>
	                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
	                    data-bs-target="#navbarColor03" 
	                    aria-controls="navbarColor03" 
	                    aria-expanded="false"
	                    aria-label="Toggle navigation">
	                    <span class="navbar-toggler-icon"></span>
	                </button>
	
	                <!-- 메뉴 영역 -->
	                <div class="collapse navbar-collapse h-100" id="navbarColor03">
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
	                            </div>
	                        </li>
	                        <!-- 고객센터 -->
	                        <li class="nav-item dropdown">
	                            <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button"
	                                aria-haspopup="true" aria-expanded="false">고객센터</a>
	                            <div class="dropdown-menu">
	                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/notice/list">공지사항</a>
	                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/center/list">1:1문의</a>
	                            </div>
	                        </li>
	
	                        <li class="nav-item">
	                            <a class="nav-link" href="${pageContext.request.contextPath}/">회원 페이지</a>
	                        </li>
	                        <li class="nav-item">
	                            <a class="nav-link logout-btn" href="${pageContext.request.contextPath}/admin/logout">logout</a>
	                        </li>
	                    </ul>
						<span class="navbar-text">
	                            <span class="nav-link admin-nick">${loginNick}님</span>
						</span>
                   	</div>
                </div>
            </div>
      </nav>
   </div>
</div>