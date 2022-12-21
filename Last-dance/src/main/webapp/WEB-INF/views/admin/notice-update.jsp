<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="mt-3">&nbsp;</div>
<div class="mt-3">&nbsp;</div>

<div class="text-end">
	<a class="main-page-link"></a> > 
	<a class="text-dark" href="detail/+${noticeDto.noticeNo}">공지사항</a> 
	> 수정하기
</div>

<form class="notice-update-form" action="update" method="post" autocomplete="off">
<input type="hidden" name="noticeNo" value="${noticeDto.noticeNo}">

<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<input class="w-100" type="text" name="noticeTitle" value="${noticeDto.noticeTitle}">
	</div>
</div>

<div class="row mt-3">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<textarea class="w-100 h-100" name="noticeContent" placeholder="내용을 입력하세요.">${noticeDto.noticeContent}</textarea>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-6 text-end">
				<button class="return-btn btn btn-md btn-light" type="button">돌아가기</button>
			</div>
			<div class="col-6">
				<button class="notice-update-btn btn btn-md yellow-btn" type="submit">수정하기</button>
			</div>
		</div>
	</div>
</div>

</form>

<script type="text/javascript">
	$(function(){
		/* 상태객체 */
		var validChecker = {
			titleValid : false,
			contentValid : false,
			isAllValid : function(){
				return this.titleVlid && this.contentValid;
			}
		};
		
		$(".notice-insert-form").submit(function(e){
			var noticeTitle = $("[name=noticeTitle]").val();
			var noticeContent = $("[name=noticeContent]").val();
			if(noticeTitle && noticeContent){
				var choice = confirm("등록하시겠습니까?");
				if(choice){
					$(".notice-insert-form").submit;
				}
				else{
					return false;
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