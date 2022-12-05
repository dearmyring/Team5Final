<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param name="title" value="메인페이지"/>
</jsp:include>

<h1>정보수정페이지</h1>
<form action="infoEdit" method="post">
	<div>
		<div>
			<label for="memberId">이메일</label>
			<input id="memberId" type="text" name="memberId" readonly value="${userInfo.memberId}"/>
			<span>@</span>
			<input type="text"  readonly/> <!-- name="emailAddress" -->
		</div>
		<div>
			<label for="memberPw">비밀번호</label>
			<input id="memberPw" type="password" name="memberPw"/>
		</div>
		<div>
			<label for="memberPwRe">비밀번호 확인</label>
			<input id="memberPwRe" type="password"/>
		</div>
		<div>
			<label for="memberNick">닉네임</label>
			<input id="memberNick" type="text" name="memberNick" value="${userInfo.memberNick}"/>
		</div>
		<div>
			<label>성별</label>
			<c:choose>
				<c:when test="${userInfo.memberGender}=M">
					<input id="genderM" type="radio" name="memberGender" value="M" checked/>
					<label for="genderM">남</label>
					<input id="genderF" type="radio" name="memberGender" value="F"/>
					<label for="genderF">여</label>
				</c:when>
				<c:otherwise>
					<input id="genderM" type="radio" name="memberGender" value="M"/>
					<label for="genderM">남</label>
					<input id="genderF" type="radio" name="memberGender" value="F" checked/>
					<label for="genderF">여</label>
				</c:otherwise>
			</c:choose>
		</div>
		<div>
			<label for="memberPhone">휴대폰 번호</label>
			<input id="memberPhone" type="text" name="memberPhone" value="${userInfo.memberPhone}"/>
		</div>
		<div>
			<button type="submit">변경하기</button><!-- 구현 완료 후 type submit으로 변경 -->
			<button class="withDrawal" type="button">탈퇴하기</button>
		</div>
	</div>
</form>

	<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
	     <script>
	        $(function(){
	            $(".withDrawal").click(function() {
	                var choice = confirm("ㄹㅇ 탈퇴?");
	                if(choice == true) {
	                	$(location).attr('href', 'http://localhost:8888/mypage/deleteMember');
	                }
	            });
	        });
     </script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>