<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param name="title" value="메인페이지"/>
</jsp:include>

<div>
	<form action="pwConfirm" method="post">
		<label for="pwConfirm">비밀번호 확인</label>
		<input name="inputPw" id="pwConfirm" type="password" placeholder="비밀번호를 입력해주세요"/>
		<button type="submit">확인</button>
	</form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>