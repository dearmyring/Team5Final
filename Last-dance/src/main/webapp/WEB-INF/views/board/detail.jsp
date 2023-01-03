<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="자유 게시판" name="title"/>
</jsp:include>

<style>
img{
	max-width: 1000px;
	max-height: 1000px;
}
.profile {
    width: 50px;
    height: 50px;
    border-radius: 50%;
}
.reply-border{
	border-bottom : 1px solid lightgray;
	width : 90%;
}
.title-nick{
	margin-bottom: 10px;
}
.heart-color {
    color: red;
}
.btn.btn-positive {
    background-color: #35C5F0;
    color: white;
    font-weight: bold;
}
.btn.btn-positive:hover {
    background-color: #1E90FF;
}
.reply-badge{
width : 10%;
}
.title-badge{
width : 3%;
}
.author {
    font-size: 16px;
    font-weight: bold;
}

	.heart {
		text-decoration: none;
		color:red;
	}
	.attachment-list {
		margin:0;
		padding:0;
		list-style:none;
	}
	
	.contaniner {
		display: flex;
		flex-direction: column;
	}
	
	.title {
    font-size: 20px;
    text-align: left;
    padding-bottom: 5px;
}
	
	.info {
    margin-bottom: 21px;
    width: 100%;
    margin-top: 16px;
}
	
	.other-info {
    display: flex;
    color: #757575;
    margin-top: 15px;
    font-size: 13px;
}
	
	.other-info > li:not(:first-child) {
		margin-left: 20px;
	}
	
	.main {
		margin-top: 50px;
		margin-bottom: 50px;
		text-align: left;
	}
	
	.main > p {
		margin-top: 20px;
	}
	
	.reply-box {
		display: flex;
		justfy-content: center;
		flex-direction: column;
	}
	
	.reply-author {
    width: 30%;
    font-weight: 700;
}
	
	.reply-main {
		width: 40%;
		margin-left: 40px;
	}
	
	.date {
    width: 0%;
    /* margin-left: 17px; */
    font-size: 10px;
    /* margin-top: 1px; */
}
</style>

<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">
//좋아요 비동기
$(function(){
    $(".like-btn").click(function(){

        $(this).toggleClass("fa-solid fa-regular heart-color");
        var url = location.href;
        var boardNo = (url.slice(url.indexOf('=') + 1, url.length));

        var that = $(this);
        $.ajax({
            url: "${pageContext.request.contextPath}/rest/board_like/"+boardNo,
            method: "get",
            success: function(resp) {
             that.next().html(resp);
            }
        });
        // ajax end
    });
});


