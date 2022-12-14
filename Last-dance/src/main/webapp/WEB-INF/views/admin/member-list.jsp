<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
<div class="mt-5 col-6 offset-3">
<select name="sort">
	<option value="member_join desc">최근 가입일 순</option>
	<option value="member_login desc">최근 방문자 순</option>
	<option value="member_disabled desc">비활성화 순</option>
</select>
<table class="table">
	<thead>
		<tr>
			<th>아이디</th>
			<th>닉네임</th>
			<th>전화번호</th>
			<th>성별</th>
			<th>포인트</th>
			<th>가입일</th>
			<th>최근접속일</th>
			<th>비활성화</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="memberDto" items="${memberList}">
			<tr>
				<td>${memberDto.memberId}</td>
				<td>${memberDto.memberNick}</td>
				<td>${memberDto.memberPhone}</td>
				<td>${memberDto.memberGender}</td>
				<td>${memberDto.memberPoint}</td>
				<td>${memberDto.memberJoin}</td>
				<td>${memberDto.memberLogin}</td>
				<td>
				<c:choose>
					<c:when test="${memberDto.memberDisabled == 'N'}">
						<i class="fa-regular fa-square"></i>
					</c:when>
					<c:otherwise>
						<i class="fa-solid fa-square"></i>
					</c:otherwise>
				</c:choose>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</div>
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>