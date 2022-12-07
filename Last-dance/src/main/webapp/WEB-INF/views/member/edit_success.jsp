<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<!-- css commons -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/commons-ring-join.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css">
<title>비밀번호 변경 완료</title>
<style>
	.size-change {
		font-size: 13px;
	}
</style>
</head>
<body>
	<div class="container-400 screen-center">
		<div>
			<div class="center">
				<img src="/images/only_logo.png" style="width: 60%">
				<h1>비밀번호가 변경 되었습니다!</h1>
			</div>
			<div class="center mt-40 size-change">
				<div class="row">커뮤니티 활동에 참여해서 뱃지를 착용해보세요.</div>
				<div class="row">다양한 뱃지를 준비해두었어요.</div>
			</div>
		</div>
		<div class="center">
			<a class="btn btn-positive w-100 mt-40" href="../member/login">로그인하러 가기</a>
		</div>
	</div>
</body>
</html>