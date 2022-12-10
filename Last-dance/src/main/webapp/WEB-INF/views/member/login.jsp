<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 글꼴 Noto Sans Korean -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<!-- css commons -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/commons-ring-join.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css">
	
	
	<div class="container-300 center screen-center">
		<!-- 로고 -->
		<div>
			<a href="/">
				<img src="/images/logo.png" style="width: 80%">
			</a>
		</div>
		<!-- 로그인 폼 -->
		<form action="login" method="post">
			<div>
				<input class="w-100 login-input-email" name="memberId" type="text" autocomplete="off" placeholder="이메일">
			</div>
			<div>
				<input class="w-100 login-input-password" name="memberPw" type="password" placeholder="비밀번호">
			</div>
			<div>
				<button class="w-100 mt-10 btn btn-positive" type="submit">로그인</button>
			</div>
		</form>
		<!-- 타 경로 안내 -->
		<div class="mt-20">
			<div class="float-left">
				<a href="find_pw">
					비밀번호 찾기
				</a>
			</div>
			<div class="float-right">
				<a href="join">
					회원가입
				</a>
			</div>
		</div>
	</div>
	<!-- 에러처리 -->
    <c:if test="${param.error != null}">
		<div class="container-400 screen-bottom notice-in notice-out">
			<div class="w-100 btn fail-btn">이메일 주소나 비밀번호가 틀립니다.</div>
		</div>
	</c:if>
	
