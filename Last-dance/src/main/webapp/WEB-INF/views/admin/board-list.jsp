<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
<div class="mt-3">&nbsp;</div>
<div class="mt-3">&nbsp;</div>

<div class="history-link text-end">
	<a class="main-page-link"></a> <i class="fa-solid fa-chevron-right"></i> 유저 게시판(관리자)
</div>

<div class="container-fluid mt-5">
<form class="boardNo-form">
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
								<a class="text-decoration-none link-dark"  href="detail/${boardDto.boardNo}">${boardDto.boardTitle}</a>
							</td>
							<td>${boardDto.boardId}</td>
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
	
	<div class="row mt-3">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="text-end">
				<button class="btn btn-md btn-light board-async-blind" type="button">블라인드 하기</button>
			</div>
		</div>
	</div>
</div>
</form>

<!-- <div class="row mt-3"> -->
<!-- 	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1 "> -->
<!-- 	<ul class="pagination border-none-pagination" style="justify-content: center;"> -->
<!--         <li class="page-item disabled"> -->
<!--         	<a class="page-link"><i class="fa-solid fa-chevron-left"></i></a> -->
<!--        	</li> -->
       	
<!--         <li class="page-item active"><a class="page-link" data-no="1">1</a></li> -->
<%--         <c:forEach var="no" begin="2" end="${voPagination.endBlock()}"> --%>
<%-- 	        <li class="page-item"><a class="page-link" data-no="${no}">${no}</a></li> --%>
<%--         </c:forEach> --%>
        
<!--         <li class="page-item disabled"> -->
<%--         	<a class="page-link" data-no="${voPagination.nextBlock()}"> --%>
<!--         		<i class="fa-solid fa-chevron-right"></i> -->
<!--        		</a> -->
<!--        	</li> -->
<!--     </ul> -->
<!--     </div> -->
<!-- </div> -->

<div class="row mt-5">
	<div class="col-lg-4 offset-lg-4 col-md-8 offset-md-2 col-sm-10 offset-sm-1 text-center">
		<div class="row">
			<div class="col-3">
				<select class="input-type form-select w-100 pe-3" id="exampleSelect1">
					<option value="board_title">제목</option>
					<option value="member_nick">작성자</option>
				</select>
			</div>
			<div class="col-9">
				<div class="input-group rounded">
					<input aria-describedby="button-addon2" name="keyword" autocomplete="off" 
					class="input-keyword form-control" type="text" value="${keyword}">
					<button class="btn-search" type="submit" id="button-addon2">
						<img width="25px" src="${pageContext.request.contextPath}/images/search-admin.png">
					</button>
				</div>
			</div>
		</div>
	</div>
