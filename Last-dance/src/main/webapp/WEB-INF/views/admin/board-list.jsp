<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
<div class="mt-5">&nbsp;</div>

<div class="text-end">
	<a class="main-page-link"></a> > 유저 게시판
</div>

<div class="container-fluid mt-5">
<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
	<select name="sort" class="sort-click">
		<option value="board_no desc">최근 등록 순</option>
		<option value="board_click desc">조회수 높은 순</option>
	</select>
	</div>
</div>
	<div class="row mt-3">
		<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
			<table class="table table-sm table-link">
				<thead>
					<tr class="text-center">
						<th><i class="fa-regular fa-square icon-check-all"></i></th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>작성일</th>
<!-- 						<th>댓글수</th> -->
						<th>블라인드</th>
					<tr>
				</thead>
				<tbody class="board-list">
					<c:forEach var="boardDto" items="${boardList}">
						<tr class="text-center">
							<td>
								<i class="fa-regular fa-square icon-check-item"></i>
								<input type="hidden" class="check-item" name="boardNo" value="${boardDto.boardNo}">
							</td>
							<td class="text-start">
								<a class="text-decoration-none link-dark" href="detail/${boardDto.boardNo}">${boardDto.boardTitle}</a>
							</td>
							<td>${boardDto.memberNick}</td>
							<td>${boardDto.boardClick}</td>
							<td>${boardDto.boardWriteTime}</td>
<%-- 							<td>${boardDto.}</td> --%>
							<td>
								<c:if test="${boardDto.boardBlind == 'Y'}">
									<i class="fa-solid fa-y"></i>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>        	
	</div>

</div>
 
<script type="text/javascript">
	$(function(){
		/* 정렬 비동기 다녀오기 */
		$(".sort-click").on("input", function(){
			var sort = $(this).val();
			$.ajax({
				url: "http://localhost:8888/rest/board",
				method: "post",
				contentType: "application/json",
				data: JSON.stringify({
					sort: sort
				}),
				success: function(resp){
					$(".board-list").empty();
					for(var i=0; i<resp.length; i++){
						var tr = $("<tr>").addClass("text-center");
						var check = $("<input>").addClass("check-item").attr("name", "boardNo")
							.val(resp[i].recipeNo).attr("type", "hidden");
						var checkIcon = $("<i>").addClass("fa-regular fa-square icon-check-item");
						var tdCheck = $("<td>").append(checkIcon).append(check);
						var link = $("<a>").attr("href", "detail/"+resp[i].boardNo)
							.text(resp[i].boardTitle).addClass("stretched-link text-decoration-none link-dark");
						var tdTitle = $("<td>").addClass("position-relative text-start").append(link);
						var tdNick = $("<td>").text(resp[i].memberNick);
						var tdClick = $("<td>").text(resp[i].boardClick);
						var tdTime = $("<td>").text(resp[i].boardWriteTime);
						var icon = $("<i>").addClass("fa-solid fa-square");
						var tdBlind = $("<td>")
						if(resp[i].boardBlind == "Y"){
							tdBlind.append(icon);
						}
						tr.append(tdCheck).append(tdTitle).append(tdNick).append(tdClick).append(tdTime).append(tdBlind);
						$(".board-list").append(tr);
					}
					$(".icon-check-all").removeClass("fa-regular fa-square-check")
					.addClass("fa-regular fa-square");
				}
			});
		});
	});
</script> 
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>