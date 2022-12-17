<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
<div class="mt-5">&nbsp;</div>

<div class="text-end">
	<a class="main-page-link"></a> > <a class="text-decoration-none text-dark" href="../list">레시피</a> > 상세보기
</div>

<div class="container-fluid mt-5">
<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		${recipeDto.recipeTitle}
	</div>
</div>
<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<c:forEach var="recipeImg" items="${recipeImgList}">
			<img src="${pageContext.request.contextPath}/rest/download/${recipeImg}" width="200">
		</c:forEach>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		${recipeDto.recipeInfo}
	</div>
</div>
<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		${recipeDto.recipeNick}
	</div>
</div>
<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<c:choose>
			<c:when test="${recipeDto.recipeTime != 120}">
				${recipeDto.recipeTime}분
			</c:when>
			<c:otherwise>
				${recipeDto.recipeTime}분 이상
			</c:otherwise>
		</c:choose>
	</div>
</div>
<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		${recipeDto.recipeDifficulty}
	</div>
</div>
<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		${recipeDto.recipeHashtag}
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<c:forEach var="recipeContentDto" items="${recipeContentList}">
			<div class="row mt-3">
				<div class="col-4">
					<img src="${pageContext.request.contextPath}/rest/download/${recipeContentDto.recipeContentAttachmentNo}" width="200" height="200">
				</div>
				<div class="col-8">
					${recipeContentDto.recipeContentText}
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<c:forEach var="recipeIngredientDto" items="${recipeIngredientList}">
			${recipeIngredientDto}
		</c:forEach>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-6 text-end">
				<a class="delete-btn btn btn-md btn-light" href="../delete/${recipeDto.recipeNo}">삭제하기</a>
			</div>
			<div class="col-6">
				<a class="btn btn-md yellow-btn" href="../update?recipeNo=${recipeDto.recipeNo}">수정하기</a>
			</div>
		</div>
	</div>
</div>

</div>

<script type="text/javascript">
    $(function(){
    	$(".delete-btn").click(function(e){
    		
    		var choice = confirm("정말 삭제하시겠습니까?");
    		if(!choice){
    			e.preventDefault();
    		}
    	});
    });
</script>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>