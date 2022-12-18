<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="modal ingredient-insert-modal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">재료 등록</h5>
      </div>
      <div class="modal-body">
       	<select class="insert-ingredientCategory">
       		<option value="">카테고리 선택</option>
       		<c:forEach var="category" items="${categoryList}">
	       		<option>${category}</option>
       		</c:forEach>
       	</select>
       	<input class="insert-ingredientName" type="text" placeholder="재료명">
		<button class="insert-ingredient-btn" type="button">추가</button>
		<div class="invalid-feedback">이미 존재하는 재료입니다.</div>
      </div>
      <div class="modal-footer">
		<div class="add-ingredient-list"></div>
        <button type="button" class="btn btn-primary ingredient-insert-btn">등록하기</button>
        <button type="button" class="btn btn-secondary ingredient-insert-cancel" data-bs-dismiss="modal">돌아가기</button>
      </div>
    </div>
  </div>
</div>

<div class="mt-5">&nbsp;</div>

<div class="text-end">
	<a class="main-page-link"></a> > 재료 리스트
</div>

<div class="container-fluid">
<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-6">
				<select class="sort-click">
					<option value="ingredient_name asc">재료명 오름차순</option>
					<option value="ingredient_name desc">재료명 내림차순</option>
				</select>
			</div>
			<div class="col-6 text-end">
				<button type="button" class="ingredinet-async-insert btn yellow-btn btn-md">추가하기</button>
			</div>
		</div>
	</div>
</div>

<form class="ingredientName-form">
<div class="row mt-3">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<table class="table table-sm">
			<thead>
				<tr class="text-center">
					<th><i class="fa-regular fa-square icon-check-all"></i></th>
					<th>카테고리</th>
					<th>재료명</th>
				</tr>
			</thead>
			<tbody class="ingredient-list">
				<c:forEach var="ingredientDto" items="${ingredientList}">
					<tr class="text-center">
						<td class="col-1">
							<i class="fa-regular fa-square icon-check-item"></i>
							<input class="check-item" name="ingredientName" value="${ingredientDto.ingredientName}" type="hidden">
						</td>
						<td class="col-5">${ingredientDto.ingredientCategory}</td>
						<td class="col-6">${ingredientDto.ingredientName}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
</form>

<div class="row mt-3">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="text-end">
			<button type="button" class="ingredient-async-delete btn btn-light btn-md">삭제하기</button>
		</div>
	</div>
</div>

<div class="row mt-3">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<ul class="pagination border-none-pagination" style="justify-content: center;">
		
			<c:choose>
				<c:when test="${voPagination.hasPrev()}">
					<li class="page-item">
						<a class="page-link prev-page" href="#">
							<i class="fa-solid fa-chevron-left"></i>
						</a>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" href="#"><i class="fa-solid fa-chevron-left"></i></a>
				</c:otherwise>
			</c:choose>
			</li>
			
			<c:forEach var="i" begin="${voPagination.startBlock()}" end="${voPagination.endBlock()}" step="1">
				<c:choose>
					<c:when test="${voPagination.p != i}">
						<li class="page-item">
					</c:when>
					<c:otherwise>
						<li class="page-item active">
					</c:otherwise>
				</c:choose>
					<a class="page-link" href="#">${i}</a>
				</li>
			</c:forEach>
			
			<c:choose>
				<c:when test="${voPagination.hasNext()}">
					<li class="page-item">
						<a class="page-link next-page" href="#">
							<i class="fa-solid fa-chevron-right"></i>
						</a>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link" href="#"><i class="fa-solid fa-chevron-right"></i></a>
				</c:otherwise>
			</c:choose>
			</li>
			
		</ul>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-4 offset-lg-4 col-md-8 offset-md-2 col-sm-10 offset-sm-1 text-center">
		<div class="row">
			<div class="col-3">
				<select class="input-type form-select w-100 pe-3" id="exampleSelect1">
					<option value="ingredient_name">재료명</option>
					<option value="ingredient_category">카테고리</option>
				</select>
			</div>
			<div class="col-9">
				<input class="input-keyword w-100 form-control" type="text">
			</div>
		</div>
	</div>
</div>
</div>	

