<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<!-- 재료 등록 모달창 -->
<div class="modal ingredient-insert-modal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">재료 등록</h5>
      </div>
      <div class="modal-body row">
       	<select class="insert-ingredientCategory col-3">
       		<option value="">카테고리</option>
       		<c:forEach var="category" items="${categoryList}">
	       		<option>${category}</option>
       		</c:forEach>
       	</select>
       	<input class="insert-ingredientName col-7" type="text" placeholder="재료명">
       	<input type="hidden" class="origin-ingredientName">
		<button class="insert-ingredient-btn btn btn-light col-2" type="button">추가</button>
		<div class="invalid-feedback">이미 존재하는 재료입니다.</div>
      </div>
      <div class="modal-footer">
		<div class="add-ingredient-list"></div>
        <button type="button" class="btn btn-primary ingredient-insert-btn">등록하기</button>
        <button type="button" class="btn btn-primary ingredient-update-btn">수정하기</button>
        <button type="button" class="btn btn-secondary ingredient-insert-cancel" data-bs-dismiss="modal">돌아가기</button>
      </div>
    </div>
  </div>
</div>

<div class="mt-3">&nbsp;</div>
<div class="mt-3">&nbsp;</div>

<div class="history-link text-end">
	<a class="main-page-link"></a> <i class="fa-solid fa-chevron-right"></i> 재료 리스트
</div>

