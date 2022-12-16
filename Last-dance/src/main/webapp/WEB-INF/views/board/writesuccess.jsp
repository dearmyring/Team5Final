<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
<div class="container-fluid mt-5">

	<div class="row mt-5">
		<div class="col-lg-4 offset-lg-4 col-md-6 offset-md-3 col-sm-8 offset-sm-2">
			<img class="w-100" src="${pageContext.request.contextPath}/images/logo.png"/>
		</div>
	</div>
		
	<div class="row mt-4">
		<div class="col-lg-4 offset-lg-4 col-md-6 offset-md-3 col-sm-8 offset-sm-2">
			<h2 class="text-center">공지글이 등록되었습니다.</h2>
		</div>
	</div>
	      
	<div class="row mt-4">
		<div class="text-center col-lg-4 offset-lg-4 col-md-6 offset-md-3 col-sm-8 offset-sm-2">
			<a class="col-4 offset-1 btn btn-md rounded btn-warning" 
				href="detail?boardNo=${boardDto.boardNo}">등록한 게시판 보러가기</a>
			<a class="col-4 offset-1 btn btn-md rounded btn-warning" 
				href="list">공지사항 리스트로 가기</a>
		</div>
	</div>
        
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>