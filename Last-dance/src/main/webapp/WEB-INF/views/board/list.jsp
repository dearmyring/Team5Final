<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="자유 게시판" name="title" />
</jsp:include>
<div class="mt-5">
	<h3>유저게시판 리스트</h3>
	<table>
		<thead>
			<tr>
				<th colspan="3"><select class="sort-click">
						<option value="board_no desc">최근 작성일 순</option>
						<option value="board_click desc">조회수 높은 순</option>
						<option value="board_like desc">좋아요 많은 순</option>
				</select></th>
			</tr>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>내용</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>마지막 수정일</th>
				<th>추천</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody class="board-list">
			<c:forEach var="boardDto" items="${boardList}">
				<tr>
					<td>${boardDto.boardNo}</td>
					<td><a href="detail?boardNo=${boardDto.boardNo}">
							${boardDto.boardTitle} </a></td>
					<td>${boardDto.boardContent}</td>
					<td>${boardDto.memberNick}</td>
					<td>${boardDto.boardWriteTime}</td>
					<td>${boardDto.boardEditTime}</td>
					<td>${boardDto.boardLike}</td>
					<td>${boardDto.boardClick}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<br>
	<ul class="pagination">
		<li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
		<c:forEach var="no" begin="1" end="${boardListSearchVo.pageCnt}">
			<li class="page-item"><a class="page-link" href="#">${no}</a></li>
		</c:forEach>
		<li class="page-item"><a class="page-link" href="#">&gt;</a></li>
	</ul>
	<br>
	 <select class="input-type">
		<option value="board_title">제목</option>
		<option value="member_nick">작성자</option>
		<option value="board_content">내용</option>
		<option value="">제목</option> -->
	</select> 
	<input class="input-keyword" type="text">
	<button class="board-search-btn" type="button">검색</button>
</div>

<script type="text/javascript">
	$(function() {
		/* 레시피 검색창에서 엔터치면 검색 */
		$(".input-keyword").keydown(function(e) {
			if (e.keyCode == 13) {
				$(".board-search-btn").click();
			}
		});

		/* 레시피 리스트 검색 */
		$(".board-search-btn").click(
				function() {
					var sort = $(".sort-click").val();
					var type = $(".input-type").val();
					var keyword = $(".input-keyword").val();
					if (type == "" || keyword == "") {
						alert("검색어는 필수 입력입니다.");
						return;
					}
					$.ajax({
						url : "http://localhost:8888/rest/board",
						method : "post",
						contentType : "application/json",
						data : JSON.stringify({
							type : type,
							keyword : keyword,
							sort : sort
						}),
						success : function(resp) {
							$(".board-list").find("tr").remove();
							for (var i = 0; i < resp.length; i++) {
								var tr = $("<tr>");
								var tdNo = $("<td>").text(resp[i].boardNo);
								var tdTitle = $("<td>").append(
										$("<a>").attr(
												"href",
												"detail?boardNo="
														+ resp[i].boardNo)
												.text(resp[i].boardTitle));
								var tdContent = $("<td>").text(
										resp[i].boardContent);
								var tdNick = $("<td>").text(resp[i].memberNick);
								var tdWriteTime = $("<td>").text(
										resp[i].boardWriteTime);
								var tdEditTime = $("<td>").text(
										resp[i].boardEditTime);
								var tdLike = $("<td>").text(resp[i].boardLike);
								var tdClick = $("<td>")
										.text(resp[i].boardClick);
								tr.append(tdNo).append(tdTitle).append(
										tdContent).append(tdNick).append(
										tdWriteTime).append(tdEditTime).append(
										tdLike).append(tdClick);
								$(".board-list").append(tr);
							}
						}
					});

				});

		/* 레시피 리스트 정렬 */
		$(".sort-click").on(
				"input",
				function() {
					var sort = $(this).val();
					var type = $(".input-type").val();
					var keyword = $(".input-keyword").val();
					$.ajax({
						url : "http://localhost:8888/rest/board",
						method : "post",
						contentType : "application/json",
						data : JSON.stringify({
							type : type,
							keyword : keyword,
							sort : sort
						}),
						success : function(resp) {
							console.log(resp);
							$(".board-list").find("tr").remove();
							for (var i = 0; i < resp.length; i++) {
								var tr = $("<tr>");
								var tdNo = $("<td>").text(resp[i].boardNo);
								var tdTitle = $("<td>").append(
										$("<a>").attr(
												"href",
												"detail?boardNo="
														+ resp[i].boardNo)
												.text(resp[i].boardTitle));
								var tdContent = $("<td>").text(
										resp[i].boardContent);
								var tdNick = $("<td>").text(resp[i].memberNick);
								var tdWriteTime = $("<td>").text(
										resp[i].boardWriteTime);
								var tdEditTime = $("<td>").text(
										resp[i].boardEditTime);
								var tdLike = $("<td>").text(resp[i].boardLike);
								var tdClick = $("<td>")
										.text(resp[i].boardClick);
								tr.append(tdNo).append(tdTitle).append(
										tdContent).append(tdNick).append(
										tdWriteTime).append(tdEditTime).append(
										tdLike).append(tdClick);
								$(".board-list").append(tr);
							}
						}
					});
				});
	});
</script>
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>