$(function(){
	loadList();
	
	//목록을 불러오는 함수
	function loadList(){
		$.ajax({
			url:"${pageContext.request.contextPath}/rest/reply/list/${param.boardNo}",
			method:"get",
			success:function(resp) {
				//원래 있던 댓글 삭제
				$(".table-reply-list").empty();//태그는 유지하고 내부를 삭제
				
				//헤더 생성
				var header = $("#reply-list-header").text();
				header = header.replace("{{size}}", resp.length);
				$(".table-reply-list").append(header);
				
				//바디 생성
				var tbody = $("<tbody>");
				$(".table-reply-list").append(tbody);
				
				//현재 resp는 배열이다.
				//미리 댓글 형식을 만들어두고 값만 바꿔치기해서 댓글 목록에 추가하도록 구현
				var loginId = "${loginId}";
				var loginNick = "${loginNick}";
				
				for(var i=0; i < resp.length; i++){
					var reply = resp[i];
					var item = $("#reply-list-item").text();
					var html = $.parseHTML(item);
					
					//html의 내용을 상태에 맞게 수정 또는 제거
					//배지 처리(레벨에 따라 다른 배지가 등장)
					if(reply.memberPoint >= 0 && reply.memberPoint <= 100) {
						$(html).find(".badge").attr("src", "/images/badge-"+reply.memberBadge+".png");
					}
					else if(reply.memberPoint >= 100 && reply.memberPoint <= 300){
						$(html).find(".badge").attr("src", "/images/badge-"+reply.memberBadge+".png");
					}
					else if(reply.memberPoint >= 300 && reply.memberPoint <= 550){
						$(html).find(".badge").attr("src", "/images/badge-"+reply.memberBadge+".png");
					}
					else if(reply.memberPoint >= 550 && reply.memberPoint <= 850){
						$(html).find(".badge").attr("src", "/images/badge-"+reply.memberBadge+".png");
					}
					else if(reply.memberPoint >= 850 && reply.memberPoint <= 1200){
						$(html).find(".badge").attr("src", "/images/badge-"+reply.memberBadge+".png");
					}
					else if(reply.memberPoint >= 1200 && reply.memberPoint <= 1600){
						$(html).find(".badge").attr("src", "/images/badge-"+reply.memberBadge+".png");
					}
					else if(reply.memberPoint >= 1600 && reply.memberPoint <= 2050){
						$(html).find(".badge").attr("src", "/images/badge-"+reply.memberBadge+".png");
					}
					else if(reply.memberPoint >= 2050 && reply.memberPoint <= 2500){
						$(html).find(".badge").attr("src", "/images/badge-"+reply.memberBadge+".png");
					}
					else if(reply.memberPoint >= 2500 && reply.memberPoint <= 3000){
						$(html).find(".badge").attr("src", "/images/badge-"+reply.memberBadge+".png");
					}
					else if(reply.memberPoint == 3000){
						$(html).find(".badge").attr("src", "/images/badge-"+reply.memberBadge+".png");
					}
						
					//작성자 닉네임
					$(html).find(".reply-member-nickname").text(reply.memberNick);
					$(html).find(".reply-writetime").text(reply.replyWriteTime);
					
					//블라인드 글 표시 설정
					if(reply.replyBlind == "Y") {
						$(html).find(".visible-post-content").remove();
					}
					else {
						$(html).find(".blind-post-content").remove();
						$(html).find(".visible-post-content").text(reply.replyContent);
					}
					
					//수정/삭제 버튼 작성자에게만 표시
					if(loginId != reply.replyId) {//작성자일 경우
						$(html).find(".edit-btn").remove();
						$(html).find(".delete-btn").remove();
					}
					
					//관리자 처리(블라인드 설정/해제 버튼)
					if(loginNick.indexOf("관리자") != 0) {
						$(html).find(".blind-btn").remove();
						$(html).find(".visible-btn").remove();
					}
					
					
					
					tbody.append(html);
				}
			}
		});
	}
				
	//댓글 등록 처리
		$(".reply-insert-form").submit(function(e){
			e.preventDefault();
			
			//댓글 입력값을 가져와서 검사 후 전송
			var text = $(this).find("[name=replyContent]").val();
			
			
			var form = this;
			
 			//정상적으로 입력되었다면 비동기 통신으로 등록 요청
 			$.ajax({
 				url:"${pageContext.request.contextPath}/rest/reply/insert",
 				method:"post",
		 		data:$(form).serialize(),//form을 전송 가능한 형태의 문자로 변환한다
				success:function(resp){
			 		loadList();
					form.reset();
 				} 
 			});
		});
		
		//댓글 삭제버튼을 누르면 삭제 후 목록 갱신
		$(".delete-btn").click(deleteHandler);
		
		function deleteHandler(e){
			e.preventDefault();
			
			$.ajax({
				url:"${pageContext.request.contextPath}/rest/reply/delete",
				method:"post",
				data:{
					replyBoardNo:$(this).data("reply-board-no"),
					replyNo:$(this).data("reply-no")
				},
				success:loadList(),
			});
		}	
		//목표 : 
		//1. edit-btn을 누르면 view를 숨기고 editor를 보여준다
		//2. cancel-btn을 누르면 editor를 숨기고 view를 보여준다
		//3. 처음에는 view만 보여준다
		
		$(".edit-btn").click(function(){
			$(this).parents(".view").hide();
			$(this).parents(".view").next(".editor").show();
		});
		
		$(".cancel-btn").click(function(){
			$(this).parents(".editor").hide();
			$(this).parents(".editor").prev(".view").show();
		});
		
		$(".editor").hide();
	
		
		
})

	
	
