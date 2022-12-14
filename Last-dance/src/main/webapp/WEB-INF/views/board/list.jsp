<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="자유 게시판" name="title" />
</jsp:include>


<style>
.badge {
	width: 10%;
}

.search {
	position: relative;
}

h3 {
	font-size: 7px;
}

input {
	width: 50%;
	border: 2px solid #bbb;
	border-radius: 8px;
	padding: 10px 12px;
	font-size: 14px;
}

.input.input-seach {
	padding-right: 2.5em;
	background-image: url("/images/search.png");
	background-size: 1em;
	background-repeat: no-repeat;
	background-position-x: 27.75em;
	background-position-y: center;
}

.board-search-btn {
	display: none;
}
</style>

<div class="container-900 mt-5 float-center">

	<h1 class="mt-30" align="center">나만의 레시피를 공유 해보세요!!</h1>
	<h3 class="mt-20" align="center">레시피를 작성/댓글 작성으로 참여도를 올려서 귀여운 뱃지를
		착용해보세요 :)</h3>
	<div class="center search mt-10">
		<select class="input-type input">
			<option value="board_title">제목</option>
			<option value="member_nick">작성자</option>
			<option value="board_content">내용</option>
			<option value="">제목</option>
		</select> <input class="input input-keyword input-seach" type="text"
			placeholder="검색어를 입력하세요">
		<button class="board-search-btn" type="button"></button>
	</div>
</div>

<thead>
	<tr>
		<th colspan="12"><select class="sort-click float-left input">
				<option value="">정렬</option>
				<option value="board_no desc">최근 작성일 순</option>
				<option value="board_click desc">조회수 높은 순</option>
				<option value="board_like desc">추천 많은 순</option>
				<option value="reply_cnt desc">댓글 많은 순</option>
				
		</select> <a class="btn btn-positive float-right mt-10" href="write">글쓰기</a></th>
</thead>

<table class="table table-hover">
	<tr class="table">
		<th>제목</th>
		<th width="30%">내용</th>
		<th width="15%">작성자</th>
		<th>작성일</th>
		<th>마지막 수정일</th>
		<th>추천</th>
		<th>조회수</th>
		<th>댓글</th>
		
	</tr>

	<tbody class="board-list center mt-50">
		<c:forEach var="boardDto" items="${boardList}">
			<tr>
				<%-- <td>${boardDto.boardNo}</td> --%>
				<td><a href="detail?boardNo=${boardDto.boardNo}">
						${boardDto.boardTitle} </a></td>
						
										
						
				<td class="board-content" align="left">${boardDto.boardContent}</td>			
			
			
			
				<td>
					${boardDto.memberNick} 
					<c:if test="${boardDto.memberBadge == 1 }">
						<img class="badge" src="/images/badge-1.png">
					</c:if>
				</td>
				<td>${boardDto.boardWriteTime}</td>
				<td>${boardDto.boardEditTime}</td>
				<td>${boardDto.boardLike}</td>
				<td>${boardDto.boardClick}</td>
				<td>${boardDto.replyCnt }</td>
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

</div>

<script type="text/javascript">
	$(function() {
		$(".board-content").find("img").remove();
		var contentCnt = $(".board-content");
		for(var i=0; i<contentCnt.length; i++){
			$(".board-content").eq(i).text($(".board-content").eq(i).text());
		}
		/* 레시피 검색창에서 엔터치면 검색 */
		$(".input-keyword").keydown(function(e) {
			if (e.keyCode == 13) {
				$(".board-search-btn").click();
			}
		});

		/* 레시피 리스트 검색 */
		$(".board-search-btn")
				.click(
						function() {
							var sort = $(".sort-click").val();
							var type = $(".input-type").val();
							var keyword = $(".input-keyword").val();
							if (type == "" || keyword == "") {
								alert("검색어는 필수 입력입니다.");
								return;
							}
							$
									.ajax({
										url : "http://localhost:8888/rest/board",
										method : "post",
										contentType : "application/json",
										data : JSON.stringify({
											type : type,
											keyword : keyword,
											sort : sort
										}),
										success : function(resp) {
											$(".board-list").find("tr")
													.remove();
											for (var i = 0; i < resp.length; i++) {
												var tr = $("<tr>");
												/* var tdNo = $("<td>").text(
														resp[i].boardNo); */
												var tdTitle = $("<td>")
														.append(
																$("<a>")
																		.attr(
																				"href",
																				"detail?boardNo="
																						+ resp[i].boardNo)
																		.text(resp[i].boardTitle));
														
												var tdContent = $("<td>").addClass("board-content")
																		.attr("align", "left")
																		.attr("width", "30%")
																		.html(resp[i].boardContent);
												
												var url = "";
												if (resp[i].memberBadge == 1) {
													url = "/images/badge-1.png";
												}

												var badge = $("<img>").attr(
														"src", url).addClass(
														"badge");
												var tdNick = $("<td>").attr(
														"width", "15%").text(
														resp[i].memberNick)
														.append(badge);
												var tdWriteTime = $("<td>")
														.text(
																resp[i].boardWriteTime);
												var tdEditTime = $("<td>")
														.text(
																resp[i].boardEditTime);
												var tdLike = $("<td>").text(
														resp[i].boardLike);
												var tdClick = $("<td>").text(
														resp[i].boardClick);
												var tdReply = $("<td>").text(
														resp[i].replyCnt);
												tr.append(tdTitle).append(
														tdContent).append(
														tdNick).append(
														tdWriteTime).append(
														tdEditTime).append(
														tdLike).append(tdClick)
														.append(tdReply);
												$(".board-list").append(tr);
												$(".board-content").find("img").remove();
												var contentCnt = $(".board-content");
												for(var i=0; i<contentCnt.length; i++){
													$(".board-content").eq(i).text($(".board-content").eq(i).text());
												}
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
								/* var tdNo = $("<td>").text(
										resp[i].boardNo); */
								var tdTitle = $("<td>").append(
										$("<a>").attr("href","detail?boardNo="+ resp[i].boardNo)
												.text(resp[i].boardTitle));
								var tdContent = $("<td>")
										.addClass("board-content")
										.attr("align", "left")
										.attr("width", "30%")
										.html(resp[i].boardContent);

								var url = "";
								if (resp[i].memberBadge == 1) {
									url = "/images/badge-1.png";
								}

								var badge = $("<img>").attr("src", url)
										.addClass("badge");
								var tdNick = $("<td>").text(resp[i].memberNick)
										.attr("width", "15%").append(badge);

								var tdWriteTime = $("<td>").text(
										resp[i].boardWriteTime);
								var tdEditTime = $("<td>").text(
										resp[i].boardEditTime);
								var tdLike = $("<td>").text(resp[i].boardLike);
								var tdClick = $("<td>")
										.text(resp[i].boardClick);
								var tdReply = $("<td>").text(
										resp[i].replyCnt);
								tr.append(tdTitle).append(tdContent).append(
										tdNick)

								.append(tdWriteTime).append(tdEditTime).append(
										tdLike).append(tdClick)
										.append(tdReply);
								$(".board-list").append(tr);
								$(".board-content").find("img").remove();
								var contentCnt = $(".board-content");
								for(var i=0; i<contentCnt.length; i++){
									$(".board-content").eq(i).text($(".board-content").eq(i).text());
								}
							}
						}
					});
				});
	});
</script>
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>





