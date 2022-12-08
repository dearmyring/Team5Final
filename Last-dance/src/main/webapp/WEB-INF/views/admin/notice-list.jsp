<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="mt-5">&nbsp;</div>
<h3>공지사항 리스트</h3>
<table class="table table-hover">
	<thead>
		<tr>
			<th><input class="check-all" type="checkbox"></th>
			<th>공지번호</th>
			<th>제목</th>
			<th>작성자</th>
		</tr>
	</thead>
	<tbody>
<c:forEach var="noticeDto" items="${noticeList}">
		<tr>
			<td><input class="check-item" type="checkbox"></td>
			<td>${noticeDto.noticeNo}</td>
			<td><a href="detail/${noticeDto.noticeNo}">${noticeDto.noticeTitle}</a></td>
			<td>${noticeDto.noticeNick}</td>
		</tr>
</c:forEach>
	</tbody>
</table>

<button type="button" class="notice-async-delete">삭제하기</button>
<a href="write">작성하기</a>

<script type="text/javascript">
	$(function(){
		$(".notice-async-delete").click(function(){
			
			var noticeNo = new Array();
			
			$(".check-item:checked").each(function(){
				 var num=$(this).parent().next().text();
				 noticeNo.push(num);
			});
			
			$.ajax({
				url: "http://localhost:8888/rest/notice",
				method: "delete",
				contentType: "application/json",
				data: JSON.stringify(noticeNo),
				success: function(resp){
					console.log(resp);
				}
			});
		});
	});
</script>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include><!DOCTYPE html>
