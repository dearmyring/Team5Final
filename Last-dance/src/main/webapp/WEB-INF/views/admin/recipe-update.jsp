<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<!-- css 파일 불러옴 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin-recipe-insert.css">

<div class="modal ingredient-insert-modal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">재료 등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       	<select class="insert-ingredientCategory" name="ingredientCategory">
       		<option value="">카테고리 선택</option>
       		<c:forEach var="category" items="${categoryList}">
	       		<option>${category}</option>
       		</c:forEach>
       	</select>
       	<input class="insert-ingredientName" type="text" name="ingredientName" placeholder="재료명">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary ingredient-insert-btn">등록하기</button>
        <button type="button" class="btn btn-secondary ingredient-insert-cancel" data-bs-dismiss="modal">돌아가기</button>
      </div>
    </div>
  </div>
</div>

<div class="mt-3">&nbsp;</div>
<div class="mt-3">&nbsp;</div>

<div class="history-link text-end">
	<a class="main-page-link"></a> <i class="fa-solid fa-chevron-right"></i>
	<a href="list">레시피</a> <i class="fa-solid fa-chevron-right"></i> 
	 레시피 수정하기
</div>

<div class="container-fluid mt-5">

<form action="update" method="post" class="recipe-update-form" autocomplete="off" enctype="multipart/form-data">
<input type="hidden" name="recipeNo" value="${recipeDto.recipeNo}">

<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-2 fw-bolder">레시피 제목</div>
			<div class="col-8">
				<input type="text" name="recipeTitle" value="${recipeDto.recipeTitle}" class="w-100 h-100 rounded pt-1 pb-1">
				<div class="invalid-feedback">이미 존재하는 레시피 제목입니다.</div>
			</div>
		</div>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-2 fw-bolder">레시피 소개</div>
			<div class="col-8">
				<input type="text" class="w-100 h-100 rounded pt-1 pb-1" name="recipeInfo" value="${recipeDto.recipeInfo}" 
				placeholder="예) 생일에 빼놓을 수 없는 소고기를 넣어 더욱 깊은 맛으로 즐겨보세요.">
			</div>
		</div>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-2 fw-bolder">레시피 정보</div>
			<div class="col-2 me-4">시간</div>
			<div class="col-2 me-1">
				<select name="recipeTime" class="rounded pb-1 ps-1">
					<option value="">시간</option>
					<c:forEach var="i" begin="5" step="5" end="120">
						<c:choose>
							<c:when test="${i != 120}">
								<option <c:if test="${recipeDto.recipeTime == i}">selected</c:if> value="${i}">${i}분</option>
							</c:when>
							<c:otherwise>
								<option <c:if test="${recipeDto.recipeTime == i}">selected</c:if> value="${i}">120분 이상</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
			</div>
			<div class="col-2 pe-0">난이도</div>
			<div class="col-2 ps-0">
				<select class="rounded pb-1 ps-1" name="recipeDifficulty">
				    <option value="">난이도</option>
				    <c:choose>
				    	<c:when test="${recipeDto.recipeDifficulty == '쉬워요'}">
						    <option selected value="쉬워요">쉬워요</option>
						    <option value="보통이에요">보통이에요</option>
						    <option value="어려워요">어려워요</option>
				    	</c:when>
				    	<c:when test="${recipeDto.recipeDifficulty == '보통이에요'}">
						    <option value="쉬워요">쉬워요</option>
						    <option selected value="보통이에요">보통이에요</option>
						    <option value="어려워요">어려워요</option>
				    	</c:when>
				    	<c:otherwise>
						    <option value="쉬워요">쉬워요</option>
						    <option value="보통이에요">보통이에요</option>
						    <option selected value="어려워요">어려워요</option>
				    	</c:otherwise>
				    </c:choose>
				</select>
			</div>
		</div>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<i class="fa-regular fa-lightbulb"></i>음식의 재료를 입력해주세요.
	</div>
