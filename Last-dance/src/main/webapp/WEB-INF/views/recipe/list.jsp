<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet" />

<link rel="stylesheet" type="text/css" href="reset.css" />
<link rel="stylesheet" type="text/css" href="commons.css" />

<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
<link rel="stylesheet" type="text/css" href="test.css" />

<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="레시피 리스트" name="title" />
</jsp:include>

<style>
/*
                  Flextbox 특징
                  1. flex 설정은 개별 항목이 아닌 영역에 한다
                  2. 배치 방향을 flex-direction 속성으로 지정할 수 있다
                  3. 폭을 지정하지 않으면 자동으로 비율로 할당되게 구현할 수있다
                      - flex-grow 속성
                  4. 줄바꿈 허용/불가를 flex-wrap 속성으로 설정할 수 있다
                  5. 정렬기준을 손쉽게 설정할 수 있다
                      - justify-content로 내부 항목의 가로 배치 형식을 설정할 수 있다
                      - align-items로 내부 항목의 세로 배치 형식을 설정할 수 있다
                  6. 내부 항목들의 배치 순서를 변경할 수 있다(개별 설정)
                      - order 속성
              */
.layout {
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
	display: flex;
	flex-wrap: wrap gap: 1em;
}
article {
	flex-basis: 1100px;
	flex-grow: 1;
	flex-shrink: 1;
}

.flexbox {
	display: flex;
	flex-wrap: wrap;
	flex-direction: row;
	gap: 1em;
	/*background-color: #f0f0f0;*/
	justify-content: center;
}

.recipe-recommend{
    display: flex;
    flex-direction: row;
    height: 70px;
}

.recipe-recommend-text{
	font-size: 30px;
	font-weight: 600;
	margin: 0 50px;
}

.recipe-box-shadow {
    box-shadow: 0px 0px 30px 0px rgb(0 0 0 / 10%);
    border-radius: 10px;
    margin-bottom: 40px;
}

.ingredient-box {
    min-height: 100px;
}

.item {
	min-height: 200px;
	flex-shrink: 1;
	flex-grow: 1;
	position: relative;
}

.img-thumnail {
	width: 320px;
    height: 230px;
    object-fit: cover;
}

.img-box {
	position: relative;

}

.info-box{
	height: 240px;
	width: 320px;
	padding: 15px;
}

.hash-tag {
    position: absolute;
    top: 20px;
    left: 20px;
	font-size: 15px;
	padding: 0.5em 0.8em 0.5em 0.8em;
	display: inline-block;
	text-align: center;
	text-decoration: none;
	border-radius: 10px;
	color: #373A3C;
	background-color: #EEEEEE;
}

.hashtag-box {
	left: 20px;
	display: inline-block;
	border: none;
	background-color: #8BC96E;
	text-align: center;
	padding: 0.5em 0.8em 0.5em 0.8em;
	border-radius: 7px;
	font-weight: 600;
	color: white;
	font-size: 13px;
}

.how-long {
	display: inline-block;
	border: none;
	background-color: #EDEDED;
	text-align: center;
	padding: 0.5em 0.8em 0.5em 0.8em;
	border-radius: 7px;
	font-weight: 600;
	color: #757575;
	font-size: 13px;
}

.cooking-level {
	display: inline-block;
	border: none;
	background-color: #ECBE42;
	text-align: center;
	padding: 0.5em 0.8em 0.5em 0.8em;
	border-radius: 7px;
	font-weight: 600;
	color: white;
	font-size: 13px;
	margin: 0 3px;
}

.recipe-title {
	color: #373A3C;
	font-size: 23px;
	font-weight: bold;
	/*	height: 60px; */
	padding: 10px;
}

.view-count, .like-count {
	margin: 10px;
	font-size: 13px;
	color: #757575;
}

.like-count {
	left: 30px;
}

.img-box {
	top: 0px;
	left: 0px;
	width: 100%;
    height: 240px;
	border-radius: 10px 10px 0 0;
	overflow: hidden;
}

