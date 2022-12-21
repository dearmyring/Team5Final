<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="mt-3">&nbsp;</div>
<div class="mt-3">&nbsp;</div>

<div class="history-link text-end">
	<a class="main-page-link"></a> <i class="fa-solid fa-chevron-right"></i> 
	<a href="list">공지사항</a> <i class="fa-solid fa-chevron-right"></i> 작성하기
</div>

<div class="container-fluid mt-5">

<form class="notice-insert-form" action="write" method="post" autocomplete="off">

<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-2">
				제목
			</div>
			<div class="col-10">
				<input class="w-100" type="text" name="noticeTitle">
			</div>
		</div>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-2">
				내용
			</div>
			<div class="col-10">
				<textarea class="w-100" name="noticeContent" placeholder="내용을 입력하세요."></textarea>
			</div>
		</div>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-6 text-end">
				<button class="return-btn btn btn-md btn-light" type="button">돌아가기</button>
			</div>
			<div class="col-6">
				<button class="notice-insert-btn btn btn-md yellow-btn" type="submit">등록하기</button>
			</div>
		</div>
	</div>
</div>

</form>

</div>

<script type="text/javascript">
	$(function(){
		/* 빈칸 제출 방지 */
		$(".notice-insert-form").submit(function(e){
			var noticeTitle = $("[name=noticeTitle]").val();
			var noticeContent = $("[name=noticeContent]").val();
			if(noticeTitle && noticeContent){
				var choice = confirm("등록하시겠습니까?");
				if(!choice){
					e.preventDefault();
				}
			}
			else{
				alert("게시글을 작성해주세요.");
				return false;
			}
		});
	});
</script>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>