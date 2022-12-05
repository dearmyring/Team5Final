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
		<h1>레시피 리스트</h1>
	</div>
	
	<div class="row mt-30">
		<table class="table table-slit table-border"> <!-- border="1" width="1000"> -->
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>메뉴</th>
				</tr>
			</thead>
			<tbody align="center">
				<c:forEach var = "list" items = "${list}">
				<tr>
					<td>${list.recipeNo}</td>
					<td><a href = "detail?recipeNo=${list.recipeNo}">${list.recipeTitle}</a></td>
					<td>${list.recipeId}</td>
					<td>${list.recipeWritedate}</td>
					<td>${list.recipeClick}</td>
					<td>
						<a class="btn btn-neutral" style="padding:4px;" href = "editAdmin?noticeNo=${list.recipeNo}">수정</a>
						<a class="btn btn-neutral" style="padding:4px;" href = "deleteAdmin?noticeNo=${list.recipeNo}">삭제</a>
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

	


