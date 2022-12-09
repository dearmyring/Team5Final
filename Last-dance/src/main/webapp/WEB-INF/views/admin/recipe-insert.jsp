<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="mt-5 col-6 offset-3">
<div>
	<h3>레시피등록</h3>
</div>

<form action="write" method="post" class="recipe-insert-form" autocomplete="off">

<div>
	레시피 제목 <input type="text" name="recipeTitle">
</div>

<div>
	레시피 소개 <input type="text" name="recipeInfo">
</div>

<div>
	레시피 정보 시간 <select name="recipeTime">
		<option value="">시간</option>
		<c:forEach var="i" begin="5" step="5" end="115">
			<option value="${i}">${i}분</option>
		</c:forEach>
		<option value="120">120분 이상</option>
	</select>
	난이도 <select name="recipeDifficulty">
	    <option value="">난이도</option>
	    <option value="쉬워요">쉬워요</option>
	    <option value="보통이에요">보통이에요</option>
	    <option value="어려워요">어려워요</option>
	</select>
</div>

<div>
	<i class="fa-regular fa-lightbulb"></i>음식의 재료를 입력해주세요.
</div>

<div>
	<input type="text" class="input-ingredient" placeholder="재료">
	<button type="button" class="difficulty-clear">모두 지우기</button>
</div>

<div class="search-ingredient"></div>
<div class="add-ingredient"></div>

<div>
	요리 순서
</div>
<div>
	<i class="fa-regular fa-lightbulb"></i>요리의 맛이 좌우될 수 있는 중요한 부분은 빠짐없이 적어주세요.
</div>

<div>
	<textarea readonly rows="4" cols="100">
	예) 10분간 익혀주세요       10분간 약한불로 익혀주세요.
	      마늘편은 익혀주세요        마늘편은 충분히 익혀주셔야 매운 맛이 사라집니다.
	      꿀을 조금 넣어주세요         꿀이 없는 경우, 설탕 1스푼으로 대체 가능합니다.
	</textarea> 
</div>

<c:forEach var="no" begin="0" end="9">
	<div class="content-page">
		Step<fmt:formatNumber value="${no+1}" minIntegerDigits="2"/> 
		<textarea name="recipeContentText"></textarea>
		<input type="file" class="file-input" accept=".jpg, .png, .gif">
		<img class="preview" src="https:/via.placeholder.com/200x200" width="200" height="200"><br>
		<label class="step-plus-btn"><button type="button"><i class="fa-solid fa-plus"></i></button> 순서 추가</label>
		<label class="step-minus-btn"><button type="button"><i class="fa-solid fa-minus"></i></button> 순서 삭제</label>
	</div>
</c:forEach>

<div>
	요리 완성사진 
	<button type="button">사진 한 번에 넣기</button>
	<button type="button">사진 모두 지우기</button>
	<br>
	<c:forEach var="no" begin="1" end="4">
		<div class="thumb-page">
			<input type="file" class="file-input" accept=".jpg, .png, .gif">
			<img class="preview" src="https:/via.placeholder.com/200x200" width="200" height="200">
		</div>
	</c:forEach>
</div>

<div>
	요리 해시태그 
	<select name="recipeHashtag">
		<option value="">해시태그</option>
		<c:forEach var="hashtagDto" items="${hashtagList}">
			<option>${hashtagDto.hashtagName}</option>
		</c:forEach>
	</select>
</div>

<div class="col-10 offset-1">
	<button class="col-5 btn btn-md text-lg btn-warning recipe-insert-btn" type="submit">레시피 등록하기</button>
	<button class="col-5 btn btn-md text-lg btn-warning recipe-return-btn" type="button">돌아가기</button>
</div>

</form>
</div>

<!-- <div class="modal" tabindex="-1"> -->
<!-- 	<div class="modal-dialog modal-dialog-centered"> -->
<!-- 		<div class="modal-content"> -->
<!-- 			<div class="modal-header"> -->
<!-- 				<h5 class="modal-title">Modal title</h5> -->
<!-- 				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> -->
<!-- 			</div> -->
<!-- 			<div class="modal-body"> -->
<!-- 				<p>Modal body text goes here.</p> -->
<!-- 			</div> -->
<!-- 			<div class="modal-footer"> -->
<!-- 				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button> -->
<!-- 				<button type="button" class="btn btn-primary">Save changes</button> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->