</script>

<!-- 자바스크립트 템플릿 생성 -->
<script type="text/template" id="reply-list-header">
	<thead>
		<tr>
			<td colspan="2">
				총 {{size}}개의 댓글이 있습니다.
			</td>
		</tr>
	</thead>
</script>

<script type="text/template" id="reply-list-item">
				<tr class="view">
					<td class="reply-border">
						<!-- 작성자 -->
						<ul class="reply-box">
							<li class="reply-author left">
								<p>
									<img class="reply-badge" src="${pageContext.request.contextPath}/images/lev1.png">
									<span class="reply-member-nickname"></span>
									<span class="reply-writetime date"></span>
								</p>													
							</li>
							
							<li class="reply-main left">
								<p>
									<pre class="blind-post-content">블라인드 처리된 게시물입니다</pre>
									<pre class="visible-post-content"></pre>
								</p>
							</li>
						</ul>
 
						<br>											
						<br>			
					</td>
					<th>
						<a style="display:block; margin:10px 0px;" class="edit-btn"><img src="${pageContext.request.contextPath}/images/edit.png" width="20" height="20"></a>
						<a style="display:block; margin:10px 0px;" class="delete-btn" data-reply-board-no="{{replyDto.replyBoardNo}}" data-reply-no="{{replyDto.replyNo}}"><img src="${pageContext.request.contextPath}/images/delete.png" width="20" height="20"></a>
						<!-- 수정과 삭제는 현재 사용자가 남긴 댓글에만 표시 -->	
			
						<!-- 블라인드 여부에 따라 다르게 표시 -->
						<a style="display:block; margin:10px 0px;" class="blind-btn" href="reply/blind?replyNo={{replyDto.replyNo}}&replyBoardNo={{replyDto.replyBoardNo}}"><img src="${pageContext.request.contextPath}/images/blind2.png" width="20" height="20"></a>
						<a style="display:block; margin:10px 0px;" class="visible-btn" href="reply/blind?replyNo={{replyDto.replyNo}}&replyBoardNo={{replyDto.replyBoardNo}}"><img src="${pageContext.request.contextPath}/images/blind.png" width="20" height="20"></a>
					</th>
				</tr>	

				

				
		
</script>

<script id="edit-btn" type="text/template">
	<tr class="editor">
					<th colspan="2">
						<form action="reply/edit" method="post">
							<input type="hidden" name="replyNo" 
														value="">
							<input type="hidden" name="replyBoardNo"
														value="">
							<textarea class="input" name="replyContent" rows="5" cols="50" 
									required></textarea>
							<button type="submit">변경</button>
							<a class="cancel-btn">취소</a>
						</form>
					</th>
				</tr>
</script>

<script type="text/javascript">

</script>


