
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="레시피리스트" name="title"/>
</jsp:include>

	<!-- 글꼴 Noto Sans Korean -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

    <!-- css 파일 -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/commons.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/commons-ring-join.css">

    <!-- 폰트어썸 -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>

    <!-- jquery 사용 위한 라이브러리 파일 불러옴 -->
    <script src="https://code.jquery.com/jquery-3.6.1.js"></script>

    <!-- js 파일 -->
    <script src="${pageContext.request.contextPath}/js/header.js"></script>

<style>
 .image.image-hover:hover {
 border: 1px solid gray;
 }
  .container{
  display: flex;  
 }
 .container .item{
 width : 300px;
 height : 450px;
  background: lightgray;
  
 }
 .aaa{
 text-align : left; 

 }
</style>
<div class = "container-1300">
	<div class = "row center">
		<h1>${loginNick}님이 당장 할 수 있는 요리를 추천해드릴게요</h1>
	</div>
		
		
	
		<div class="container-350" >
		<c:forEach var = "recipeListVO" items = "${recipeList}">		
			<div class="item">		
			<div class="list">
			 <div>조회수:${recipeListVO.recipeDto.recipeClick} 좋아요:${recipeListVO.recipeDto.recipeLike}</div>	
		            <c:forEach var="recipeImg" items="${recipeListVO.recipeImgList}">
		                 <img class="image image-hover" width="300px" height="300px" src="${pageContext.request.contextPath}/rest/download/${recipeImg.recipeAttachmentNo}"/>
		            </c:forEach>
		            
					<div>${recipeListVO.recipeDto.recipeNo}</div>
					<div>
					<a href = "detail?recipeNo=${recipeListVO.recipeDto.recipeNo}">${recipeListVO.recipeDto.recipeHashtag}</a>
					</div>
					<c:forEach var="ingredient" items="${recipeListVO.recipeIngredientList}">
		                 <span>${ingredient.recipeIngredientName}</span>
		            </c:forEach>
		           
					<div>닉네임 : ${recipeListVO.recipeDto.recipeNick}</div>		
					<div>작성시간 :${recipeListVO.recipeDto.recipeWritetime}</div>		
					</div>	
				</div>
					</c:forEach>
		</div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

  