.simple-info{
margin 0 20px;
}

.float-margin-left{
	float: left;
    margin-left: 50px;
}

.sort-select{
padding: 10px;
}

.w-80 {
    width:80%;
}

.w-20 {
    width:20%;
}

</style>
</head>
<body>
	<div class="layout">
		<article>
			<div class="recipe-recommend">			
				<div class="recipe-recommend-text w-80">${loginNick}님이 당장 할 수 있는 요리를 추천해드릴게요.</div>
				<div class= "sort-select w-20">
					<select class="sort-click">
						<option value="recipe_no desc">최근 작성일 순</option>
						<option value="recipe_click desc">조회수 높은 순</option>
						<option value="recipe_like desc">좋아요 많은 순</option>
						<option value="recipe_time asc">조리시간 짧은 순</option>
						<option value="recipe_time desc">조리시간 긴 순</option>
					</select>
				</div>
			</div>

			<div class="flexbox">
				<div class="item float-container">
					<c:forEach var="recipeListVO" items="${recipeList}">
						<div 	class="add-recipe-box recipe-box-shadow main-1 container-320 float-margin-left">
						
							<div class="img-box">
								<div class="hash-tag">${recipeListVO.recipeDto.recipeHashtag}</div>
								<c:forEach var="recipeImg" begin="0" end="0" step="1" items="${recipeListVO.recipeImgList}">
									<img class="img-thumnail"
										src="${pageContext.request.contextPath}/rest/download/${recipeImg.recipeAttachmentNo}">
								</c:forEach>
							</div>

							<div class="info-box">
								<span class="view-count">조회수
									${recipeListVO.recipeDto.recipeClick}</span> <span class="like-count">좋아요
									${recipeListVO.recipeDto.recipeLike}</span>
								<div class="recipe-title">${recipeListVO.recipeDto.recipeTitle}</div>
								<div class="simpe-info">
								<div class="how-long">
									<i class="fa-regular fa-clock"></i>
									${recipeListVO.recipeDto.recipeTime}분 이내
								</div>
								<div class="cooking-level">충분 불충분</div>
								<div class="cooking-level">${recipeListVO.recipeDto.recipeDifficulty}</div>
								</div>
								<div class="ingredient-box">
								<c:forEach var="ingredient" items="${recipeListVO.recipeIngredientList}">
									<div class="hashtag-box mt-10"> ${ingredient.recipeIngredientName}</div>
								</c:forEach>
							</div>
							</div>							
						</div>
					</c:forEach>
				</div>
			</div>
		</article>
	</div>
</body>
</html>

<script type="text/javascript">
    $(function(){
    	/* 레시피 검색창에서 엔터치면 검색 */
    	$(".input-keyword").keydown(function(e){
    		if(e.keyCode == 13) {
    			$(".recipe-search-btn").click();
    		}
   		});
   	 	
    	/* 레시피 리스트 정렬 */
		$(".sort-click").on("input", function(){
			var sort = $(this).val();
			$.ajax({
				url: "http://localhost:8888/rest/recipe",
				method: "post",
				contentType: "application/json",
				data: JSON.stringify({
					sort: sort
				}),
				success: function(resp){
					$(".recipe-list").find("tr").remove();
					for(var i=0; i<resp.length; i++){
						var tr = $("<tr>");
						var check = $("<input>").addClass("check-item").attr("name", "recipeNo").val(resp[i].recipeNo).attr("type", "checkbox");
						var tdCheck = $("<td>").append(check);
						var tdNo = $("<td>").text(resp[i].recipeNo);
						var tdTitle = $("<td>").append($("<a>").attr("href", "detail/"+resp[i].recipeNo).text(resp[i].recipeTitle));
						var tdTime = $("<td>").text(resp[i].recipeTime+'분');
						var tdNick = $("<td>").text(resp[i].recipeNick);
						tr.append(tdCheck).append(tdNo).append(tdTitle).append(tdTime).append(tdNick);
						$(".recipe-list").append(tr);
					}
				}
			});
		});    	
</script>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>


