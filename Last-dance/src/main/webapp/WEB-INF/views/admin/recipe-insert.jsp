<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<h3>레시피등록</h3>

<form action="write" method="post">

<input type="hidden" name="recipeNick" value="${loginNick}"><br>
레시피 이름 : <input type="text" name="recipeTitle"><br>
레시피 제목 : <input type="text" name="recipeInfo"><br>
소요시간 : <input type="text" name="recipeTime"><br>
해시태그 : 
<select name="recipeHashtag">
	<option value="">선택</option>
	<option disabled>--------</option>
	<c:forEach var="hashtagDto" items="${hashtagList}">
		<option>${hashtagDto.hashtagName}</option>
	</c:forEach>
</select><br>
재료 :  
대분류 - <select class="select-cate">
	<option value="">선택</option>
	<option disabled>--------</option>
	<c:forEach var="cate" items="${cateList}">
		<option>${cate}</option>
	</c:forEach>
</select>
중분류 - <select name="recipeIngredientName" class="result-ingredient">
	<option value="">선택</option>
	<option disabled>--------</option>
</select><br>
난이도 : <select name="recipeDifficulty">
    <option value="">선택</option>
    <option disabled>--------</option>
    <option value="쉬워요">쉬워요</option>
    <option value="보통이에요">보통이에요</option>
    <option value="어려워요">어려워요</option>
</select><br>
레시피 썸네일 : <input type="file" class="file-thumb-input" accept=".jpg, .png, .gif"><br>
<img class="preview" src="https:/via.placeholder.com/240x180" width="240" height="180"><br>
레시피 소개 : <input type="text" name="recipeContentText"><br>
<input type="file" class="file-input" accept=".jpg, .png, .gif">
<br>
<img class="preview" src="https:/via.placeholder.com/240x180" width="240" height="180">

</form>

<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
    $(function(){
    	/* 레시피 대분류 선택 시 중분류 출력 */
		$(".select-cate").on("input", function(){
			$(".result-ingredient").find("[data-cate=cate]").remove();
			var ingredientCategory = $(this).val();
			
			$.ajax({
				url: "http://localhost:8888/rest/ingredient/"+ingredientCategory,
				method: "get",
				success: function(resp){
					for(var i=0; i<resp.length; i++){
						var option = $("<option>").text(resp[i]).attr("data-cate", "cate");
						$("[name=recipeIngredientName]").append(option);
					}
				}				
			});
			
		});
    	
    	/* 상태객체 true이면 form 활성화 시킬 예정 */
        var recipeStatus = {
            recipeTitleStatus : false,
            recipeInfoStatus : false, 
            recipeTimeStatus : false, 
            recipeHashtagStatus : false
        };

    	/* 소요시간 양수 아닌 값 적으면 리턴 */
        $("[name=recipeTime]").blur(function(){
            // console.log($(this).val());
            var recipeTime = $(this).val();
            if(recipeTime == "") return;
            var regex = /^[0-9]+$/;
            var judge = regex.test(recipeTime);
            if(!judge || recipeTime < 0){
                alert("정확한 시간을 기입해주세요.");
                $(this).val("");
            }
        });
    	
    	/* 파일 업로드 비동기 처리 구현 중.. */
        $(".file-input").change(function(){
            if(this.files.length > 0){
                // 프론트엔드에서 미리보기만 가능하며 향후에 관리가 안 됨
                var obj = URL.createObjectURL(this.files[0]);
                $(".preview").attr("src", obj);

                // 서버에 비동기로 파일을 업로드하는 코드(ajax를 이용해서 multipart 전송 구현)
                // - 반드시 contentType과 processData를 false로 설정해야 한다.
                // - FormData 객체를 만들어 전송할 내용을 담아서 data에 설정한다.
                
//                 var fd = new FormData();
//                 // fd.append("이름", 데이터);
//                 fd.append("attach", this.files[0]);//attach라는 이름으로 파일을 첨부한다.
//                 console.log(fd);

//                 $.ajax({
//                     url: "http://localhost:8888/rest/upload",
//                     method: "post",
//                     data: fd,
//                     //jquery에서는 multipart 요청을 위해 다음 설정 2가지를 반드시 작성해야한다.
//                     processData: false,
//                     contentType: false,
//                     success: function(resp){
//                         console.log(resp);
//                         $(".preview").attr("src", resp);
//                     }
//                 });
//             }
//             else{
//                 // console.log("파일 선택 취소");
//                 $(".preview").attr("src", "https:/via.placeholder.com/240x180");
            }
        });
    });
</script>
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>