</div>
<div class="row">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<input type="text" class="input-ingredient rounded" placeholder="재료">
		<button type="button" class="ingredient-all-clear btn btn-md btn-light">모두 지우기</button>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="search-ingredient col-6"></div>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="add-ingredient col-10">
			<c:forEach var="ingredient" items="${recipeIngredientList}">
				<p>
					<input type="text" name="recipeIngredientName" value="${ingredient}" readonly>
					<i class="fa-solid fa-xmark"></i>
				</p>
			</c:forEach>
		</div>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-3 fw-bolder">요리 순서</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-12">
				<label>
					<i class="fa-regular fa-lightbulb"></i>요리의 맛이 좌우될 수 있는 중요한 부분은 빠짐없이 적어주세요.
					<textarea readonly rows="4" cols="100">
					예) 10분간 익혀주세요       10분간 약한불로 익혀주세요.
					      마늘편은 익혀주세요        마늘편은 충분히 익혀주셔야 매운 맛이 사라집니다.
					      꿀을 조금 넣어주세요         꿀이 없는 경우, 설탕 1스푼으로 대체 가능합니다.
					</textarea> 
				</label>
			</div>
		</div>
	</div>
</div>

<c:forEach var="no" begin="0" end="9">
<div class="content-page">
<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-2 d-flex align-items-center fs-4">
				Step <fmt:formatNumber value="${no+1}" minIntegerDigits="2"/>
			</div>
			<div class="col-7">
				<textarea class="w-100 h-100 rounded" name="recipeContentText">${recipeContentList[no].recipeContentText}</textarea>
			</div>
			<div class="col-3">
				<c:choose>
					<c:when test="${recipeContentList[no].recipeContentAttachmentNo != null}">
						<input type="hidden" class="origin-img" value="${recipeContentList[no].recipeContentAttachmentNo}">
						<input type="file" class="file-input" accept=".jpg, .png, .gif">
						<img class="preview rounded" src="${pageContext.request.contextPath}/rest/download/${recipeContentList[no].recipeContentAttachmentNo}" width="200" height="200">
					</c:when>
					<c:otherwise>
						<input type="file" class="file-input" accept=".jpg, .png, .gif">
						<img class="preview rounded" src="${pageContext.request.contextPath}/images/img_plus.png" width="200" height="200">
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</div>

<div class="row mt-2">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1 text-center">
		<label class="step-plus-btn"><button class="green-btn btn btn-md ps-2 pe-2" type="button">
			<i class="ms-1 me-1 fa-solid fa-plus"></i></button> 순서 추가
		</label>
		<label class="step-minus-btn"><button class="green-btn btn btn-md ps-2 pe-2" type="button">
			<i class="ms-1 me-1 fa-solid fa-minus"></i></button> 순서 삭제
		</label>
	</div>
</div>
</div>
</c:forEach>

<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-2 pe-0">
				<span class="fw-bolder">요리 완성사진</span> 
<!-- 				<button type="button">사진 한 번에 넣기</button> -->
				<button class="thumb-all-clear btn btn-md btn-light mt-3" type="button">사진 모두 지우기</button>
			</div>
			<div class="thumb-page col-10">
				<c:forEach var="no" begin="0" end="3">
					<c:choose>
						<c:when test="${recipeImgList[no] != null}">
							<input type="hidden" class="origin-img" value="${recipeImgList[no]}">
							<input type="file" class="file-input" accept=".jpg, .png, .gif">
							<img class="preview rounded" src="${pageContext.request.contextPath}/rest/download/${recipeImgList[no]}" width="200" height="200">
						</c:when>
						<c:otherwise>
							<input type="file" class="file-input" accept=".jpg, .png, .gif">
							<img class="preview preview-disabled rounded" src="${pageContext.request.contextPath}/images/img_plus.png" width="200" height="200">
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
		</div>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row pe-0">
			<div class="col-2 pe-0 fw-bolder">요리 해시태그</div>
			<div class="col-2">
				<select name="recipeHashtag" class="rounded">
					<option value="">해시태그</option>
					<c:forEach var="hashtagDto" items="${hashtagList}">
					<c:choose>
						<c:when test="${hashtagDto.hashtagName == recipeDto.recipeHashtag}">
							<option selected>${hashtagDto.hashtagName}</option>
						</c:when>
						<c:otherwise>
							<option>${hashtagDto.hashtagName}</option>
						</c:otherwise>
					</c:choose>
					</c:forEach>
				</select>
			</div>
		</div>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-6 text-end">
				<button class="col-6 btn btn-md text-lg btn-light recipe-return-btn" type="button">돌아가기</button>
			</div>
			<div class="col-6">
				<button class="col-6 btn btn-md text-lg yellow-btn recipe-insert-btn" type="submit">레시피 수정하기</button>
			</div>
		</div>
	</div>
