<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="mt-3">&nbsp;</div>
<div class="mt-3">&nbsp;</div>

<div class="text-end">
	<a class="main-page-link"></a> > 
	<a class="text-dark" href="detail/+${noticeDto.noticeNo}">공지사항</a> 
	> 등록하기
</div>

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
			<a class="col-4 offset-1 btn btn-md rounded yellow-btn" 
				href="detail/${noticeNo}">등록한 공지글 보러가기</a>
			<a class="col-4 offset-1 btn btn-md rounded yellow-btn" 
				href="list">공지사항 리스트로 가기</a>
		</div>
	</div>
        
</div>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>