<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="mt-5">&nbsp;</div>

<div class="text-end">
	<a class="main-page-link"></a> > 레시피 리스트
</div>

<div class="container-fluid">
<form class="recipeNo-form">
<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-6">
				<select class="sort-click">
					<option value="recipe_no desc">최근 작성일 순</option>
					<option value="recipe_click desc">조회수 높은 순</option>
					<option value="recipe_like desc">좋아요 많은 순</option>
					<option value="recipe_time asc">조리시간 짧은 순</option>
					<option value="recipe_time desc">조리시간 긴 순</option>
				</select>
			</div>
			<div class="col-6 text-end">
				<a href="write" class="btn yellow-btn btn-md">등록하기</a>
			</div>
		</div>
	</div>
</div>
<div class="row mt-3">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
	<table class="table table-sm table-link">
	    <thead>
	    	<tr class="text-center">
	        	<th><i class="fa-regular fa-square icon-check-all"></i></th>
	            <th>번호</th>
	            <th>제목</th>
	            <th>조리시간</th>
	            <th>작성자</th>
	        </tr>
	    </thead>
	    <tbody class="recipe-list">
	    	<c:forEach var="recipeDto" items="${recipeList}">
	         <tr class="text-center">
	         	<td>
	         		<i class="fa-regular fa-square icon-check-item"></i>
	         		<input type="hidden" class="check-item" name="recipeNo" value="${recipeDto.recipeNo}">
         		</td>
				<td>${recipeDto.recipeNo}</td>
				<td class="text-start">
					<a class="text-decoration-none link-dark" href="detail/${recipeDto.recipeNo}">
						${recipeDto.recipeTitle}
					</a>
				</td>
				<td>${recipeDto.recipeTime}분</td>
				<td>${recipeDto.recipeNick}</td>
	         </tr>
	    	</c:forEach>
	    </tbody>
	</table>
	</div>
<div class="row mt-3">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1 text-end">
		<button type="button" class="recipe-async-delete btn btn-light btn-md">삭제하기</button>
	</div>
</div>
</div>
</form>
<div class="row mt-3">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1 ">
	<ul class="pagination" style="justify-content: center;">
        <li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
        <c:forEach var="no" begin="1" end="${voPagination.pageCnt}">
	        <li class="page-item"><a class="page-link" href="#">${no}</a></li>
        </c:forEach>
        <li class="page-item"><a class="page-link" href="#">&gt;</a></li>
    </ul>
    </div>
</div>
<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1 text-center">
	<select class="input-type">
		<option value="recipe_title">제목</option>
		<option value="recipe_nick">작성자</option>
<!-- 		<option value="">재료</option> -->
	</select>
	<input class="input-keyword" type="text">
	<button class="recipe-search-btn" type="button">검색</button>
	</div>
</div>
</div>

