<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="자유 게시판" name="title" />
</jsp:include>


<style>
.table>thead {
	font-size: 16px;
}

.table>tbody {
	font-size: 14px;
}

/* 확장 스타일 : 옆트임 테이블*/
.table.table-slit>thead>tr, .table.table-slit>tfoot>tr {
	background-color: #efefef;
	border: 2px solid gray;
}

/* 확장스타일 : 테두리가 있는 테이블 */
.table.table-border>thead>th, .table.table-border>thead>td, .table.table-border>tbody>tr,
	.table.table-border>tbody>td {
	border: 2px solid gray;
}
</style>
<div class="container-1100 mt-40 mb-40">	
<%-- 	<!-- 검색창 -->
	<div class="row center">
		<form action="${pageContext.request.contextPath}/board/list"
			method="get">
			<h1>나만의 레시피를 공유해보세요!!</h1>
			<br><br>
			<h3>레시피를 작성/댓글 작성으로 참여도를 올려서 귀여운 뱃지를 착용해보세요 :)</h3>
			<select style="height: 21px" name="type">
				<option value="member_nick"
					<c:if test="${boardListSearchVo.type=='member_nick'}">selected</c:if>>닉네임</option>
				<option value="board_content"
					<c:if test="${boardListSearchVo.type=='board_content'}">selected</c:if>>제목</option>
			</select> <input type="search" name="keyword" autocomplete="off"
				placeholder="검색어" style="width:" required
				value="${boardListSearchVo.keyword}">
			<button
				style="background-color: #F0F8FF; border: solid 1px lightgray;"
				type="submit">검색</button>
		</form>
	</div> --%>

	<div class="row left mb-30">
		<form action="list" method="get">

			<select style="width: 200px; height: 21px;" name="sort"
				onchange="this.form.submit()">
				<!-- 추후 js.43번 참고해서 하기 -->
				<option value=>정렬</option>
				
				<option value="board_like"
					<c:if test="${boardListSearchVo.sort=='board_like'}">selected</c:if>>인기순</option>
					
				<option value="board_click"
					<c:if test="${boardListSearchVo.sort=='board_click'}">selected</c:if>>조회순</option>
			</select>
		</form>
	</div>
	<div class="row mt-30">
		<table class="table table-slit table-border">
			<!-- border="1" width="1000"> -->
			<thead>
				<tr>
					<th>제목</th>
					<th>작성자</th>
					<th>내용</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>좋아요</th>
					<td colspan="8" align="right"><a href="write"><i
							class="fa-solid fa-plus"></i> 등록</a></td>
				</tr>
			</thead>
			<tbody align="center">
				<c:forEach var="boardList" items="${boardList}">
					<tr>
						<td>${boardList.boardTitle}</a></td>
						<td>${boardList.memberNick}</td>
						<td><a href="detail?boardNo=${boardList.boardNo}">${boardList.boardContent}</td>
						<td>${boardList.boardWriteTime}</td>
						<td>${boardList.boardClick}</td>
						<td>${boardList.boardLike}</td>
						<td><a class="btn btn-neutral" style="padding: 4px;"
							href="edit?boardNo=${boardList.boardNo}">수정</a> <a
							class="btn btn-neutral" style="padding: 4px;"
							href="delete?boardNo=${boardList.boardNo}">삭제</a>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>




