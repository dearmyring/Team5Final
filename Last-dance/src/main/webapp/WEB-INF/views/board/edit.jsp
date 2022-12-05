<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="자유 게시판" name="title"/>
</jsp:include>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script>
	$(function(){
		$("[name=boardContent]").summernote({
			height:300,
			minHeight:300,
		});
	});
</script>

<form action="edit" method="post" enctype="multipart/form-data">
<input type="hidden" name="boardNo" value="${boardDto.boardNo}">
<%-- 답글이라면 부모글번호를 추가로 전송하도록 처리 --%>
<c:if test="${isReply}">
	<input type="hidden" name="boardParent" 
									value="${param.boardParent}">
</c:if>

<div class="container-800 mt-40">
	<div class="row center">
		<c:set var="isReply" value="${param.boardParent != null}"></c:set>
		<c:choose>
			<c:when test="${isReply}">
				<h1>답글 작성</h1>
			</c:when>
			<c:otherwise>
				<h1>게시글 작성</h1>
			</c:otherwise>
		</c:choose>
	</div>
	
	<div class="row left">
		<label>제목</label>
		<input class="input w-100" type="text" required value="${boardDto.boardTitle}" name="boardTitle" required>
	</div>
	
	<div class="row left">
		<label>내용</label>
		<textarea name="boardContent"></textarea>
	</div>
	
	<div class="row left">
		<label>첨부파일(1개당 1MB. 최대 10MB 가능)</label>
		<input class="input w-100" type="file" name="attachment" multiple>
	</div>
	
	<div class="row right">
		<a class="btn btn-neutral" href="list">목록으로</a>
		<button class="btn btn-positive" type="submit">등록하기</button>
	</div>
</div>

</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</form>