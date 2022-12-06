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
					<select name="sort">
						<option value="writetime desc">최근작성일순</option>
						<option value="writetime asc">오래된작성일순</option>
					</select>
				</th>
	        <tr>
	            <th>번호</th>
	            <th>제목</th>
	            <th>작성자</th>
	        </tr>
	    </thead>
	    <tbody>
	    	<c:forEach var="recipeDto" items="${recipeList}">
	         <tr>
				<td>
					<a href="detail/${recipeDto.recipeNo}">
						${recipeDto.recipeNo}
					</a>
				</td>
				<td>${recipeDto.recipeTitle}</td>
				<td>${recipeDto.recipeNick}</td>
	         </tr>
	    	</c:forEach>
	    </tbody>
	</table>
	<br>
	<input type="text">
	<button class="button">검색</button>
</div>

<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
    $(function(){
		$("[name=sort]").on("input", function(){
			var sort = $(this).val();
			$.ajax({
				url: "http://localhost:8888/rest/recipe",
				method: "post",
				data: sort,
				success: function(resp){
// 					목록 출력
				}
			});
		});    	
    });
</script>
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>