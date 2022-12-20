<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	int leng = request.getParameterValues("recipeIngredientName").length;
	pageContext.setAttribute("leng", leng);
%>
<c:set var="leng" value="${leng}"></c:set>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
   href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
   rel="stylesheet" />

<link rel="stylesheet" type="text/css" href="/css/reset.css" />
<link rel="stylesheet" type="text/css" href="/css/commons.css" />
<link rel="stylesheet" type="text/css" href="/css/recipeList.css" />

<link rel="stylesheet" type="text/css"    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />

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
   max-width: 1330px;
   margin: 0 auto;
   padding: 20px;
   display: flex;
   flex-wrap: wrap gap: 1em;
}
article {
   flex-basis: 1250px;
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
    height: 130px;
}

.recipe-recommend-text{
   	font-size: 30px;
   	font-weight: 600;
   	margin: 35px 40px 30px 30px;
}

.recipe-box-shadow {
    box-shadow: 0px 0px 30px 0px rgb(0 0 0 / 10%);
    border-radius: 10px;
    margin-bottom: 60px;
}

.ingredient-box {
    height: 110px;
   overflow: auto;
  }

.item {
   min-height: 200px;
   flex-shrink: 1;
   flex-grow: 1;
   position: relative;
}

.img-thumnail {
   width: 350px;
    height: 240px;
    object-fit: cover;
}

.img-box {
   position: relative;

}

