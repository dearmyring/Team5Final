<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="mt-5">&nbsp;</div>
<h3>공지사항 작성</h3>
<form class="notice-insert-form" action="write" method="post" autocomplete="off">
<input type="text" name="noticeTitle">
<textarea name="noticeContent" placeholder="내용을 입력하세요."></textarea>
<button class="notice-insert-btn" type="submit">등록하기</button>
<button class="return-btn" type="button">돌아가기</button>
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
		
		/* 빈칸 제출 방지 */
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