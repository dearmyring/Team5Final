<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<h3>레시피등록</h3>

<form action="write" method="post">

<select>
	<option value="">선택</option>
	<option disabled>--------</option>
	<c:forEach var="hashtagDto" items="${hashtagList}">
		<option>${hashtagDto.hashtagName}</option>
	</c:forEach>
</select>

<select class="select-cate">
	<option value="">선택</option>
	<option disabled>--------</option>
	<c:forEach var="cate" items="${cateList}">
		<option>${cate}</option>
	</c:forEach>
</select>

<select class="result-ingredient">
	<option value="">선택</option>
	<option disabled>--------</option>
</select>

</form>

<script src="http://code.jquery.com/jquery-3.6.1.js"></script>
<!-- 배포용 <script src="http://code.jquery.com/jquery-3.6.1.min.js"></script> -->
<script type="text/javascript">
	$(function(){
		$(".select-cate").on("input", function(){
			$(".result-ingredient").find("[data-cate=cate]").remove();
			var ingredientCategory = $(this).val();
			
			$.ajax({
				url: "http://localhost:8888/rest/ingredient/"+ingredientCategory,
				method: "get",
				success: function(resp){
					for(var i=0; i<resp.length; i++){
						var option = $("<option>").text(resp[i]).attr("data-cate", "cate");
						$(".result-ingredient").append(option);
					}
				}				
			});
			
		});
	});
</script>
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>