.info-box{
   height: 240px;
   width: 350px;
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

.recipe-enough {
   display: inline-block;
   border: none;
   background-color: #4dd1a7;
   text-align: center;
   padding: 0.5em 0.8em 0.5em 0.8em;
   border-radius: 7px;
   font-weight: 600;
   color: white;
   font-size: 13px;
   margin: 0 3px;
}

.recipe-lack {
   display: inline-block;
   border: none;
   background-color: #ec7e42;
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
   height: 60px;
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
    margin-left: 30px;
    margin-right: 30px;
}

.sort-click{
   font-size: 15px;
    font-weight: 600;
    height: 40;
    color: #373A3C;
    margin: 32px 40px 32px 40px;
    }

.sort-select{
	padding: 10px;
	width: 100px;
}



</style>

</head>
<body>
   <div class="layout">
      <article>
         <div class="recipe-recommend">         
            <div class="recipe-recommend-text w-70">${loginNick}님이 당장 할 수 있는 요리를 추천해드릴게요.</div>
            <div>파라미터: ${leng }</div>
            <div class= "sort-select w-30">
               <select class="input sort-click">
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
               <c:forEach var="recipeListVO" items="${complexSearch}">
               <a href="/recipe/detail?recipeNo=${recipeListVO.recipeListSearchVO.recipeNo}">
                  <div class="list add-recipe-box recipe-box-shadow main-1 container-350 float-margin-left">
                     <div class="img-box">
                        <div class="hash-tag">${recipeListVO.recipeListSearchVO.recipeHashtag}</div>
                        <c:forEach var="recipeImg" begin="0" end="0" step="1" items="${recipeListVO.recipeImgList}">
                           <img class="img-thumnail"
                              src="${pageContext.request.contextPath}/rest/download/${recipeImg.recipeAttachmentNo}">
                        </c:forEach>
                     </div>
                     <div class="info-box">
                        <span class="view-count">조회수 ${recipeListVO.recipeListSearchVO.recipeClick}</span> 
                        <span class="like-count">좋아요 ${recipeListVO.recipeListSearchVO.recipeLike}</span>
                        <div class="recipe-title">${recipeListVO.recipeListSearchVO.recipeInfo}</div>
                        <div class="simpe-info">
	                        <div class="how-long">
	                           <i class="fa-regular fa-clock"></i>
	                           ${recipeListVO.recipeListSearchVO.recipeTime}분 이내
	                        </div>
	                        <c:choose>
	                        	<c:when test="${fn:length(recipeListVO.recipeIngredientList) < leng}">
		                        	<div class="cooking-level">재료가 충분</div>
	                        	</c:when>
	                        	<c:otherwise>
		                        	<div class="cooking-level">간당간당하네</div>
	                        	</c:otherwise>
	                        </c:choose>
                        </div>
                        <div class="ingredient-box scroll">
	                        <c:forEach var="ingredient" items="${recipeListVO.recipeIngredientList}">
	                           <div class="hashtag-box mt-10">${ingredient.recipeIngredientName}</div>
	                        </c:forEach>
	                        <div class="hashtag-box mt-10">${fn:length(recipeListVO.recipeIngredientList)}</div>
                     	</div>
                     </div>                     
                  </div>
                  </a>
               </c:forEach>
            </div>
         </div>
      </article>
   </div>
   
   		<div class="row center">
		<ul class="pagination">
			<!-- 이전 -->
			<c:choose>
				<c:when test="${not recipeListSearchVO.isFirst()}"> <!-- 맨 처음 페이지가 아니라면  -->
					<li><a href="list?p=${noticeListSearchVO.firstBlock()}&${noticeListSearchVO.parameter()}">&laquo;</a></li> <!-- 첫번째 페이지로 이동  -->
				</c:when>
				<c:otherwise> <!-- 그렇지 않으면  -->
					<li><a href="">&laquo;</a></li> <!-- 페이지 변화 없음  -->
				</c:otherwise>
			</c:choose>
			
			<!-- 이전 구간의 마지막 페이지로 이동 -->			
			<c:choose>
				<c:when test="${noticeListSearchVO.hasPrev()}"> <!-- 이전 페이지가 없다면-->	
					<li><a href="list?p=${noticeListSearchVO.prevBlock()}&${noticeListSearchVO.parameter()}">&lt;</a></li> <!-- 이전 구간의 마지막 페이지로 이동-->	
				</c:when>
				<c:otherwise> <!-- 그렇지 않으면  -->
					<li><a href="">&lt;</a></li> <!-- 페이지 변화 없음  -->
				</c:otherwise>
			</c:choose>
			
			<!-- 현재 구간의 페이지 이동 -->
			<!-- 변수명을 i로 하며 시작과 끝은 noticeListSearchVO의 startBlock(), endBlock()의 반환값으로, 간격은 1로 한다  -->
			<c:forEach var="i" begin="${noticeListSearchVO.startBlock()}" end="${noticeListSearchVO.endBlock()}" step="1">
					<a href = "list?p=${i}&${noticeListSearchVO.parameter()}">${i}</a>
			</c:forEach>
			
			<!-- 다음을 누르면 다음 구간의 첫 페이지로 안내 -->
			<c:choose>
				<c:when test="${noticeListSearchVO.hasNext()}"> <!-- 다음페이지가 있으면  -->
					<li><a href="list?p=${noticeListSearchVO.nextBlock()}&${noticeListSearchVO.parameter()}">&gt;</a></li> <!-- 다음 구간의 첫 페이지로 이동  -->
				</c:when>
				<c:otherwise> <!-- 그렇지 않으면  -->
					<li><a href="">&gt;</a></li> <!-- 페이지 변화 없음  -->
				</c:otherwise>
			</c:choose>
			
			<!-- 맨 마지막 페이지로 이동 -->
			<c:choose>
				<c:when test="${not noticeListSearchVO.isLast()}"> <!-- 맨 마지막 페이지가 아니라면 -->
					<li><a href="list?p=${noticeListSearchVO.lastBlock()}&${noticeListSearchVO.parameter()}">&raquo;</a></li> <!-- 맨 마지막 페이지로 이동 -->
				</c:when>
				<c:otherwise>  <!-- 그렇지 않으면  -->
					<li><a href="">&raquo;</a></li> <!-- 페이지 변화 없음  -->
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</body>
</html>

<script type="text/javascript">
          
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
               $(".list").find("a").remove();
               for(var i=0; i<resp.length; i++){
                  var a = $("<a>");
                  var acheck = $("<input>").addClass("check-item").attr("name", "recipeNo").val(resp[i].recipeNo).attr("type", "checkbox");
                  var listCheck = $("<list>").append(check); 
                  var link = $("<a>").addClass("text-decoration-none link-dark")
               .attr("href", "detail/"+resp[i].recipeNo).text(resp[i].recipeTitle);
                  var listThumbnail = $("<td>").addClass("img-thumnail").append(link); /*첨부파일은 파일이아니라 링크? 주소를 가져오는것 주소로 다 가져올수 있음*/
                  var listInfo = $("<list>").append($("<a>").attr("src", "detail/"+resp[i].recipeNo).text(resp[i].recipeInfo));
                  var listClick = $("<list>").text(resp[i].recipeClick);   /*${pageContext.request.contextPath}/rest/download/${recipeImg.recipeAttachmentNo}*/
                  var listLike = $("<list>").text(resp[i].recipeLike);
                  var listTime = $("<list>").text(resp[i].recipeTime+'분');
               /*   var listEnough = $("<list>").text(resp[i].recipeEnough);
                  var listLack = $("<list>").text(resp[i].recipeLack);*/
                  var listDifficulty = $("<list>").text(resp[i].recipeDifficulty);
                  var listIngredient = $("<list>").text(resp[i].recipeIngredientName);
                  list.append(aCheck).append(listThumbnail).append(listInfo).append(listClick).append(listLike).append(listTime)
                  .append(listDifficulty).append(listIngredient);
                  $(".list").append(a);
               }
            }
         });
      });       
</script>

<!-- 썸네일 -->
<!-- 인포 -->
<!-- 조회수 좋아요 -->
<!-- 조리시간 충분불충분(enough/lack) 난이도 -->
<!-- 재료-->



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
