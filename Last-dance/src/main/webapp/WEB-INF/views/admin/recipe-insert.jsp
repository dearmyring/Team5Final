<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="mt-5 col-6 offset-3">
<div>
	<h3>레시피등록</h3>
</div>

<form action="write" method="post">

<div>
	<input type="hidden" name="recipeNick" value="${loginNick}">
	레시피 제목 <input type="text" name="recipeTitle">
</div>

<div>
	레시피 소개 <input type="text" name="recipeInfo">
</div>

<div>
	레시피 정보 시간 <select name="recipeTime">
		<option value="">시간</option>
		<c:forEach var="i" begin="5" step="5" end="115">
			<option value="i">${i}분</option>
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

<c:forEach var="num" begin="1" end="10">
	<div class="content-page">
		Step<fmt:formatNumber value="${num}" minIntegerDigits="2"/> 
		<textarea name="recipeContentText"></textarea>
		<input type="file" class="file-input" accept=".jpg, .png, .gif">
		<img class="preview" src="https:/via.placeholder.com/200x200" width="200" height="200"><br>
		<input type="hidden" name="recipeContentAttachmentNo">
		<label class="step-plus-btn"><button type="button"><i class="fa-solid fa-plus"></i></button> 순서 추가</label>
		<label class="step-minus-btn"><button type="button"><i class="fa-solid fa-minus"></i></button> 순서 삭제</label>
	</div>
</c:forEach>

<div>
	요리 완성사진 
	<button type="button">사진 한 번에 넣기</button>
	<button type="button">사진 모두 지우기</button>
	<br>
	<c:forEach begin="1" end="4">
		<input type="file" class="file-input" accept=".jpg, .png, .gif">
<!-- 		<img class="preview" src="https:/via.placeholder.com/200x200" width="200" height="200"> -->
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
	<button class="col-5 btn btn-md text-lg btn-warning" type="submit">레시피 등록하기</button>
	<button class="col-5 btn btn-md text-lg btn-warning" type="button">돌아가기</button>
</div>

</form>
</div>

<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
    $(function(){
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
                                    console.log($(this));
                                    var xMark = $("<i>").addClass("fa-solid fa-xmark");
                                    xMark.click(function(){
                                        $(this).parent().remove();
                                    });
                                    
                                    var p = $("<p>")
                                        .attr("name", "recipeIngredientName")
                                        .text($(this).text());
                                    p.append(xMark);
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
    		$(".ingredientSearch").remove();
    		var search = $(this).val();
    		if(e.keyCode == 13) {
				var xMark = $("<i>").addClass("fa-solid fa-xmark");
				xMark.click(function(){
					$(this).parent().remove();
				});
				var p = $("<p>")
					.attr("name", "recipeIngredientName")
					.text(search);
				p.append(xMark);
				$(".add-ingredient").append(p);
				$(this).val("");
    		}
    	});
    	
    	/* 전체 삭제 클릭 시 등록된 재료 전부 삭제 */
    	$(".difficulty-clear").click(function(){
    		$("[name=recipeIngredientName]").remove();
    	});
    	
    	/* 순서 추가 버튼 클릭 시 다음 단계 등록 영역 생성 */
    	$(".step-plus-btn").last().remove();
    	$(".step-minus-btn").first().remove();
    	$(".content-page").hide();
    	$(".content-page").first().show();
    	$(".step-plus-btn").click(function(){
    		$(this).hide();
    		$(this).next().hide();
    		$(this).parent().next().show();
    	});
    	$(".step-minus-btn").click(function(){
    		$(this).parent().prev().find(".step-plus-btn").show();
    		$(this).parent().prev().find(".step-minus-btn").show();
    		$(this).parent().hide();
    	});
    	
    	/* 상태객체 true이면 form 활성화 시킬 예정 */
        var recipeStatus = {
            recipeTitleStatus : false,
            recipeInfoStatus : false, 
            recipeTimeStatus : false, 
            recipeHashtagStatus : false
        };

    	/* 파일 업로드 비동기 처리 구현 중.. */
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
                    }
                });
            }
            else{
                $(".preview").attr("src", "https:/via.placeholder.com/240x180");
            }
        });
    });
</script>
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>