<script type="text/javascript">
	$(function(){
		/* 페이지네이션 */
		$(".page-link").click(function(){
			var p = "";
			if($(this).hasClass("next-page")){
				p = Number($(this).parent().prev().find(".page-link").text())+1;
			}
			else if($(this).hasClass("prev-page")){
				p = Number($(this).parent().next().find(".page-link").text())-1;
			}
			else{
				p = $(this).text();
			}
			var pInput = $("<input>").attr("type", "hidden").attr("name", "p").val(p);
			$(".sort-click").attr("name", "sort");
			var keyword = $(".input-keyword").val();
			var type = $(".input-type").val();
			var keywordInput = $("<input>").attr("type", "hidden").attr("name", "keyword").val(keyword);
			var typeInput = $("<input>").attr("type", "hidden").attr("name", "type").val(type);
			$("form").append(pInput).append(keywordInput).append(typeInput);
			$("form").attr("action", "list").attr("method", "get").submit();
		});
		
		/* 돌아가기 클릭 시 모달 값 삭제 */
		$(".ingredient-insert-cancel").click(function(){
			var modal = new bootstrap.Modal($(".ingredient-insert-modal"), {});

			var insertIngredientName = $(".add-ingredient-list").find("[name=ingredientName]").val();
			var insertIngredientCategory = $(".add-ingredient-list").find("[name=ingredientCategory]").val();
			
			if(insertIngredientName || insertIngredientCategory){
				if(!confirm("입력한 내용은 저장되지 않습니다. 재료 등록을 취소하시겠습니까?")){
					modal.show();
				}
				else{
					$(".add-ingredient-list").find("div").remove();
					modal.hide();
				}
			}
			$(".insert-ingredientName").val("");
			$(".insert-ingredientCategory").val("");
		});
		
		/* 엔터치면 추가 */
		$(".insert-ingredientName").keydown(function(e){
			if(e.keyCode == 13){
				$(".insert-ingredient-btn").click();
			}
		});
		
		/* 재료 추가 */
		$(".insert-ingredient-btn").click(function(){
			var ingredientCategory = $(".insert-ingredientCategory");
			var ingredientName = $(".insert-ingredientName").val();
			if(!ingredientName || !ingredientCategory.val()){
				alert("등록 정보를 확인해주세요.");
				return;
			}
			$.ajax({
				url: "http://localhost:8888/rest/ingredient/"+ingredientName,
				method: "get",
				success: function(resp){
					if(resp){
						$(".insert-ingredientName").addClass("is-invalid");
					}
					else{
						var ingredientNameInput = $("<input>").attr("type", "text").attr("name", "ingredientName").val(ingredientName);
						var ingredientCateInput = $("<input>").attr("type", "text").attr("name", "ingredientCategory").val(ingredientCategory.val());
						var xmark = $("<i>").addClass("fa-solid fa-xmark");
						xmark.click(function(){
							$(this).parent().remove();
						});
						var ingredientList = $("<div>").append(ingredientCateInput).append(ingredientNameInput).append(xmark);
						$(".add-ingredient-list").append(ingredientList);
						$(".insert-ingredientName").val("");
						ingredientCategory.val("");
					}
				}
			});			
		});
		
		/* 입력하면 안내문구 없애기	 */
		$(".insert-ingredientName").on("input", function(){
			$(this).removeClass("is-invalid");
		});
		
		/* 재료 등록 모달창 띄우기 */
		$(".ingredinet-async-insert").click(function(){
            var modal = new bootstrap.Modal($(".ingredient-insert-modal"), {});
            modal.show();
		});
		
		/* 재료 한 번에 등록 */
    	$(".ingredient-insert-btn").click(function(e){
  		    var size = $(".add-ingredient-list").find("[name=ingredientName]").length;
  		    var ingredientList = [];
  	        for(var i=0; i<size; i++){
  	        	var ingredientItem ={
  	        		ingredientName : $(".add-ingredient-list").find("[name=ingredientName]").eq(i).val(),
 	        		ingredientCategory: $(".add-ingredient-list").find("[name=ingredientCategory]").eq(i).val()
  	        	};
  	        	ingredientList.push(ingredientItem);
  	        }
  			if(ingredientList.length == 0){
  				alert("재료를 추가해주세요.");
  				return;
  			}
    		if(confirm("재료를 등록하시겠습니까?")){
    			$.ajax({
    				url: "http://localhost:8888/rest/ingredient",
    				method: "post",
    				contentType: "application/json",
    				data: JSON.stringify(ingredientList),
    				success: function(resp){
    					list(resp);
    				}
    			});
    		}
    	});
		
		/* 체크박스 선택 삭제 시 비동기 처리 */
		$(".ingredient-async-delete").click(function(){
			
			var param = $(".ingredientName-form input:checked").serialize();
			if(!param){
				alert("삭제할 재료를 선택하세요.");
				return;
			}
			else{
				if(confirm("정말 삭제하시겠습니까?")){
					$.ajax({
						url: "http://localhost:8888/rest/ingredient?"+param,
						method: "delete",
						contentType: "application/json",
						success: function(resp){
							list(resp);
						}
					});
				}
			}
		});
		
    	/* 레시피 검색창에서 엔터치면 리스트 검색 */
    	$(".input-keyword").keydown(function(e){
    		if(e.keyCode == 13) {
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
						list(resp);
					}
				});
    		}
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
					list(resp);
				}
			});
		});
    	
		function list(resp) {
			$(".ingredient-list").empty();
			for(var i=0; i<resp.length; i++){
				var tr = $("<tr>");
				var check = $("<input>").addClass("check-item").attr("name", "recipeNo")
					.val(resp[i].recipeNo).attr("type", "hidden");
				var checkIcon = $("<i>").addClass("fa-regular fa-square icon-check-item");
				var tdCheck = $("<td>").append(checkIcon).append(check);
				var tdCate = $("<td>").text(resp[i].ingredientCategory);
				var tdName = $("<td>").text(resp[i].ingredientName);
				tr.append(tdCheck).append(tdCate).append(tdName);
				$(".ingredient-list").append(tr);
			}
			$(".icon-check-all").removeClass("fa-regular fa-square-check")
			.addClass("fa-regular fa-square");
		}
	});
</script>
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>