<script type="text/javascript">
    $(function(){
    	/* 레시피 검색창에서 엔터치면 검색 */
    	$(".input-keyword").keydown(function(e){
    		if(e.keyCode == 13) {
    			$(".recipe-search-btn").click();
    		}
   		});
   	
		/* 레시피 리스트 검색 */
		$(".recipe-search-btn").click(function(){
			var sort = $(".sort-click").val();
			var type = $(".input-type").val();
			var keyword = $(".input-keyword").val();
			if(type == "" || keyword == "") {
				alert("검색어는 필수 입력입니다.");
				return;
			}
			$.ajax({
				url: "http://localhost:8888/rest/recipe",
				method: "post",
				contentType: "application/json",
				data: JSON.stringify({
					type: type,
					keyword: keyword,
					sort: sort
				}),
				success: function(resp){
					$(".recipe-list").find("tr").remove();
					for(var i=0; i<resp.length; i++){
						var tr = $("<tr>").addClass("text-center");
						var check = $("<input>").addClass("check-item").attr("name", "recipeNo")
							.val(resp[i].recipeNo).attr("type", "hidden");
						var checkIcon = $("<i>").addClass("fa-regular fa-square icon-check-item");
						var tdCheck = $("<td>").append(checkIcon).append(check);
						var tdNo = $("<td>").text(resp[i].recipeNo);
						var link = $("<a>").addClass("text-decoration-none link-dark")
							.attr("href", "detail/"+resp[i].recipeNo).text(resp[i].recipeTitle);
						var tdTitle = $("<td>").addClass("text-start").append(link);
						var tdTime = $("<td>").text(resp[i].recipeTime+'분');
						var tdNick = $("<td>").text(resp[i].recipeNick);
						tr.append(tdCheck).append(tdNo).append(tdTitle).append(tdTime).append(tdNick);
						$(".recipe-list").append(tr);
					}
				}
			});
			
		});
		
		$(".icon-check-item").click(function(){
			console.log($(this));
		});
    	
    	/* 레시피 리스트 정렬 */
		$(".sort-click").on("input", function(){
			var sort = $(this).val();
			var type = $(".input-type").val();
			var keyword = $(".input-keyword").val();
			$.ajax({
				url: "http://localhost:8888/rest/recipe",
				method: "post",
				contentType: "application/json",
				data: JSON.stringify({
					type: type,
					keyword: keyword,
					sort: sort
				}),
				success: function(resp){
					$(".recipe-list").find("tr").remove();
					for(var i=0; i<resp.length; i++){
						var tr = $("<tr>").addClass("text-center");
						var check = $("<input>").addClass("check-item").attr("name", "recipeNo")
							.val(resp[i].recipeNo).attr("type", "hidden");
						var checkIcon = $("<i>").addClass("fa-regular fa-square icon-check-item");
						var tdCheck = $("<td>").append(checkIcon).append(check);
						var tdNo = $("<td>").text(resp[i].recipeNo);
						var link = $("<a>").addClass("text-decoration-none link-dark")
							.attr("href", "detail/"+resp[i].recipeNo).text(resp[i].recipeTitle);
						var tdTitle = $("<td>").addClass("text-start").append(link);
						var tdTime = $("<td>").text(resp[i].recipeTime+'분');
						var tdNick = $("<td>").text(resp[i].recipeNick);
						tr.append(tdCheck).append(tdNo).append(tdTitle).append(tdTime).append(tdNick);
						$(".recipe-list").append(tr);
					}
				}
			});
		});
    	
		/* 체크박스 선택 삭제 시 비동기 처리 */
		$(".recipe-async-delete").click(function(){
			var checkboxes = $(".icon-check-item");
			for(var i=0; i<checkboxes.length; i++){
				if(checkboxes.eq(i).hasClass("fa-square")){
					checkboxes.eq(i).next().remove();
				}
			}
			var param = $(".recipeNo-form .check-item").serialize();
			
			if(!param){
				alert("삭제할 레시피를 선택하세요.");
				return;
			}
			else{
				if(confirm("정말 삭제하시겠습니까?")){
					$.ajax({
						url: "http://localhost:8888/rest/recipe?"+param,
						method: "delete",
						contentType: "application/json",
						success: function(resp){
							var sort = $(".sort-click").val();
							var type = $(".input-type").val();
							var keyword = $(".input-keyword").val();
							$.ajax({
								url: "http://localhost:8888/rest/recipe",
								method: "post",
								contentType: "application/json",
								data: JSON.stringify({
									type: type,
									keyword: keyword,
									sort: sort
								}),
								success: function(resp){
									$(".recipe-list").find("tr").remove();
									for(var i=0; i<resp.length; i++){
										var tr = $("<tr>").addClass("text-center");
										var check = $("<input>").addClass("check-item").attr("name", "recipeNo")
											.val(resp[i].recipeNo).attr("type", "hidden");
										var checkIcon = $("<i>").addClass("fa-regular fa-square icon-check-item");
										var tdCheck = $("<td>").append(checkIcon).append(check);
										var tdNo = $("<td>").text(resp[i].recipeNo);
										var link = $("<a>").addClass("text-decoration-none link-dark")
											.attr("href", "detail/"+resp[i].recipeNo).text(resp[i].recipeTitle);
										var tdTitle = $("<td>").addClass("text-start").append(link);
										var tdTime = $("<td>").text(resp[i].recipeTime+'분');
										var tdNick = $("<td>").text(resp[i].recipeNick);
										tr.append(tdCheck).append(tdNo).append(tdTitle).append(tdTime).append(tdNick);
										$(".recipe-list").append(tr);
									}
								}
							});
						}
					});
				}
			}
		});
    });
</script>
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>