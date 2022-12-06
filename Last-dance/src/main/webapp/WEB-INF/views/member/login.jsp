<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="로그인" name="title"/>
</jsp:include>
	<form action="login" method="post">
		<div>
			<input name="memberId" type="text" autocomplete="off" placeholder="이메일">
		</div>
		<div>
			<input name="memberPw" type="password" placeholder="비밀번호">
		</div>
		<div>
			<button type="submit">로그인</button>
		</div>
	</form>
	
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>