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
				<select class="sort-click form-select w-50" id="exampleSelect1">
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
				<td class="position-relative text-start">
					<a class="stretched-link text-decoration-none link-dark" href="detail/${recipeDto.recipeNo}">
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
<div class="pe-0 row mt-3">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1 text-end">
		<button type="button" class="recipe-async-delete btn btn-light btn-md">삭제하기</button>
	</div>
</div>
</div>
</form>

<div class="row mt-3">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1 ">
	<ul class="pagination" style="justify-content: center;">
        <li class="page-item disabled">
        	<a class="page-link"><i class="fa-solid fa-chevron-left"></i></a>
       	</li>
       	
        <li class="page-item active"><a class="page-link">1</a></li>
        <c:forEach var="no" begin="2" end="${voPagination.endBlock()}">
	        <li class="page-item"><a class="page-link" data-no="${no}">${no}</a></li>
        </c:forEach>
        
        <li class="page-item">
        	<a class="page-link" data-no="${voPagination.nextBlock()}">
        		<i class="fa-solid fa-chevron-right"></i>
       		</a>
       	</li>
    </ul>
    </div>
</div>

<div class="row mt-5">
	<div class="col-lg-4 offset-lg-4 col-md-8 offset-md-2 col-sm-10 offset-sm-1 text-center">
		<div class="row">
			<div class="col-3">
				<select class="input-type form-select w-100" id="exampleSelect1">
					<option value="recipe_title">제목</option>
					<option value="recipe_nick">작성자</option>
			<!-- 		<option value="">재료</option> -->
				</select>
			</div>
			<div class="col-7">
				<input class="input-keyword w-100 form-control" type="text">
			</div>
			<div class="col-2">
				<button class="btn btn-md yellow-btn recipe-search-btn w-100" type="button">검색</button>
			</div>
		</div>
	</div>
</div>
</div>

<script type="text/javascript">
    $(function(){
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
					table: "recipe"
			};
			async(data);
    	}));
    	
    	function async(data){
			$.ajax({
				url: "http://localhost:8888/rest/recipe",
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
			$(".recipe-list").empty();
			for(var i=0; i<resp.length; i++){
				var tr = $("<tr>").addClass("text-center");
				var check = $("<input>").addClass("check-item").attr("name", "recipeNo")
					.val(resp[i].recipeNo).attr("type", "hidden");
				var checkIcon = $("<i>").addClass("fa-regular fa-square icon-check-item");
				var tdCheck = $("<td>").append(checkIcon).append(check);
				var tdNo = $("<td>").text(resp[i].recipeNo);
				var link = $("<a>").addClass("stretched-link text-decoration-none link-dark")
					.attr("href", "detail/"+resp[i].recipeNo).text(resp[i].recipeTitle);
				var tdTitle = $("<td>").addClass("position-relative text-start").append(link);
				var tdTime = $("<td>").text(resp[i].recipeTime+'분');
				var tdNick = $("<td>").text(resp[i].recipeNick);
				tr.append(tdCheck).append(tdNo).append(tdTitle).append(tdTime).append(tdNick);
				$(".recipe-list").append(tr);
			}
			$(".icon-check-all").removeClass("fa-regular fa-square-check")
			.addClass("fa-regular fa-square");
    	}
    	
    	function page(data){
			$.ajax({
				url: "http://localhost:8888/rest/admin-count",
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
			var data = {
					type: type,
					keyword: keyword,
					sort: sort,
					p: 1,
					table: "recipe"
			};
			async(data);
		});
		
    	/* 레시피 리스트 정렬 */
		$(".sort-click").on("input", function(){
			var sort = $(this).val();
			var type = $(".input-type").val();
			var keyword = $(".input-keyword").val();
			var data = {
					type: type,
					keyword: keyword,
					sort: sort,
					p: 1,
					table: "recipe"
			};
			async(data);
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
							var data = {
									type: type,
									keyword: keyword,
									sort: sort,
									p: 1,
									table: "recipe"
							};
							async(data);
						}
					});
				}
			}
		});
    });
</script>
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>