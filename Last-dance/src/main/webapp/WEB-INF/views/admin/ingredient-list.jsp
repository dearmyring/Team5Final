<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
<div class="mt-5">&nbsp;</div>
<h3>재료 리스트</h3>
<select class="sort-click">
	<option value="asc">오름차순</option>
	<option value="desc">내림차순</option>
</select>
<form class="ingredientName-form">
<table class="table table-hover">
	<thead>
		<tr>
			<th><input class="check-all" type="checkbox"></th>
			<th>카테고리</th>
			<th>재료명</th>
		</tr>
	</thead>
	<tbody class="ingredient-list">
		<c:forEach var="ingredientDto" items="${ingredientList}">
			<tr>
				<td><input class="check-item" name="ingredientName" value="${ingredientDto.ingredientName}" type="checkbox"></td>
				<td>${ingredientDto.ingredientCategory}</td>
				<td>${ingredientDto.ingredientName}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>
</form>

<button type="button" class="ingredient-async-delete">삭제하기</button>
<button type="button" class="ingredinet-async-insert">추가하기</button>
<br>

<select class="input-type">
	<option value="ingredient_name">재료명</option>
	<option value="ingredient_category">카테고리</option>
</select>
<input type="text" class="input-keyword">
<button type="button" class="ingredient-search-btn">검색</button>

<script type="text/javascript">
	$(function(){
		/* 체크박스 선택 삭제 시 비동기 처리 */
		$(".ingredient-async-delete").click(function(){
			
			var param = $(".ingredientName-form input:checked").serialize();
			
			$.ajax({
				url: "http://localhost:8888/rest/ingredient?"+param,
				method: "delete",
				contentType: "application/json",
				success: function(resp){
					$(".ingredient-list").find("tr").remove();
					for(var i=0; i<resp.length; i++){
						var tr = $("<tr>");
						var check = $("<input>").addClass("check-item").attr("name", "ingredientName").val(resp[i].ingredientName).attr("type", "checkbox");
						var tdCheck = $("<td>").append(check);
						var tdCate = $("<td>").text(resp[i].ingredientCategory);
						var tdName = $("<td>").text(resp[i].ingredientName);
						tr.append(tdCheck).append(tdCate).append(tdName);
						$(".ingredient-list").append(tr);
					}
				}
			});
		});
		
    	/* 레시피 검색창에서 엔터치면 검색 */
    	$(".input-keyword").keydown(function(e){
    		if(e.keyCode == 13) {
    			$("ingredient-search-btn").click();
    		}
   		});
   	
		/* 레시피 리스트 검색 */
		$(".ingredient-search-btn").click(function(){
			var sort = $(".sort-click").val();
			var type = $(".input-type").val();
			var keyword = $(".input-keyword").val();
			if(type == "" || keyword == "") {
				alert("검색어는 필수 입력입니다.");
				return;
			}
			var param = new String();
			param.sort = sort;
			param.type = type;
			param.keyword = keyword;
			var search = $.param(param)
			$.ajax({
				url: "http://localhost:8888/rest/ingredient?"+search,
				method: "get",
				contentType: "application/json",
				success: function(resp){
					$(".ingredient-list").find("tr").remove();
					for(var i=0; i<resp.length; i++){
						var tr = $("<tr>");
						var check = $("<input>").addClass("check-item").attr("name", "ingredientName").val(resp[i].ingredientName).attr("type", "checkbox");
						var tdCheck = $("<td>").append(check);
						var tdName = $("<td>").text(resp[i].ingredientName);
						var tdCate = $("<td>").text(resp[i].ingredientCategory);
						tr.append(tdCheck).append(tdCate).append(tdName);
						$(".ingredient-list").append(tr);
					}
				}
			});
			
		});
    	
    	/* 레시피 리스트 정렬 */
		$(".sort-click").on("input", function(){
			var sort = $(this).val();
			var type = $(".input-type").val();
			var keyword = $(".input-keyword").val();
			var param = new String();
			param.sort = sort;
			param.type = type;
			param.keyword = keyword;
			var search = $.param(param)
			$.ajax({
				url: "http://localhost:8888/rest/ingredient?"+search,
				method: "get",
				contentType: "application/json",
				success: function(resp){
					$(".ingredient-list").find("tr").remove();
					for(var i=0; i<resp.length; i++){
						var tr = $("<tr>");
						var check = $("<input>").addClass("check-item").attr("name", "ingredientName").val(resp[i].ingredientName).attr("type", "checkbox");
						var tdCheck = $("<td>").append(check);
						var tdName = $("<td>").text(resp[i].ingredientName);
						var tdCate = $("<td>").text(resp[i].ingredientCategory);
						tr.append(tdCheck).append(tdCate).append(tdName);
						$(".ingredient-list").append(tr);
					}
				}
			});
		});
    	
    	/* 추가하기 버튼 클릭 시 모달 추가창 구현 예정 */
    	$(".ingredinet-async-insert").click(function(){
    		
    	});
	});
</script>
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>
