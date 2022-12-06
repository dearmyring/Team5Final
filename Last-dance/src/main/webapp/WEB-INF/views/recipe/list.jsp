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
					<th>레시피번호</th>
					<th>레시피명</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>좋아요</th>
					<th>메뉴</th>
				</tr>
			</thead>
			<tbody align="center">
			<c:forEach var = "recipeList" items = "${recipeList}">
				<tr>
					<td>${recipeList.recipeNo}</td>
					<td><a href = "detail?recipeNo=${recipeList.recipeNo}">${recipeList.recipeHashtag} / ${recipeList.recipeTitle}</a></td>
					<td>${recipeList.recipeId}</td>
					<td>${recipeList.recipeWritetime}</td>
					<td>${recipeList.recipeClick}</td>
					<td>${recipeList.recipeLike}</td>
					<td>
						<a class="btn btn-neutral" style="padding:4px;" href = "edit?recipeNo=${recipeList.recipeNo}">수정</a>
						<a class="btn btn-neutral" style="padding:4px;" href = "delete?recipeNo=${recipeList.recipeNo}">삭제</a>
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

	


