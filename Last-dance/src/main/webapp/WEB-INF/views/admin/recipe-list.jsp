<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
<div class="mt-5">
<h3>레시피리스트</h3>
	<table>
	    <thead>
			<tr>
				<th colspan="3">
					<select class="sort-click">
						<option value="recipe_no desc">최근 작성일 순</option>
						<option value="recipe_click desc">조회수 높은 순</option>
						<option value="recipe_like desc">좋아요 많은 순</option>
						<option value="recipe_time asc">조리시간 짧은 순</option>
						<option value="recipe_time desc">조리시간 긴 순</option>
					</select>
				</th>
	        <tr>
	            <th>번호</th>
	            <th>제목</th>
	            <th>조리시간</th>
	            <th>작성자</th>
	        </tr>
	    </thead>
	    <tbody class="recipe-list">
	    	<c:forEach var="recipeDto" items="${recipeList}">
	         <tr>
				<td>${recipeDto.recipeNo}</td>
				<td>
					<a href="detail/${recipeDto.recipeNo}">
						${recipeDto.recipeTitle}
					</a>
				</td>
				<td>${recipeDto.recipeTime}분</td>
				<td>${recipeDto.recipeNick}</td>
	         </tr>
	    	</c:forEach>
	    </tbody>
	</table>
	<br>
	<ul class="pagination">
        <li class="page-item disabled"><a class="page-link" href="#">&lt;</a></li>
        <c:forEach var="no" begin="1" end="${voPagination.pageCnt}">
	        <li class="page-item"><a class="page-link" href="#">${no}</a></li>
        </c:forEach>
        <li class="page-item"><a class="page-link" href="#">&gt;</a></li>
    </ul>
    <br>
	<select class="input-type">
		<option value="recipe_title">제목</option>
		<option value="recipe_nick">작성자</option>
<!-- 		<option value="">재료</option> -->
	</select>
	<input class="input-keyword" type="text">
	<button class="recipe-search-btn" type="button">검색</button>
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
						var tr = $("<tr>");
						var tdNo = $("<td>").text(resp[i].recipeNo);
						var tdTitle = $("<td>").append($("<a>").attr("href", "detail/"+resp[i].recipeNo).text(resp[i].recipeTitle));
						var tdTime = $("<td>").text(resp[i].recipeTime+'분');
						var tdNick = $("<td>").text(resp[i].recipeNick);
						tr.append(tdNo).append(tdTitle).append(tdTime).append(tdNick);
						$(".recipe-list").append(tr);
					}
				}
			});
			
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
						var tr = $("<tr>");
						var tdNo = $("<td>").text(resp[i].recipeNo);
						var tdTitle = $("<td>").append($("<a>").attr("href", "detail/"+resp[i].recipeNo).text(resp[i].recipeTitle));
						var tdTime = $("<td>").text(resp[i].recipeTime+'분');
						var tdNick = $("<td>").text(resp[i].recipeNick);
						tr.append(tdNo).append(tdTitle).append(tdTime).append(tdNick);
						$(".recipe-list").append(tr);
					}
				}
			});
		});    	
    });
</script>
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>