<%-- <tr class="view">
					<td width="90%">
						<!-- 작성자 -->
						<ul class="reply-box">
							<li class="reply-author left">
								<p><c:if test="{{boardDto.memberBadge == 1 }}">
								<img class="badge" src="${pageContext.request.contextPath}/images/badge-1.png">
									</c:if>{replyDto.memberNick}
									
								</p>							
								
							</li>
							
							<li class="reply-main left">
								<p>
									
										<c:when test="{{replyDto.replyBlind}}">
										<pre>블라인드 처리된 게시물입니다</pre>
									
										<pre>{{replyDto.replyContent}}</pre>
									
								</p>
							</li>
						</ul>
 
						<br>											
						<br>			
					</td>
					<th>
						<c:if test="{{loginId == replyDto.replyId}}">
							<a style="display:block; margin:10px 0px;" class="edit-btn"><img src="${pageContext.request.contextPath}/images/edit.png" width="20" height="20"></a>
							<a style="display:block; margin:10px 0px;" class="delete-btn" data-reply-board-no="{{replyDto.replyBoardNo}}" data-reply-no="{{replyDto.replyNo}}"><img src="${pageContext.request.contextPath}/images/delete.png" width="20" height="20"></a>
						</c:if>
						<!-- 수정과 삭제는 현재 사용자가 남긴 댓글에만 표시 -->				
						
						<c:if test="{{loginNick.contains('관리자')}}">
							<!-- 블라인드 여부에 따라 다르게 표시 -->
							<c:choose>
								<c:when test="{{replyDto.replyBlind == 'Y'}}">
									<a style="display:block; margin:10px 0px;" href="reply/blind?replyNo={{replyDto.replyNo}}&replyBoardNo={{replyDto.replyBoardNo}}"><img src="${pageContext.request.contextPath}/images/blind2.png" width="20" height="20"></a>
								</c:when>
								<c:otherwise>
									<a style="display:block; margin:10px 0px;" href="reply/blind?replyNo={{replyDto.replyNo}}&replyBoardNo={{replyDto.replyBoardNo}}"><img src="${pageContext.request.contextPath}/images/blind.png" width="20" height="20"></a>
								</c:otherwise>
							</c:choose>
							
						</c:if>
					</th>
				</tr>	 --%>