</div>

</form>
</div>

<style>
	.file-input{
		display: none;
	}
	.preview{
		border: 1px solid #C2C2C2;
		cursor: pointer;
	}
	.preview.preview-disabled{
		cursor: default;
		opacity: 0.5; 
	}
	.thumb-page{
		display: inline;
	}
	.return-img{
	}
</style>

<script type="text/javascript">
	$(function(){
		$(".fa-xmark").click(function(){
			$(this).parent().remove();
		});
		
		$(".preview-disabled").eq(0).removeClass("preview-disabled");
		
    	/* 제목 블러 시 자기 제외 기존 제목 확인 구현 예정 */
    	$("[name=recipeTitle]").blur(function(){
    		var data = {recipeTitle : $(this).val()};
    		var param = $.param(data);
    		var that = $(this);
    		$.ajax({
    			url: "${pageContext.request.contextPath}/rest/recipe_find?"+param,
    			method: "get",
    			success: function(resp){
    				if(resp.recipeNo != $("[name=recipeNo]").val()){
    					that.addClass("is-invalid");
    				}
    			}
    		});
    	});
    	
    	$("[name=recipeTitle]").on("input", function(){
    		$(this).removeClass("is-invalid");
    	});
    	
		/* 미리보기 클릭 시 파일 추가 */
    	$(".preview").click(function(){
    		if(!$(this).hasClass("preview-disabled")){
	    		$(this).prev().click();
    		}
    	});
    	
    	/* 재료 등록 후 바로 추가 안내 */
    	$(".ingredient-insert-btn").click(function(e){
    		if(confirm("재료를 등록하시겠습니까?")){
    			var ingredientName = $(this).parent().prev().find(".insert-ingredientName").val();
    			var ingredientCategory = $(this).parent().prev().find(".insert-ingredientCategory").val();
    			var ingredinetList = [{
    				ingredientName : ingredientName,
    				ingredientCategory : ingredientCategory
				}];
    			$.ajax({
    				url: "${pageContext.request.contextPath}/rest/ingredient",
    				method: "post",
    				contentType: "application/json",
    				data: JSON.stringify(ingredinetList),
    				success: function(resp){
    					if(confirm("레시피에 바로 추가하시겠습니까?")){
    						var xMark = $("<i>").addClass("fa-solid fa-xmark");
							xMark.click(function(){
								$(this).parent().remove();
							});
							var p = $("<p>")
							var input = $("<input>")
								.attr("readonly", "readonly")
								.attr("name", "recipeIngredientName")
								.val(ingredientName);
							p.append(input).append(xMark);
							$(".add-ingredient").append(p);
    					}
						$(".input-ingredient").val("");
						$(".insert-ingredientCategory").val("");
                        $(".ingredient-insert-modal").modal("hide");
    				}
    			});
    		}
    		$(".input-ingredient").focus();
    	});
    	
    	/* 재료 등록 취소 */
    	$(".ingredient-insert-cancel").click(function(e){
    		if(!confirm("재료 등록을 취소하시겠습니까?")){
	    		e.preventDefault();
    		}
    	});
    	
    	/* 썸네일 사진 모두 지우기 클릭 시 비동기 삭제 & 미리보기 사진 변경 */
    	$(".thumb-all-clear").click(function(){
    		if(confirm("모두 삭제하시겠습니까?")){
	    		var param = $(".thumb-page .img-no").serialize();
	    		$.ajax({
	    			url: "${pageContext.request.contextPath}/rest/attachment/delete?"+param,
	    			method: "delete",
	    			success: function(resp){
	    				$(".thumb-page").find(".file-input").val("");
			    		$(".thumb-page").find(".preview").attr("src", "${pageContext.request.contextPath}/images/img_plus.png").addClass("preview-disabled");
			    		$(".thumb-page").find(".img-no").remove();
			    		$(".thumb-page").find(".preview").first().removeClass("preview-disabled");
	    			}
	    		});
    		}
    	});
    	
    	/* 엔터 시 폼 전송 방지 */
    	$(".recipe-update-form").keydown(function(e){
    		if(e.keyCode === 13){
	    		e.preventDefault();
    		}
    	});
    	
    	/* 등록하기 버튼 클릭 시 모든 칸 검사 후 제출 */
    	$(".recipe-update-form").submit(function(e){
	   		var recipeTitle = $("[name=recipeTitle]");
	   		if(!recipeTitle.val() || recipeTitle.hasClass("is-invalid")){
	   			alert("레시피 제목을 등록해주세요.");
	   			recipeTitle.focus();
	   			$("html, body").animate({scrollTop: recipeTitle.offset().top-100},400);
	   			return false;
	   		}
	   		
	   		var recipeInfo = $("[name=recipeInfo]");
	   		if(!recipeInfo.val()){
	   			alert("레시피 소개를 등록해주세요.");
	   			recipeInfo.focus();
	   			$("html, body").animate({scrollTop: recipeInfo.offset().top-100},400);
	   			return false;
	   		}
	
	   		var recipeTime = $("[name=recipeTime]");
	   		if(!recipeTime.val()){
	   			alert("레시피 소요시간을 선택해주세요.");
	   			recipeTime.focus();
	   			return false;
	   		}
	   		
	   		var recipeDifficulty = $("[name=recipeDifficulty]");
	   		if(!recipeDifficulty.val()){
	   			alert("레시피 난이도를 선택해주세요.");
	   			recipeDifficulty.focus();
	   			return false;
	   		}
	
	   		var recipeIngredient = $("[name=recipeIngredientName]");
	   		if(!recipeIngredient.val()){
	   			alert("레시피 재료를 선택해주세요.");
	   			$(".input-ingredient").focus();
	   			$("html, body").animate({scrollTop: $(".input-ingredient").offset().top-100},400);
	   			return false;
	   		}
	   		
			var contentText = $("[name=recipeContentText]");
			var contentImg = $(".content-page").find(".preview");
			//레시피 컨텐트 아예 없을 때 리턴
			var contentCnt = 0;
			var contentImgCnt = 0;
			for(var i=0; i<contentText.length; i++){
				if(contentText.eq(i).text()){
					contentCnt++;
				}
				if(!contentImg.eq(i).attr("src").includes("img_plus.png")){
					contentImgCnt++;
				}
				if(contentCnt != contentImgCnt){
				    alert("레시피 내용 작성을 완료해주세요.");
				    return false;
				}
			}

			//레시피 컨텐트 아예 아무 것도 없을 때
			if(contentCnt == 0 && contentImgCnt == 0){
				alert("레시피 내용을 등록해주세요.");
				contentText.first().focus();
	   			$("html, body").animate({scrollTop: contentText.first().offset().top-100},400);
				return false;
			}
	
           //레시피 썸네일 아예 없을 때 리턴
			var recipeImg = $(".thumb-page").find(".preview");
			var recipeImgCnt = 0;
			for(var i=0; i<recipeImg.length; i++){
				if(!recipeImg.eq(i).attr("src").includes("img_plus.png")){
					recipeImgCnt++;	
				}
			}
			//레시피 썸네일 아예 없을 때
			if(recipeImgCnt == 0){
				alert("레시피 썸네일을 지정해주세요.");
	   			$("html, body").animate({scrollTop: recipeImg.first().offset().top-100},400);
				return false;
			}
	   		
	   		var recipeHashtag = $("[name=recipeHashtag]");
	   		if(!recipeHashtag.val()){
	   			alert("레시피 해시태그를 선택해주세요.");
	   			recipeHashtag.focus();
	   			return false;
	   		}
	   		
	   		var choice = confirm("등록하시겠습니까?");
	   		if(!choice){
	    		e.preventDefault();
	   		}
	   		else{
				//레시피 내용 작성 돼 있으면 그 다음 칸부터는 삭제
	            for(var i=contentCnt; i<contentText.length; i++){
	                contentText.eq(i).parents(".content-page").remove();
	            }
				//레시피 썸네일 없는 칸부터 빈칸 삭제
				for(var i=0; i<recipeImg.length; i++){
					if(recipeImg.eq(i).attr("src").includes("img_plus.png")){
						recipeImg.eq(i).remove();
					}
				}
				for(var i=0; i<contentText.length; i++){
					if(!$(".content-page").eq(i).find("[name=recipeContentAttachmentNo]").val()){
						$(".content-page").eq(i).find(".origin-img").attr("name", "recipeContentAttachmentNo");
					}
				}
				for(var i=0; i<recipeImg.length; i++){
					if(!$("[name=recipeAttachmentNo]").eq(i).val()){
						$(".thumb-page").find(".origin-img").eq(i).attr("name", "recipeAttachmentNo");
					}
				}
	   		}
    	});
    	
    	/* 레시피 돌아가기 클릭 시 업데이트한 첨부파일 비동기로 삭제 구현 예정 */
    	$(".recipe-return-btn").click(function(e){
    		if($(".img-no")){
	    		var param = $(".recipe-update-form .img-no").serialize();
	    		$.ajax({
	    			url: "${pageContext.request.contextPath}/rest/attachment/delete?"+param,
	    			method: "delete",
	    			success: function(resp){
	    				history.back();
	    			}
	    		});
    		}
    	});
    	
    	/* 레시피 내용 블러 시 textarea 안에 값 넣어주기 */
    	$("[name=recipeContentText]").blur(function(){
    		$(this).text($(this).val());
    	});
    	
    	/* 재료 입력 비동기 불러오기 */
    	$(".input-ingredient").on("input", function(){
            setTimeout(() => {
                var keyword = $(this).val();
                if(keyword == ""){
                    $(".ingredientSearch").remove();
                }
                else{
                	var param = new String();
                	param.type = "ingredient_name";
                	param.keyword = keyword;
                	var search = $.param(param);
                    $.ajax({
                        url: "${pageContext.request.contextPath}/rest/ingredient?"+search,
                        method: "get",
                        success: function(resp){
                            $(".ingredientSearch").remove();
                            for(var i=0; i<resp.length; i++){
                                var pTag = $("<p>")
                                    .addClass("ingredientSearch")
                                    .text(resp[i].ingredientName);
                                
                                pTag.click(function(){
                                	var addIngredientCnt = $(".add-ingredient").find("[name=recipeIngredientName]");
                                	for(var i=0; i<addIngredientCnt.length; i++){
	                                	if($(this).text() == addIngredientCnt.eq(i).val()){
	                                		alert("이미 등록된 재료입니다.");
	                                		$(".ingredientSearch").remove();
	                                		$(".input-ingredient").val("");
	                                		return;
	                                	}
                                	}
                                		
                                    var xMark = $("<i>").addClass("fa-solid fa-xmark");
                                    xMark.click(function(){
                                        $(this).parent().remove();
                                    });
                                    
                                    var p = $("<p>")
                       				var input = $("<input>")
										.attr("readolny", true)
	                                    .attr("name", "recipeIngredientName")
	                                    .val($(this).text());
                                    p.append(input).append(xMark);
                                    $(".add-ingredient").append(p);
                                    $(".ingredientSearch").remove();
                                    $(".input-ingredient").val("");
                                });
                                
                                $(".search-ingredient").append(pTag);
                            }
                        }
                    });
                }
            }, 1000);
        });

    	/* 재료 엔터 등록 없을 시 등록 모달 구현 예정 */
    	$(".input-ingredient").keydown(function(e){
    		if(e.keyCode == 13) {
	    		$(".ingredientSearch").remove();
    			var keyword = $(this).val();
    			$.ajax({
                    url: "${pageContext.request.contextPath}/rest/ingredient/"+keyword,
                    method: "get",
                    success: function(resp){
                    	if(!resp){
                    		if(confirm("등록되지 않은 재료입니다. 해당 재료를 등록하시겠습니까?")){
                    			$(".insert-ingredientName").val(keyword);
	                            var modal = new bootstrap.Modal($(".ingredient-insert-modal"), {});
	                            modal.show();
                    		}
                    	}
                    	else{
                        	var addIngredientCnt = $(".add-ingredient").find("[name=recipeIngredientName]");
                        	for(var i=0; i<addIngredientCnt.length; i++){
                            	if(keyword == addIngredientCnt.eq(i).val()){
                            		alert("이미 등록된 재료입니다.");
                            		$(".ingredientSearch").remove();
                            		$(".input-ingredient").val("");
                            		return;
                            	}
                        	}
                        	
							var xMark = $("<i>").addClass("fa-solid fa-xmark");
							xMark.click(function(){
								$(this).parent().remove();
							});
							var p = $("<p>")
							var input = $("<input>")
								.attr("readonly", "readonly")
								.attr("name", "recipeIngredientName")
								.val(keyword);
							p.append(input).append(xMark);
							$(".add-ingredient").append(p);
							$(".input-ingredient").val("");
                    	}
                    }
    			});
    		}
    	});
    	
    	/* 전체 삭제 클릭 시 등록된 재료 전부 삭제 */
    	$(".ingredient-all-clear").click(function(){
    		$("[name=recipeIngredientName]").parent().remove();
    	});
    	
    	$(".step-plus-btn").last().remove();
    	$(".step-minus-btn").first().remove();
    	$(".content-page").hide();
    	
    	/* 레시피 내용 있는 곳 show */
    	var contentUpdateCnt = 0;
    	var contentUpdateInput = $(".content-page").find("[name=recipeContentText]");
    	for(var i=0; i<contentUpdateInput.length; i++){
    		if(contentUpdateInput.eq(i).val()){
    			contentUpdateCnt++;
    		}
    	}
    	for(var i=0; i<contentUpdateCnt; i++){
    		$(".content-page").eq(i).show();
    	}
    	for(var i=0; i<contentUpdateCnt-1; i++){
    		$(".step-plus-btn").eq(i).hide();
    		if(i!=0){
	    		$(".step-minus-btn").eq(i-1).hide();
    		}
    	}

    	/* 순서 추가 버튼 클릭 시 다음 단계 등록 영역 생성 */
    	$(".step-plus-btn").click(function(){
    		var contentText = $(this).parents(".content-page").find("[name=recipeContentText]").val();
    		var contentImg = $(this).parents(".content-page").find(".preview").attr("src").includes("img_plus.png");
    		if(!contentText || contentImg){
    			alert("레시피 내용은 순서대로 등록해주세요.");
    			return;
    		}
    		$(this).hide();
    		$(this).next().hide();
    		$(this).parents(".content-page").next().show();
    	});
    	$(".step-minus-btn").click(function(){
    		var that = $(this);
    		var contentText = $(this).parents(".content-page").find("[name=recipeContentText]");
    		var contentImg = $(this).parents(".content-page").find(".preview");
    		
    		if(!contentText && contentImg.attr("src").includes("img_plus.png")){
    			$(this).parents(".content-page").prev().find(".step-plus-btn").show();
    			$(this).parents(".content-page").prev().find(".step-minus-btn").show();
    			$(this).parents(".content-page").hide();
    			return;
    		}
    		if(contentText.val() || !contentImg.attr("src").includes("img_plus.png")){
    			var choice = confirm("작성한 내용은 저장되지 않습니다. 삭제하시겠습니까?");
    			if(!choice){
    				return;
    			}
    			else{
		    		var recipeContentAttachmentNo = $(this).parents(".content-page").find(".img-no").val();
    				var attachmentNo = {recipeContentAttachmentNo : recipeContentAttachmentNo};
    				var param = $.param(attachmentNo);
    			}
    		}
    		$.ajax({
    			url: "${pageContext.request.contextPath}/rest/attachment/delete?"+param,
    			method: "delete",
    			success: function(resp){
					contentText.val("");
					contentImg.attr("src", "${pageContext.request.contextPath}/images/img_plus.png");
					that.parents(".content-page").find(".img-no").remove();
					that.parents(".content-page").find(".file-input").val("");
					that.parents(".content-page").prev().find(".step-plus-btn").show();
					that.parents(".content-page").prev().find(".step-minus-btn").show();
					that.parents(".content-page").hide();
    			}
    		});
    	});

    	/* 이미지 업로드 비동기 후 미리보기 구현 */
        $(".file-input").change(function(){
        	var that = $(this);
            if(this.files.length > 0){
                var fd = new FormData();
                fd.append("attach", this.files[0]);
                $.ajax({
                    url: "${pageContext.request.contextPath}/rest/upload",
                    method: "post",
                    data: fd,
                    processData: false,
                    contentType: false,
                    success: function(resp){
                    	that.next().attr("src", resp);
                    	var attachmentNo = parseInt((resp.split("download/"))[1]);
                    	
//                     	var back = $("<i>").addClass("fa-solid fa-arrow-rotate-left return-img");
//                     	back.click(function(){
//                     		if(choice("기존 이미지로 변경하시겠습니까?")){
//                     			$(this).remove();
//                     			var param = $(this).prev().prev().serialize();
//                     			$.ajax({
//     	                    		url: "${pageContext.request.contextPath}/rest/attachment/delete?"+param,
//     	                    		method: "delete",
//     	                    		success: function(resp){
// 		                    			$(this).prev().prev().remove();
// 		                    			var originNo = that.prev().prev().prev().val();
// 		                    			that.next().attr("src", "${pageContext.request.contextPath}/rest/download/"+originNo);
//     	                    		}
//                         		});
//                     		}
//                     	});
                    	
                    	if(that.parent().hasClass("thumb-page")){
	                    	var changeNo = $("<input>").attr("type", "hidden").addClass("img-no").attr("name", "recipeAttachmentNo").val(attachmentNo);
	                    	if(that.next().next().next().hasClass("preview-disabled")){
								that.parent().find(".preview-disabled").first().removeClass("preview-disabled");
	                    	}
                    	}
                    	if(that.parents(".content-page").hasClass("content-page")){
	                    	var changeNo = $("<input>").attr("type", "hidden").addClass("img-no").attr("name", "recipeContentAttachmentNo").val(attachmentNo);
                    	}
                    	if(that.prev().hasClass("img-no")){
                   			var param = that.prev().serialize();
                    		$.ajax({
	                    		url: "${pageContext.request.contextPath}/rest/attachment/delete?"+param,
	                    		method: "delete",
	                    		success: function(resp){
		                    		that.prev().val(attachmentNo);
	                    		}
                    		});
                    	}
                    	else{
                    		that.before(changeNo);
                    	}
                    }
                });
            }
            else{
                that.next().attr("src", "${pageContext.request.contextPath}/images/img_plus.png");
            }
        });
    });
</script>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>