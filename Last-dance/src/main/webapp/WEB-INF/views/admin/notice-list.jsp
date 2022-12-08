<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="mt-5">&nbsp;</div>
<h3>공지사항 리스트</h3>
	<form class="noticeNoForm">
<table class="table table-hover">
	<thead>
		<tr>
			<th><input class="check-all" type="checkbox"></th>
			<th>공지번호</th>
			<th>제목</th>
			<th>작성자</th>
		</tr>
	</thead>
	<tbody class="notice-list">
		<c:forEach var="noticeDto" items="${noticeList}">
			<tr>
				<td><input class="check-item" name="noticeNo" value="${noticeDto.noticeNo}" type="checkbox"></td>
				<td>${noticeDto.noticeNo}</td>
				<td><a href="detail/${noticeDto.noticeNo}">${noticeDto.noticeTitle}</a></td>
				<td>${noticeDto.noticeNick}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
	</form>

<button type="button" class="notice-async-delete">삭제하기</button>
<a href="write">작성하기</a>

<script type="text/javascript">
	$(function(){
		/* 체크박스 선택 삭제 시 비동기 처리 */
		$(".notice-async-delete").click(function(){
			
			var param = $(".noticeNoForm input:checked").serialize();
			
			$.ajax({
				url: "http://localhost:8888/rest/notice?"+param,
				method: "delete",
				contentType: "application/json",
				success: function(resp){
					$(".notice-list").find("tr").remove();
					for(var i=0; i<resp.length; i++){
						var tr = $("<tr>");
						var check = $("<input>").addClass("check-item").attr("name", "noticeNo").val(resp[i].noticeNo).attr("type", "checkbox");
						var tdCheck = $("<td>").append(check);
						var tdNo = $("<td>").text(resp[i].noticeNo);
						var tdTitle = $("<td>").append($("<a>").attr("href", "detail/"+resp[i].noticeNo).text(resp[i].noticeTitle));
						var tdNick = $("<td>").text(resp[i].noticeNick);
						tr.append(tdCheck).append(tdNo).append(tdTitle).append(tdNick);
						$(".notice-list").append(tr);
					}
				}
			});
		});
	});
</script>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include><!DOCTYPE html>
