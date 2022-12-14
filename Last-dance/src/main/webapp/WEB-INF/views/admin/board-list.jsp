<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
<div class="container-fluid mt-5">

	<div class="row mt-5">
		<div class="col-lg-4 offset-lg-4 col-md-6 offset-md-3 col-sm-8 offset-sm-2">
			<table class="table">
				<thead>
					<tr>
						<th><input type="checkbox" class="check-all"></th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
<!-- 						<th>작성일</th> -->
<!-- 						<th>댓글수</th> -->
					<tr>
				</thead>
				<tbody>
					<c:forEach var="boardDto" items="${boardList}">
						<tr>
							<td><input type="checkbox" class="check-item"></td>
							<td>${boardDto.boardTitle}</td>
							<td>${boardDto.memberNick}</td>
							<td>${boardDto.boardClick}</td>
<%-- 							<td>${boardDto.boardWritetime}</td> --%>
<%-- 							<td>${boardDto.}</td> --%>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>        	
	</div>

 </div>
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>