<div class="container-800 mt-40 mb-40">
	<div class="container">
		<div class="title">
			<h1>${boardDto.boardTitle}	</h1>
		</div>
		
		<div class="info">
			<ul class="author">
				<li>
				 <img class="profile" src="${pageContext.request.contextPath}/rest/download/${boardDto.profileAttachmentNo}"/>					
					${boardDto.memberNick}
					<c:choose>
                    		<c:when test="${boardDto.memberPoint<=100}">
                    		
                    			<img class="title-badge" src="${pageContext.request.contextPath}/images/lev1.png"/>
                    		</c:when>
                    		<c:when test="${boardDto.memberPoint<=300}">
                    			
                    			<img class="title-badge" src="${pageContext.request.contextPath}/images/lev2.png"/>
                    		</c:when>
                    		<c:when test="${boardDto.memberPoint<=550}">
                    			
                    			<img class="title-badge" src="${pageContext.request.contextPath}/images/lev3.png"/>
                    		</c:when>
                    		<c:when test="${boardDto.memberPoint<=850}">
                    			
                    			<img class="title-badge" src="${pageContext.request.contextPath}/images/lev4.png"/>
                    		</c:when>
                    		<c:when test="${boardDto.memberPoint<=1200}">
                    			
                    			<img class="title-badge" src="${pageContext.request.contextPath}/images/lev5.png"/>
                    		</c:when>
                    		<c:when test="${boardDto.memberPoint<=1600}">
                    			
                    			<img class="title-badge" src="${pageContext.request.contextPath}/images/lev6.png"/>
                    		</c:when>
                    		<c:when test="${boardDto.memberPoint<=2050}">
                    			
                    			<img class="title-badge" src="${pageContext.request.contextPath}/images/lev7.png"/>
                    		</c:when>
                    		<c:when test="${boardDto.memberPoint<=2500}">
                    			
                    			<img class="title-badge" src="${pageContext.request.contextPath}/images/lev8.png"/>
                    		</c:when>
                    		<c:when test="${boardDto.memberPoint<3000}">
                    			
                    			<img class="title-badge" src="${pageContext.request.contextPath}/images/lev9.png"/>
                    		</c:when>
                    		<c:when test="${boardDto.memberPoint==3000}">
                    			
                    			<img class="title-badge" src="${pageContext.request.contextPath}/images/lev10.png"/>
                    		</c:when>
                    	</c:choose>
			</ul>
			<ul class="other-info" >
				<li>작성일: ${boardDto.boardWriteTime}</li>
				<li>조회수: ${boardDto.boardClick}</li>
				<li>댓글: ${boardDto.replyCnt}</li>
			</ul>
			<span>
			<c:choose>
				<c:when test="${like==null}">
					<i class="fa-regular fa-heart like-btn"></i> 
				<span>${boardDto.boardLike}</span>
				</c:when>
				<c:otherwise>
					<i class="fa-solid fa-heart like-btn heart-color"></i> 
				<span>${boardDto.boardLike}</span>
				</c:otherwise>
			</c:choose>
			
			</span>
				
		</div>
		<hr>
		<div class="main">
			<p class="maxsize">
				${boardDto.boardContent}
			</p>
			<div class="right">
				<c:if test="">
						<a class="btn btn-positive" href="write">글쓰기</a>	
				</c:if>
				
					<c:set var="owner" value="${loginId == boardDto.boardId}"></c:set>
						
					<c:if test="${owner}">
						<a class="btn btn-positive" href="write">글작성</a>	
						<a class="edit-btn btn btn-negative" href="edit?boardNo=${boardDto.boardNo}">수정</a>	
						<a class="board-delete btn btn-negative" href="delete?boardNo=${boardDto.boardNo}">삭제</a>	
					</c:if>
						<a class="btn btn-neutral" href="list">목록</a>
			</div>
			<hr>
		</div>
	</div>	
	
	<div class="row center">
		<table class="table table-slit table-hover table-reply-list">
			<!-- 댓글 목록 -->
			<thead>
				<tr>
					<td colspan="2">
						총 ${replyList.size()}개의 댓글이 있습니다.
					</td>
				</tr>
			</thead>
			<tbody>
				
				
				
				<%-- <c:if test="${loginId ==  replyDto.replyId}">
				<!-- 수정하기 위한 화면 : 댓글 작성자 본인에게만 출력 -->
				<tr class="editor">
					<th colspan="2">
						<form action="reply/edit" method="post">
							<input type="hidden" name="replyNo" 
														value="${replyDto.replyNo}">
							<input type="hidden" name="replyBoardNo"
														value="${replyDto.replyBoardNo}">
							<textarea class="input" name="replyContent" rows="5" cols="50" 
									required>${replyDto.replyContent}</textarea>
							<button type="submit">변경</button>
							<a class="cancel-btn">취소</a>
						</form>
					</th>
				</tr>
				</c:if> --%>
				
				
			</tbody>
		</table>
	</div>
	
	<div class="row center">
		<%-- 회원일 경우와 아닐 경우 댓글 작성창이 다르게 보이도록 처리 --%>
		<c:choose>
			<c:when test="${loginId != null}">
				<!-- 댓글 작성 -->
				<form class="reply-insert-form">
				<input type="hidden" name="replyBoardNo" value="${boardDto.boardNo}">
				<table class="table">
					<tbody>
						<tr>
							<th>
								<textarea class="input w-100 fix-size" name="replyContent" rows="5" cols="55" 
												placeholder="댓글 작성.." required></textarea>
							</th>
							<th valign="bottom">
								<button class="btn btn-positive" type="submit">등록</button>
							</th>
						</tr>
					</tbody>
				</table>
				</form>
			</c:when>
			<c:otherwise>
				<table class="table">
					<tbody>
						<tr>
							<th>
								<textarea name="replyContent" rows="5" cols="55" 
									placeholder="로그인 후 댓글 작성이 가능합니다" disabled></textarea>
							</th>
							<th>
								<button type="submit" disabled>등록</button>
							</th>
						</tr>
					</tbody>
				</table>
			</c:otherwise>
		</c:choose>
	</div>
</div>
<script>

$(function(){
 	$(".board-delete").click(function(e){
 		
 		var choice = confirm("정말 삭제하시겠습니까?");
 		if(!choice){
 			e.preventDefault();
 		}
 	});
 });

  $(function(){
 	$(".edit-btn1").click(function(e){
 		
 		var choice = confirm("수정 페이지로 이동합니다.");
 		if(!choice){
 			e.preventDefault();
 		}
 	});
 });
 $(function(){
	 	$(".list-btn").click(function(e){
	 		
	 		var choice = confirm("목록으로 이동하시겠습니까?");
	 		if(!choice){
	 			e.preventDefault();
	 		}
	 	});
	 });
 





</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>