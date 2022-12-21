<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="mt-3">&nbsp;</div>
<div class="mt-3">&nbsp;</div>

<div class="text-end">
	<a class="main-page-link"></a> > 공지사항
</div>

<div class="container-fluid mt-5">
<form class="noticeNo-form">

<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<table class="table table-sm table-link">
			<thead>
				<tr class="text-center">
					<th><i class="fa-regular fa-square icon-check-all"></i></th>
					<th>공지번호</th>
					<th>제목</th>
					<th>작성자</th>
				</tr>
			</thead>
			<tbody class="notice-list">
				<c:forEach var="noticeDto" items="${noticeList}">
					<tr class="text-center">
						<td>
							<i class="fa-regular fa-square icon-check-item"></i>
							<input class="check-item" name="noticeNo" value="${noticeDto.noticeNo}" type="hidden">
						</td>
						<td>${noticeDto.noticeNo}</td>
						<td class="text-start">
							<a class="text-decoration-none link-dark" href="detail/${noticeDto.noticeNo}">${noticeDto.noticeTitle}</a>
						</td>
						<td>${noticeDto.noticeNick}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
</form>

<div class="row mt-3">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-6 text-end">
				<button class="btn btn-md btn-light notice-async-delete" type="button">삭제하기</button>
			</div>
			<div class="col-6">
				<a class="btn btn-md yellow-btn" href="write">작성하기</a>
			</div>
		</div>
	</div>
</div>

</div>

<script type="text/javascript">
	$(function(){
		/* 체크박스 선택 삭제 시 비동기 처리 */
		$(".notice-async-delete").click(function(){
			console.log(this);
			var checkboxes = $(".icon-check-item");
			for(var i=0; i<checkboxes.length; i++){
				if(checkboxes.eq(i).hasClass("fa-square")){
					checkboxes.eq(i).next().remove();
				}
			}
			var param = $(".noticeNo-form .check-item").serialize();
			
			if(!param){
				alert("삭제할 공지글을 선택하세요.");
				return;
			}
			else{
				if(confirm("정말 삭제하시겠습니까?")){
					$.ajax({
						url: "http://localhost:8888/rest/notice?"+param,
						method: "delete",
						contentType: "application/json",
						success: function(resp){
							$(".notice-list").empty();
							for(var i=0; i<resp.length; i++){
								var tr = $("<tr>").addClass("text-center");
								var check = $("<input>").addClass("check-item").attr("name", "boardNo")
									.val(resp[i].recipeNo).attr("type", "hidden");
								var checkIcon = $("<i>").addClass("fa-regular fa-square icon-check-item");
								var tdCheck = $("<td>").append(checkIcon).append(check);
								var tdNo = $("<td>").text(resp[i].noticeNo);
								var link = $("<a>").attr("href", "detail/"+resp[i].noticeNo)
									.addClass("text-decoration-none link-dark").text(resp[i].noticeTitle);
								var tdTitle = $("<td>").addClass("text-start").append(link);
								var tdNick = $("<td>").text(resp[i].noticeNick);
								tr.append(tdCheck).append(tdNo).append(tdTitle).append(tdNick);
								$(".notice-list").append(tr);
							}
							$(".icon-check-all").removeClass("fa-regular fa-square-check")
							.addClass("fa-regular fa-square");
						}
					});
				}
			}
		});
	});
</script>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include><!DOCTYPE html>
