<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<style>
	.table > thead {
    	font-size: 16px;
    }
    .table > tbody {
    	font-size: 14px;
    }
	
	/* 확장 스타일 : 옆트임 테이블*/
    .table.table-slit > thead > tr,
    .table.table-slit > tfoot > tr{
    	background-color: #efefef;
    	border: 2px solid gray;
    }
    
    /* 확장스타일 : 테두리가 있는 테이블 */
    .table.table-border > thead > th,
    .table.table-border > thead > td,
    .table.table-border > tbody > tr,
    .table.table-border > tbody > td{
    	border: 2px solid gray;
    }
</style>
<div class = "container-1100 mt-40 mb-40">
	<div class = "row center">
		<h1>게시판 리스트</h1>
	</div>
	
	<div class="row mt-30">
		<table class="table table-slit table-border"> <!-- border="1" width="1000"> -->
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>내용</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>좋아요</th>
				</tr>
			</thead>
			<tbody align="center">
			<c:forEach var = "boardList" items = "${boardList}">
				<tr>
					<td>${boardList.boardNo}</td>
					<td><a href = "detail?boardNo=${boardList.boardNo}">${boardList.boardTitle}</a></td>
					<td>${boardList.memberNick}</td>
					<td>${boardList.boardContent}</td>
					<td>${boardList.boardWriteTime}</td>
					<td>${boardList.boardClick}</td>
					<td>${boardList.boardLike}</td>
					<td>
						<a class="btn btn-neutral" style="padding:4px;" href = "edit?recipeNo=${boardList.boardNo}">수정</a>
						<a class="btn btn-neutral" style="padding:4px;" href = "delete?recipeNo=${boardList.boardNo}">삭제</a>
				</tr>
				</c:forEach>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="8" align="right">
						<a href = "write"><i class="fa-solid fa-plus"></i> 등록</a>
					</td>
				</tr>
			</tfoot>
		</table>
		</div>
</div>

	


