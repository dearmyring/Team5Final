<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="자유 게시판" name="title"/>
</jsp:include>

<style>
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
		text-align: center;
		padding-bottom: 20px;
	}
	
	.info {
		margin-bottom: 30px;
	}
	
	.other-info {
		display: flex;
	}
	
	.other-info > li:not(:first-child) {
		margin-left: 20px;
	}
	
	.main {
		margin-top: 50px;
		margin-bottom: 50px;
		text-align: center;
	}
	
	.main > p {
		margin-top: 20px;
	}
	
	.reply-box {
		display: flex;
		justfy-content: center;
	}
	
	.reply-author: {
		width: 30%;
	}
	
	.reply-main {
		width: 40%;
		margin-left: 60px;
	}
	
	.reply-date {
		width: 30%;
		margin-left: 60px;
	}
	
</style>

<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">
	$(function(){
		//목표 : 
		//1. edit-btn을 누르면 view를 숨기고 editor를 보여준다
		//2. cancel-btn을 누르면 editor를 숨기고 view를 보여준다
		//3. 처음에는 view만 보여준다
		//1
		$(".edit-btn").click(function(){
			$(this).parents(".view").hide();
			$(this).parents(".view").next(".editor").show();
		});
		//2
		$(".cancel-btn").click(function(){
			$(this).parents(".editor").hide();
			$(this).parents(".editor").prev(".view").show();
		});
		//3
		$(".editor").hide();
	});
	
	
	//댓글 등록 처리
	$(function(){
		$(".reply-insert-form").submit(function(e){
			e.preventDefault();
			
			//댓글 입력값을 가져와서 검사 후 전송
			var text = $(this).find("[name=replyContent]").val();
			if(!text){
				alert("내용을 작성해주세요");
				return;
			}
			
			var form = this;
			
 			//정상적으로 입력되었다면 비동기 통신으로 등록 요청
 			$.ajax({
 				url:"${pageContext.request.contextPath}/rest/reply/insert",
 				method:"post",
 			 /* 	data:{
 					replyBoardNo:$(this).find("[name=replyBoardNo]").val(),
 					replyContent:text
 				},
 					success:function(resp){
 						console.log(resp);  */
 			 		data:$(form).serialize(),//form을 전송 가능한 형태의 문자로 변환한다
 					success:function(resp){
 			 		listHandler(resp);
					
 					//입력창 초기화(= 폼 초기화) - 자바스크립트로 처리
 					form.reset();
 				} 
 			});
			
		});
// 		
		
		//댓글 삭제버튼을 누르면 삭제 후 목록 갱신
		$(".delete-btn").click(deleteHandler);
		
		function deleteHandler(e){
			e.preventDefault();
			
			console.log(this);
			
			$.ajax({
				url:"${pageContext.request.contextPath}/rest/reply/delete",
				method:"post",
				data:{
					replyBoardNo:$(this).data("reply-board-no"),
					replyNo:$(this).data("reply-no")
				},
				success:function(resp){
					listHandler(resp);
				}
// 				success:listHandler
			});
		}
		function listHandler(resp){
			//원래 있던 댓글 삭제
			$(".table-reply-list").empty();//태그는 유지하고 내부를 삭제
			
			//헤더 생성
			var header = $("#reply-list-header").text();
			header = header.replace("{{size}}", resp.length);
			$(".table-reply-list").append(header);
			
			//바디 생성
			$(".table-reply-list").append("<tbody>");
			
			//현재 resp는 배열이다.
			//미리 댓글 형식을 만들어두고 값만 바꿔치기해서 댓글 목록에 추가하도록 구현
			for(var i=0; i < resp.length; i++){
				//console.log(resp[i]);
				var item = $("#reply-list-item").text();
				item = item.replace("{{memberNick}}", resp[i].memberNick);
				item = item.replace("{{boardId}}", resp[i].boardId);
				item = item.replace("{{memberBadge}}", resp[i].memberBadge);
				item = item.replace("{{replyContent}}", resp[i].replyContent);
				item = item.replace("{{replyWriteTime}}", resp[i].replyWriteTime);
				item = item.replace("{{replyEditTime}}", resp[i].replyEditTime);
				item = item.replace("{{replyNo}}", resp[i].replyNo);
				item = item.replace("{{replyBoardNo}}", resp[i].replyBoardNo);
				var result  = $(item);
				result.find(".delete-btn").click(deleteHandler);//개별 추가
				console.log("result", result.find(".delete-btn"));
				$(".table-reply-list").children("tbody").append(result);
			}
			
		}
	});
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
					<td>
						<!-- 작성자 -->
						<pre>{{replyContent}}</pre>
						<br>
						({{memberBadge}}) 
						{{memberNick}}			
						<br><br>
						{{replyWriteTime}}
						

					</td>
					<th>
						<!-- 수정과 삭제는 현재 사용자가 남긴 댓글에만 표시 -->
						<a style="display:block; margin:10px 0px;" class="edit-btn"><img src="/images/edit.png" width="20" height="20"></a>
						<a style="display:block; margin:10px 0px;" class="delete-btn" data-reply-board-no="{{replyBoardNo}}" data-reply-no="{{replyNo}}"><img src="/images/delete.png" width="20" height="20"></a>
					</th>
				</tr>	