<div class="container-fluid">
<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-4">
				<select class="sort-click form-select">
					<c:choose>
						<c:when test="${voPagination.sort == 'ingredient_name desc'}">
							<option value="ingredient_name asc">재료명 오름차순</option>
							<option selected value="ingredient_name desc">재료명 내림차순</option>
							<option value="ingredient_category asc">카테고리 오름차순</option>
						</c:when>
						<c:when test="${voPagination.sort == 'ingredient_category asc'}">
							<option value="ingredient_name asc">재료명 오름차순</option>
							<option value="ingredient_name desc">재료명 내림차순</option>
							<option selected value="ingredient_category asc">카테고리 오름차순</option>
						</c:when>
						<c:otherwise>
							<option selected value="ingredient_name asc">재료명 오름차순</option>
							<option value="ingredient_name desc">재료명 내림차순</option>
							<option value="ingredient_category asc">카테고리 오름차순</option>
						</c:otherwise>
					</c:choose>
				</select>
			</div>
			<div class="col-8 text-end">
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
					<th class="col-1"><i class="fa-regular fa-square icon-check-all"></i></th>
					<th class="col-5">카테고리</th>
					<th class="col-5">재료명</th>
					<th class="col-1">수정</th>
				</tr>
			</thead>
			<tbody class="ingredient-list">
				<c:forEach var="ingredientDto" items="${ingredientList}">
					<tr class="text-center">
						<td>
							<i class="fa-regular fa-square icon-check-item"></i>
							<input class="check-item" name="ingredientName" value="${ingredientDto.ingredientName}" type="hidden">
						</td>
						<td>${ingredientDto.ingredientCategory}</td>
						<td>${ingredientDto.ingredientName}</td>
						<td class="edit-btn"><i class="fa-solid fa-pen"></i>
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
		<ul class="pagination custom-pagination border-none-pagination" style="justify-content: center;">
		
			<c:choose>
				<c:when test="${voPagination.hasPrev()}">
					<li class="page-item">
						<a class="page-link prev-page">
							<i class="fa-solid fa-chevron-left"></i>
						</a>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link"><i class="fa-solid fa-chevron-left"></i></a>
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
					<a class="page-link">${i}</a>
				</li>
			</c:forEach>
			
			<c:choose>
				<c:when test="${voPagination.hasNext()}">
					<li class="page-item">
						<a class="page-link next-page">
							<i class="fa-solid fa-chevron-right"></i>
						</a>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link"><i class="fa-solid fa-chevron-right"></i></a>
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
					<c:choose>
						<c:when test="${voPagination.type == 'ingredient_category'}">
							<option value="ingredient_name">재료명</option>
							<option value="ingredient_category" selected>카테고리</option>
						</c:when>
						<c:otherwise>
							<option value="ingredient_name" selected>재료명</option>
							<option value="ingredient_category">카테고리</option>
						</c:otherwise>
					</c:choose>
				</select>
			</div>
			<div class="col-9">
				<div class="input-group rounded">
					<input aria-describedby="button-addon2" class="input-keyword form-control" type="text" value="${voPagination.keyword}">
					<button class="btn-search" type="button" id="button-addon2">
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
		var modal = new bootstrap.Modal($(".ingredient-insert-modal"), {});
		
		/* 수정하기 */
		$(".ingredient-update-btn").click(function(){
			var ingredientName = $(".insert-ingredientName").val();
			$.ajax({
				url: "${pageContext.request.contextPath}/rest/ingredient/"+ingredientName,
				method: "get",
				success: function(resp){
					if(resp){
						$(".insert-ingredient-btn").addClass("is-invalid");
						return;
					}
				}
			});
			var ingredientCategory = $(".insert-ingredientCategory").val();
			var originName = $(".origin-ingredientName").val();
			var data = 
				{
					"ingredientCategory" : ingredientCategory,
					"ingredientName" : ingredientName,
					"originName" : originName
				};
			$.ajax({
				url: "${pageContext.request.contextPath}/rest/ingredient",
				method: "put",
				contentType: "application/json",
				data: JSON.stringify(data),
				success: function(resp){
					list(resp);
					reset();
					modal.hide();
				}
			});
			$(".ingredient-insert-btn").removeClass(".hidden-btn");
		});
		
		function reset(){
			var data = {
				sort: "ingredient_name asc",
				table: "ingredient"
			};
			page(data);
			$(".sort-click").val("ingredient_name asc");
			$(".input-type").val("ingredient_name");
			$(".input-keyword").val("");
		}
		
		/* 연필 누르면 수정 모달창 */
		$(document).on("click", ".edit-btn", (function(){
			var ingredient = $(this).prev().text();
			var category = $(this).prev().prev().text();
			$(".modal-title").text("재료 수정");
			$(".insert-ingredientCategory").val(category);
			$(".origin-ingredientName").val(ingredient);
			$(".insert-ingredientName").removeClass("is-invalid").val(ingredient);
			$(".insert-ingredient-btn").hide();
			$(".ingredient-insert-btn").addClass("hidden-btn").hide();
			$(".ingredient-update-btn").show();
			$(".add-ingredient-list").empty();
			modal.show();
		}));
		
		/* 페이지네이션 */
		$(document).on("click", ".page-link", (function(){
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
			var sort = $(".sort-click").val();
			var keyword = $(".input-keyword").val();
			var type = $(".input-type").val();
			var sortInput = $("<input>").attr("type", "hidden").attr("name", "sort").val(sort);
			var keywordInput = $("<input>").attr("type", "hidden").attr("name", "keyword").val(keyword);
			var typeInput = $("<input>").attr("type", "hidden").attr("name", "type").val(type);
			$("form").append(sortInput).append(pInput).append(keywordInput).append(typeInput);
			$("form").attr("action", "list").attr("method", "get").submit();
		}));
		
		/* 돌아가기 클릭 시 모달 값 삭제 */
		$(".ingredient-insert-cancel").click(function(){

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
				//등록할 때 엔터용
				if(!$(".ingredient-insert-btn").hasClass("hidden-btn")){
					$(".insert-ingredient-btn").click();
				}
				//수정할 때 엔터용
				else{
					$(".ingredient-update-btn").click();
				}
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
				url: "${pageContext.request.contextPath}/rest/ingredient/"+ingredientName,
				method: "get",
				success: function(resp){
					if(resp){
						$(".insert-ingredientName").addClass("is-invalid");
					}
					else{
						var ingredientNameInput = $("<input>").attr("type", "text")
							.attr("name", "ingredientName").val(ingredientName).addClass("col-5");
						var ingredientCateInput = $("<input>").attr("type", "text").addClass("col-6")
							.attr("name", "ingredientCategory").val(ingredientCategory.val());
						var xmark = $("<i>").addClass("fa-solid fa-xmark col-1");
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
		$(document).on("click", ".ingredinet-async-insert", (function(){
			$(".modal-title").text("재료 등록");
			$(".ingredient-insert-btn").show();
			$(".insert-ingredient-btn").removeClass("hidden-btn").show();
			$(".ingredient-update-btn").hide();
			$(".insert-ingredientName").removeClass("is-invalid");
            modal.show();
		}));
		
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
    				url: "${pageContext.request.contextPath}/rest/ingredient",
    				method: "post",
    				contentType: "application/json",
    				data: JSON.stringify(ingredientList),
    				success: function(resp){
    					list(resp);
						reset();
    					$(".add-ingredient-list").empty();
    					modal.hide();
    				}
    			});
    		}
    	});
		
		/* 체크박스 선택 삭제 시 비동기 처리 */
		$(".ingredient-async-delete").click(function(){
			var checkicons = $(".fa-square-check");
			if(checkicons.length == 0){
				alert("삭제할 레시피를 선택하세요.");
			}
			else{
				if(confirm("정말 삭제하시겠습니까?")){
				var checkboxes = $(".icon-check-item");
				for(var i=0; i<checkboxes.length; i++){
					if(checkboxes.eq(i).hasClass("fa-square")){
						checkboxes.eq(i).next().remove();
					}
				}
			
				var param = $(".ingredientName-form .check-item").serialize();
					$.ajax({
						url: "${pageContext.request.contextPath}/rest/ingredient_delete?"+param,
						method: "delete",
						contentType: "application/json",
						success: function(resp){
							list(resp);
							reset();
						}
					});
				}
			}
		});
		
    	/* 레시피 검색창에서 엔터치면 버튼 클릭 */
    	$(".input-keyword").keydown(function(e){
    		if(e.keyCode == 13) {
    			$(".btn-search").click();
    		}
   		});
    	
    	/* 레시피 리스트 검색 */
		$(".btn-search").click(function(){
			var sort = $(".sort-click").val();
			var type = $(".input-type").val();
			var keyword = $(".input-keyword").val();
			var param = new String();
			param.sort = sort;
			param.type = type;
			param.keyword = keyword;
			var search = $.param(param)
			$.ajax({
				url: "${pageContext.request.contextPath}/rest/ingredient?"+search,
				method: "get",
				contentType: "application/json",
				success: function(resp){
					list(resp);
					var data = {
							type: type,
							keyword: keyword,
							sort: sort,
							p: 1,
							table: "ingredient"
					};
					page(data);
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
				url: "${pageContext.request.contextPath}/rest/ingredient?"+search,
				method: "get",
				contentType: "application/json",
				success: function(resp){
					list(resp);
					var data = {
							type: type,
							keyword: keyword,
							sort: sort,
							p: 1,
							table: "ingredient"
					};
					page(data);
				}
			});
		});
    	
    	function page(data){
    		$.ajax({
				url: "${pageContext.request.contextPath}/rest/admin-count",
				method: "post",
				contentType: "application/json",
				data: JSON.stringify(data),
				success: function(resp){
		    		$(".pagination").empty();
		    		
		    		var prev = $("<i>").addClass("fa-solid fa-chevron-left");
		    		var linkPrev = $("<a>").addClass("page-link");
		    		var liPrev = $("<li>").addClass("page-item");
					if(!resp.havePrev){
						liPrev.addClass("disabled");
					}
					linkPrev.append(prev);
					liPrev.append(linkPrev);
					$(".pagination").append(liPrev);

					for(var i=resp.firstBlock; i<=resp.lastBlock; i++){
			    		var link = $("<a>").addClass("page-link").text(i);
			    		var li = $("<li>").addClass("page-item").append(link);
						if(resp.p==i){
							li.addClass("active");
						}
						$(".pagination").append(li);
					}
					
					var next = $("<i>").addClass("fa-solid fa-chevron-right");
		    		var linkNext = $("<a>").addClass("page-link");
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
    	
		function list(resp) {
			$(".ingredient-list").empty();
			for(var i=0; i<resp.length; i++){
				var tr = $("<tr>").addClass("text-center");
				var check = $("<input>").addClass("check-item").attr("name", "ingredientName")
					.val(resp[i].ingredientName).attr("type", "hidden");
				var checkIcon = $("<i>").addClass("fa-regular fa-square icon-check-item");
				var tdCheck = $("<td>").append(checkIcon).append(check);
				var tdCate = $("<td>").text(resp[i].ingredientCategory);
				var tdName = $("<td>").text(resp[i].ingredientName);
				var tdEdit = $("<td>").addClass("edit-btn")
					.append($("<i>").addClass("fa-solid fa-pen"));
				tr.append(tdCheck).append(tdCate).append(tdName).append(tdEdit);
				$(".ingredient-list").append(tr);
			}
			$(".icon-check-all").removeClass("fa-regular fa-square-check")
			.addClass("fa-regular fa-square");
		}
	});
</script>
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>
