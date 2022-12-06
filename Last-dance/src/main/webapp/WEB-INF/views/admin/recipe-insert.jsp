<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<h3>레시피등록</h3>

<form action="write" method="post">

<input type="hidden" name="recipeNick" value="${loginNick}">
레시피 제목 <input type="text" name="recipeTitle">
<br>
레시피 소개 <input type="text" name="recipeInfo">
<br>
소요시간 <select name="recipeTime">
	<option value="">시간</option>
	<c:forEach var="i" begin="5" step="5" end="115">
		<option value="i">${i}분</option>
	</c:forEach>
	<option value="120">120분 이상</option>
</select>
<br>
난이도 <select name="recipeDifficulty">
    <option value="">난이도</option>
    <option value="쉬워요">쉬워요</option>
    <option value="보통이에요">보통이에요</option>
    <option value="어려워요">어려워요</option>
</select>
<button type="button" class="difficulty-clear">모두 지우기</button>
<br>
<i class="fa-regular fa-lightbulb"></i>음식의 재료를 입력해주세요.
<br>
<input type="text" name="recipeIngredientName" placeholder="재료">
<br>
<div class="add-ingredient">

</div>

레시피 썸네일 <input type="file" class="file-thumb-input" accept=".jpg, .png, .gif">
<br>
<img class="preview" src="https:/via.placeholder.com/240x180" width="240" height="180">
<br>
레시피 소개 <input type="text" name="recipeContentText">
<br>
<input type="file" class="file-input" accept=".jpg, .png, .gif">
<br>
<img class="preview" src="https:/via.placeholder.com/240x180" width="240" height="180">
<br>
요리 해시태그 
<select name="recipeHashtag">
	<option value="">해시태그</option>
	<c:forEach var="hashtagDto" items="${hashtagList}">
		<option>${hashtagDto.hashtagName}</option>
	</c:forEach>
</select>

</form>

<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
    $(function(){
//     	$("[name=recipeIngredientName]").on("input", $.throttle(250, function(e) {
//     		console.log($("[name=recipeIngredientName]").val());
//     	}))
    	$("[name=recipeIngredientName]").on("input", setTimeout(function() {
    		console.log($(this).val());
    	}, 250));
    	
    	/* 상태객체 true이면 form 활성화 시킬 예정 */
        var recipeStatus = {
            recipeTitleStatus : false,
            recipeInfoStatus : false, 
            recipeTimeStatus : false, 
            recipeHashtagStatus : false
        };

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