</script>


<div class="container-800 mt-40 mb-40">
	<div class="container">
		<div class="title">
			<h1>제목제목제목제목제목제목제목제목제목제목제목제목제목</h1>
		</div>
		<div class="info">
			<ul class="author">
				<p>여의도꿀주먹</p>
			</ul>
			<ul class="other-info" >
				<li>2022-12-24 20:30</li>
				<li>조회수: 200</li>
				<li>댓글: 0</li>
			</ul>
		</div>
		<hr>
		<div class="main">
			<img src="1.jpg">
			<p>
				국제사회가 평가하는 한국의 기후위기 대응 수준은 주요국 중에서 최하위권이다. 
				경제 규모 세계 10위권인 한국이 위상에 걸맞은 기후위기 대응 노력을 하지 않는다는 의미다. 
				기후위기 대응은 국제사회의 약속이다. 국내 사정에 따라 늦춰서도 안 되고 그럴 여유도 없다. 
				자칫 탄소중립 실현 과정에서 국제사회의 거센 비판과 압력에 직면하고, 통상 장벽에 가로막혀 엄청난 비용 청구서를 받아들 수 있다.
								국제사회가 평가하는 한국의 기후위기 대응 수준은 주요국 중에서 최하위권이다. 
				경제 규모 세계 10위권인 한국이 위상에 걸맞은 기후위기 대응 노력을 하지 않는다는 의미다. 
				기후위기 대응은 국제사회의 약속이다. 국내 사정에 따라 늦춰서도 안 되고 그럴 여유도 없다. 
				자칫 탄소중립 실현 과정에서 국제사회의 거센 비판과 압력에 직면하고, 통상 장벽에 가로막혀 엄청난 비용 청구서를 받아들 수 있다.
								국제사회가 평가하는 한국의 기후위기 대응 수준은 주요국 중에서 최하위권이다. 
				경제 규모 세계 10위권인 한국이 위상에 걸맞은 기후위기 대응 노력을 하지 않는다는 의미다. 
				기후위기 대응은 국제사회의 약속이다. 국내 사정에 따라 늦춰서도 안 되고 그럴 여유도 없다. 
				자칫 탄소중립 실현 과정에서 국제사회의 거센 비판과 압력에 직면하고, 통상 장벽에 가로막혀 엄청난 비용 청구서를 받아들 수 있다.
			</p>
		</div>
	</div>
	