</div>
</div>


 
<script type="text/javascript">
$(function(){
	var pageCnt = $(".page-item");
	if(pageCnt.lenght == 7){
    	pageCnt.last().removeClass("disabled");
	}
	
	/* 페이지 번호 누르면 비동기 리스트 */
	$(document).on("click",".page-link", (function(e){
		var sort = $(".sort-click").val();
		var type = $(".input-type").val();
		var keyword = $(".input-keyword").val();
		var pageNo = Number($(this).attr("data-no"));
		var data = {
				type: type,
				keyword: keyword,
				sort: sort,
				p: pageNo,
				table: "board"
		};
		async(data);
	}));
	
	function async(data){
		$.ajax({
			url: "http://localhost:8888/rest/board2",
			method: "post",
			contentType: "application/json",
			data: JSON.stringify(data),
			success: function(resp){
				list(resp);
				page(data);
			}
		});
	}
	
	function list(resp){
		$(".board-list").empty();
		for(var i=0; i<resp.length; i++){
			var tr = $("<tr>").addClass("text-center");
			var check = $("<input>").addClass("check-item").attr("name", "boardNo")
				.val(resp[i].boardNo).attr("type", "hidden");
			var checkIcon = $("<i>").addClass("fa-regular fa-square icon-check-item");
			var tdCheck = $("<td>").append(checkIcon).append(check);
			var tdNo = $("<td>").text(resp[i].boardNo);
			var link = $("<a>").addClass("stretched-link text-decoration-none link-dark")
				.attr("href", "detail/"+resp[i].boardNo).text(resp[i].boardTitle);
			var tdTitle = $("<td>").addClass("position-relative text-start").append(link);
// 			var tdTime = $("<td>").text(resp[i].recipeTime+'분');
			var tdNick = $("<td>").text(resp[i].memberNick);
			tr.append(tdCheck).append(tdNo).append(tdTitle).append(tdNick);
			$(".board-list").append(tr);
		}
		$(".icon-check-all").removeClass("fa-regular fa-square-check")
		.addClass("fa-regular fa-square");
	}
	
	function page(data){
		$.ajax({
			url: "http://localhost:8888/rest/admin-count2",
			method: "post",
			contentType: "application/json",
			data: JSON.stringify(data),
			success: function(resp){
				$(".page-item").removeClass("disabled").removeClass("active");
	    		$(".pagination").empty();
	    		
	    		var prev = $("<i>").addClass("fa-solid fa-chevron-left");
	    		var linkPrev = $("<a>").addClass("page-link").attr("data-no", resp.firstBlock-1);
	    		var liPrev = $("<li>").addClass("page-item");
				if(!resp.havePrev){
					liPrev.addClass("disabled");
				}
				linkPrev.append(prev);
				liPrev.append(linkPrev);
				$(".pagination").append(liPrev);

				for(var i=resp.firstBlock; i<=resp.lastBlock; i++){
		    		var link = $("<a>").addClass("page-link").text(i).attr("data-no", i);
		    		var li = $("<li>").addClass("page-item").append(link);
					if(resp.p==i){
						li.addClass("active");
					}
					$(".pagination").append(li);
				}
				
				var next = $("<i>").addClass("fa-solid fa-chevron-right");
	    		var linkNext = $("<a>").addClass("page-link").attr("data-no", resp.lastBlock+1);
	    		var liNext = $("<li>").addClass("page-item");
				if(!resp.haveNext){
					liNext.addClass("disabled");
				}
				linkNext.append(next);
				liNext.append(linkNext);
				$(".pagination").append(liNext);
			}
		});
	}
	
	/* 검색창에서 엔터치면 검색 */
	$(".input-keyword").keydown(function(e){
		if(e.keyCode == 13) {
			$(".board-search-btn").click();
		}
		});
	
	/* 유저게시판 리스트 검색 */
	$(".board-search-btn").click(function(){
		var sort = $(".sort-click").val();
		var type = $(".input-type").val();
		var keyword = $(".input-keyword").val();
		if(type == "" || keyword == "") {
			alert("검색어는 필수 입력입니다.");
			return;
		}
		var data = {
				type: type,
				keyword: keyword,
				sort: sort,
				p: 1,
				table: "board"
		};
		async(data);
	});
	
	/* 유저게시판 리스트 정렬 */
	$(".sort-click").on("input", function(){
		var sort = $(this).val();
		var type = $(".input-type").val();
		var keyword = $(".input-keyword").val();
		var data = {
				type: type,
				keyword: keyword,
				sort: sort,
				p: 1,
				table: "board"
		};
		async(data);
	})
	
	/* 체크박스 선택시 비동기 처리  수정중(지원)*/
	$(".board-async-blind").click(function(){
		var checkboxes = $(".icon-check-item");
		for(var i=0; i<checkboxes.length; i++){
			if(checkboxes.eq(i).hasClass("fa-square")){
				checkboxes.eq(i).next().remove();
			}
		}
		var param = $(".boardNo-form .check-item").serialize();
		
		if(!param){
			alert("블라인드할 게시글을 선택하세요.");
			return;
		}
		else{
			if(confirm("정말 블라인드처리 하시겠습니까?")){
				$.ajax({
					url: "http://localhost:8888/rest/board2?"+param,
					method: "blind",
					contentType: "application/json",
					success: function(resp){
						var sort = $(".sort-click").val();
						var type = $(".input-type").val();
						var keyword = $(".input-keyword").val();
						var data = {
								type: type,
								keyword: keyword,
								sort: sort,
								p: 1,
								table: "board"
						};
						async(data);
					}
				});
			}
		}
	});
});
	
	
	
// 	$(function(){
// 		/* 정렬 비동기 다녀오기 */
// 		$(".sort-click").on("input", function(){
// 			var sort = $(this).val();
// 			$.ajax({
// 				url: "http://localhost:8888/rest/board",
// 				method: "post",
// 				contentType: "application/json",
// 				data: JSON.stringify({
// 					sort: sort
// 				}),
// 				success: function(resp){
// 					$(".board-list").empty();
// 					for(var i=0; i<resp.length; i++){
// 						var tr = $("<tr>").addClass("text-center");
// 						var check = $("<input>").addClass("check-item").attr("name", "boardNo")
// 							.val(resp[i].recipeNo).attr("type", "hidden");
// 						var checkIcon = $("<i>").addClass("fa-regular fa-square icon-check-item");
// 						var tdCheck = $("<td>").append(checkIcon).append(check);
// 						var link = $("<a>").attr("href", "detail/"+resp[i].boardNo)
// 							.text(resp[i].boardTitle).addClass("stretched-link text-decoration-none link-dark");
// 						var tdTitle = $("<td>").addClass("position-relative text-start").append(link);
// 						var tdNick = $("<td>").text(resp[i].memberNick);
// 						var tdClick = $("<td>").text(resp[i].boardClick);
// 						var tdTime = $("<td>").text(resp[i].boardWriteTime);
// 						var icon = $("<i>").addClass("fa-solid fa-square");
// 						var tdBlind = $("<td>")
// 						if(resp[i].boardBlind == "Y"){
// 							tdBlind.append(icon);
// 						}
// 						tr.append(tdCheck).append(tdTitle).append(tdNick).append(tdClick).append(tdTime).append(tdBlind);
// 						$(".board-list").append(tr);
// 					}
// 					$(".icon-check-all").removeClass("fa-regular fa-square-check")
// 					.addClass("fa-regular fa-square");
// 				}
// 			});
// 		});
// 	});
</script> 
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>