<script type="text/javascript">
    $(function(){
    	/* 레시피 돌아가기 클릭 시 비동기로 첨부파일 삭제 */
    	$(".recipe-return-btn").click(function(e){
    		var param = $(".recipe-insert-form .img-no").serialize();
    		console.log(param);
    		$.ajax({
    			url: "http://localhost:8888/rest/attachment/delete?"+param,
    			method: "delete",
    			success: function(resp){
    				history.back();
    			}
    		});
    	});
    	
    	/* 레시피 등록 우선 비활성화 */
    	$(".recipe-insert-form").submit(function(e){
//     		var choice = confirm("등록하시겠습니까?");
//     		if(!choice){
	    		e.preventDefault();
//     		}	
    	});

    	/* 레시피 등록 시 빈칸 삭제 구현 중 */
    	$(".recipe-insert-btn").click(function(){
			var contentText = $("[name=recipeContentText]");
			var contentImg = $(".content-page").find(".file-input");
			
			//레시피 컨텐트 아예 없을 때 리턴
			var contentCnt = 0;
			var contentImgCnt = 0;
			for(var i=0; i<contentText.length; i++){
				if(contentText.eq(i).text()){
					contentCnt++;
				}
				if(contentImg.eq(i).val()){
					contentImgCnt++;
				}
			}
			if(contentCnt == 0 && contentImgCnt == 0){
				alert("레시피 내용을 등록해주세요.");
				return;
			}
			
			//레시피 썸네일 아예 없을 때 리턴
			var recipeImg = $(".thumb-page").find(".file-input");
			var recipeImgCnt = 0;
			for(var i=0; i<recipeImg.length; i++){
				if(recipeImg.eq(i).val()){
					recipeImgCnt++;	
				}
			}
			if(recipeImgCnt == 0){
				alert("레시피 썸네일을 지정해주세요.");
				return;
			}
			
    		//레시피 컨텐트 빈칸 확인 및 삭제
// 			for(var i=0; i<contentText.length; i++){
				
// 				if(!contentText.eq(i).text() && !contentImg.eq(i).val()){
// 					for(var j=i+1; j<contentText.length-i; j++){
// 						if(contentText.eq(j).text() || contentImg.eq(j).val()){
// 							/* 모달 구현하기 */
// 							alert("레시피 내용은 순서대로 입력해주세요.");
// 							return;
// 						}
// 						else{
// 							contentImg.eq(i).parent().remove();
// 						}
// 					}
// 				}
// 				else if(!contentText.eq(i).text() || !contentImg.eq(i).val()){
// 					/* 모달 구현하기 */
// 					alert("레시피 내용 사진 또는 내용을 추가해주세요.");
// 					return;
// 				}
// 			}
			
			//레시피 썸네일 빈칸 삭제
			for(var i=0; i<recipeImg.length; i++){
				if(!recipeImg.eq(i).val()){
					recipeImg.eq(i).parent().remove();
				}
			}
    	});
    	
    	/* 다시 확인하기 */
        $(".recipe-insert-btn").click(function(){
			var contentText = $("[name=recipeContentText]");
			var contentImg = $(".content-page").find(".file-input");
            //레시피 컨텐트 빈칸 확인 및 삭제
            var textCnt = 0;
            var imgCnt = 0;
			for(var i=0; i<contentText.length; i++){
				if(contentText.eq(i).val()){
                    textCnt++;
                }
                if(contentImg.eq(i).val()){
                    imgCnt++;
                }

                if(textCnt != imgCnt){
                    alert("레시피 내용 또는 사진을 등록해주세요.");
                    return;
                }
			}
            for(var j=textCnt; j<contentText.length; j++){
                contentText.eq(j).parent().remove();
            }
        });
    	
    	/* 레시피 내용 블러 시 textarea 안에 값 넣어주기 */
    	$("[name=recipeContentText]").blur(function(){
    		$(this).text($(this).val());
    	});
    	
    	/* 재료 입력 비동기 불러오기 */
    	$(".input-ingredient").on("input", function(){
            setTimeout(() => {
                var search = $(".input-ingredient").val();
                if(search == ""){
                    $(".ingredientSearch").remove();
                }
                else{
                    $.ajax({
                        url: "http://localhost:8888/rest/ingredient/"+search,
                        method: "get",
                        success: function(resp){
                            $(".ingredientSearch").remove();
                            for(var i=0; i<resp.length; i++){
                                var pTag = $("<p>")
                                    .addClass("ingredientSearch")
                                    .text(resp[i]);
                                
                                pTag.click(function(){
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

    	/* 재료 엔터 등록 */
    	$(".input-ingredient").keydown(function(e){
    		if(e.keyCode == 13) {
	    		$(".ingredientSearch").remove();
	    		var search = $(this).val();
				var xMark = $("<i>").addClass("fa-solid fa-xmark");
				xMark.click(function(){
					$(this).parent().remove();
				});
				var p = $("<p>")
				var input = $("<input>")
					.attr("readonly", "readonly")
					.attr("name", "recipeIngredientName")
					.val(search);
				p.append(input).append(xMark);
				$(".add-ingredient").append(p);
				$(this).val("");
    		}
    	});
    	
    	/* 전체 삭제 클릭 시 등록된 재료 전부 삭제 */
    	$(".difficulty-clear").click(function(){
    		$("[name=recipeIngredientName]").parent().remove();
    	});
    	
    	/* 순서 추가 버튼 클릭 시 다음 단계 등록 영역 생성 */
    	$(".step-plus-btn").last().remove();
    	$(".step-minus-btn").first().remove();
    	$(".content-page").hide();
    	$(".content-page").first().show();

    	$(".step-plus-btn").click(function(){
    		var contentText = $(this).parent().find("[name=recipeContentText]").val();
    		var contentImg = $(this).parent().find(".file-input").val();
    		if(!contentText || !contentImg){
    			alert("레시피 내용은 순서대로 등록해주세요.");
    			return;
    		}
    		$(this).hide();
    		$(this).next().hide();
    		$(this).parent().next().show();
    	});
    	$(".step-minus-btn").click(function(){
    		var contentText = $(this).parent().find("[name=recipeContentText]");
    		var contentImg = $(this).parent().find(".file-input");
    		if(contentText.val() || contentImg.val()){
    			var choice = confirm("작성한 내용은 저장되지 않습니다. 삭제하시겠습니까?");
    			if(!choice){
    				return;
    			}
    		}
			contentText.val("");
			contentImg.val("");
			$(this).parent().find(".preview").attr("src", "https:/via.placeholder.com/200x200");
			$(this).parent().find("[name=recipeContentAttachmentNo]").remove();
    		$(this).parent().prev().find(".step-plus-btn").show();
    		$(this).parent().prev().find(".step-minus-btn").show();
    		$(this).parent().hide();
    	});

    	/* 이미지 업로드 비동기 후 미리보기 구현 */
        $(".file-input").change(function(){
        	var that = $(this);
            if(this.files.length > 0){
                var fd = new FormData();
                fd.append("attach", this.files[0]);
                $.ajax({
                    url: "http://localhost:8888/rest/upload",
                    method: "post",
                    data: fd,
                    processData: false,
                    contentType: false,
                    success: function(resp){
                    	that.next().attr("src", resp);
                    	var attachmentNo = parseInt((resp.split("download/"))[1]);
                    	if(that.parent().attr("class") == "thumb-page"){
	                    	var imgNo = $("<input>").attr("type", "hidden").addClass("img-no").attr("name", "recipeAttachmentNo").val(attachmentNo);
                    	}
                    	if(that.parent().attr("class") == "content-page"){
	                    	var imgNo = $("<input>").attr("type", "hidden").addClass("img-no").attr("name", "recipeContentAttachmentNo").val(attachmentNo);
                    	}
						that.parent().append(imgNo);
                    }
                });
            }
            else{
                $(".preview").attr("src", "https:/via.placeholder.com/240x180");
            }
        });
    	
    	/* 돌아가기 클릭 시 이미지 비동기 삭제 */
    });
</script>
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>