<%-- <div class="row center">
		<table class="table">
			<tbody>
				<tr>			
					<td class="title">
						${boardDto.boardTitle}						
					</td>
				</tr>
					<tr class="author">					
						<td>${boardDto.memberNick}</td>
						<td>2022-12-17 20:31</td>
						<td>조회수: 200</td>
						<td>댓글: 0</td>
					</tr>
				<tr height="200" valign="top">
				
					<td>
						<!-- pre 태그는 엔터, 띄어쓰기, 탭키 등을 있는 그대로 표시하는 영역 -->
						<pre>${boardDto.boardContent}</pre>
						<img src="${pageContext.request.contextPath}/rest/download/${boardImgDto.boardAttachmentNo}">
					</td>
				</tr>
				<tr>
					
					<td>${boardDto.boardClick}</td>
				</tr>
				<tr>
					
					<td>
						<fmt:formatDate value="${boardDto.boardWriteTime}" pattern="y년 M월 d일 E요일 a h시 m분 s초"/>
					</td>
				</tr>
		
				<c:if test="${boardDto.boardEditTime != null}">
				<tr>
					
					<td>
						<fmt:formatDate value="${boardDto.boardEditTime}" pattern="y년 M월 d일 E요일 a h시 m분 s초"/>
					</td>
				</tr>
				</c:if>
				
				<c:if test="${attachmentList != null}">
				<tr>
					<th>첨부파일</th>
					<td>
						<ul class="attachment-list">
							<c:forEach var="attachmentDto" items="${attachmentList}">
							<li>
								${attachmentDto.attachmentName} 
								(${attachmentDto.attachmentSize} bytes) 
								- 
								[${attachmentDto.attachmentType}]
								<a href="/attachment/download/${attachmentDto.attachmentNo}"><img src="/images/download.png" width="15" height="15"></a>
							</li>
							</c:forEach>
						</ul>
					</td>
				</tr>
				</c:if>
			</tbody>
			<tfoot>
				<tr>
					
					<td colspan="2" align="right">
						
						<c:if test="${loginId != null}">
							<a class="heart"></a>
						
						</c:if>
						<!-- 좋아요 하트 -->
						<c:if test="${isLike == null}">
						</c:if>
						<c:if test="${isLike == true}">
							<a class="heart" href="like?boardNo=${boardDto.boardNo}">♥</a>
						</c:if>
						<c:if test="${isLike == false}">
							<a class="heart" href="like?boardNo=${boardDto.boardNo}">♡</a>
						</c:if>
						추천:${likeCount} ${boardDto.boardLike}	
						
						<c:if test="">
						<a class="btn btn-positive" href="write">글쓰기</a>	
						</c:if>
						
						
							관리자는 삭제만, 회원은 자신의 글만 수정/삭제 가능하도록 처리
						
						 
						
					<c:set var="owner" value="${loginId == boardDto.boardId}"></c:set>
						
					<c:if test="${owner}">
						<a class="btn btn-positive" href="write">글쓰기</a>	
						<a class="edit-btn btn btn-negative" href="edit?boardNo=${boardDto.boardNo}">수정하기</a>	
						<a class="board-delete btn btn-negative" href="delete?boardNo=${boardDto.boardNo}">삭제하기</a>	
					</c:if>
						<a class="btn btn-neutral" href="list">목록으로</a>
					
					
					</td>
				</tr>
			</tfoot>
		</table>	
		
	</div> --%>
	
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
				<c:forEach var="replyDto" items="${replyList}">
				
				<!-- 사용자에게 보여주는 화면 -->
				<tr class="view">
					<td width="90%">
						<!-- 작성자 -->
						<ul class="reply-box">
							<li class="reply-author">
								<p>(${replyDto.memberBadge})${replyDto.memberNick}</p>
							</li>
							<li class="reply-main">
								<p>댓글 본문ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ오ㅗㅗㅗㅗㅗ</p>
							</li>
							<li class="reply-date">
								<p class="date">2022-12-23</p>
								<c:if test="${loginId == replyDto.replyId}">
									<a style="display:block; margin:10px 0px;" class="edit-btn"><img src="/images/edit.png" width="20" height="20"></a>
									<a style="display:block; margin:10px 0px;" class="delete-btn" data-reply-board-no="${replyDto.replyBoardNo}" data-reply-no="${replyDto.replyNo}"><img src="/images/delete.png" width="20" height="20"></a>
								</c:if>
							</li>
						</ul>
 
						<br>
						<c:if test="${boardDto.boardId ==  replyDto.replyId}">
						
						</c:if>
						
						<br>
						
						<!-- 블라인드 여부에 따라 다르게 표시 -->
						<c:choose>
							<c:when test="${replyDto.replyBlind}">
								<pre>블라인드 처리된 게시물입니다</pre>
							</c:when>
							<c:otherwise>
								<pre>${replyDto.replyContent}</pre>
							</c:otherwise>
						</c:choose>
						
<%-- 						<br><br>
						<fmt:formatDate value="${replyDto.replyWriteTime}" 
													pattern="yyyy-MM-dd HH:mm"/> --%>
					</td>
					<th>
						<!-- 수정과 삭제는 현재 사용자가 남긴 댓글에만 표시 -->
						
<%-- 						<c:if test="${loginId == replyDto.replyId}">
							<a style="display:block; margin:10px 0px;" class="edit-btn"><img src="/images/edit.png" width="20" height="20"></a>
							<a style="display:block; margin:10px 0px;" class="delete-btn" data-reply-board-no="${replyDto.replyBoardNo}" data-reply-no="${replyDto.replyNo}"><img src="/images/delete.png" width="20" height="20"></a>
						</c:if> --%>
						
						<c:if test="${loginNick.contains('관리자')}">
							<!-- 블라인드 여부에 따라 다르게 표시 -->
							<c:choose>
								<c:when test="${replyDto.replyBlind == 'Y'}">
									<a style="display:block; margin:10px 0px;" href="reply/blind?replyNo=${replyDto.replyNo}&replyBoardNo=${replyDto.replyBoardNo}"><img src="/images/blind2.png" width="20" height="20"></a>
								</c:when>
								<c:otherwise>
									<a style="display:block; margin:10px 0px;" href="reply/blind?replyNo=${replyDto.replyNo}&replyBoardNo=${replyDto.replyBoardNo}"><img src="/images/blind.png" width="20" height="20"></a>
								</c:otherwise>
							</c:choose>
							
						</c:if>
					</th>
				</tr>
				
				<c:if test="${loginId ==  replyDto.replyId}">
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
				</c:if>
				
				</c:forEach>
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