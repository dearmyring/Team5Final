<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="modal center-connect-modal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">1:1 문의</h5>
        <button type="button" class="btn-close center-btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="center-message-list">
      </div>
      <div class="modal-footer row">
      	<div class="col-9">
	        <input class="message-content-input w-100" type="text">
      	</div>
      	<div class="col-2">
	        <button type="button" class="btn btn-light w-100 message-send-btn">
	        	<i class="fa-solid fa-paper-plane"></i>
	        </button>
      	</div>
      </div>
    </div>
  </div>
</div>

<div class="mt-3">&nbsp;</div>
<div class="mt-3">&nbsp;</div>

<div class="history-link text-end">
	<a class="main-page-link"></a> <i class="fa-solid fa-chevron-right"></i> 1:1문의
</div>

<div class="container-fluid">
	<div class="row mt-5">
		<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
			<table class="table table-sm table-link" style="table-layout:fixed">
				<thead>
					<tr class="text-center">
						<th class="col-1"><i class="fa-regular fa-square icon-check-all"></i></th>
						<th class="col-4">아이디</th>
						<th class="col-5">문의내역</th>
						<th class="col-2">문의시간</th>
					</tr>
				</thead>
				<tbody class="center-list">
					<c:forEach var="centerDto" items="${centerList}">
						<tr class="text-center">
							<td>
								<i class="fa-regular fa-square icon-check-item"></i>
								<input class="check-item" name="centerMemberId" value="${centerDto.centerMemberId}" type="hidden">
							</td>
							<td>${centerDto.centerMemberId}</td>
							<td class="position-relative text-start text-cutter">
								<a class="text-decoration-none link-dark center-connect 
									stretched-link text-decoration-none link-dark" href="#">
									${centerDto.centerContent}
								</a>
							</td>
							<td>
								<c:set var="now" value="<%=new java.util.Date()%>" />
								<fmt:formatDate value="${now}" var="current" pattern="yyyy-MM-dd"/>
								<fmt:formatDate value="${centerDto.centerTime}" var="centerDate" pattern="yyyy-MM-dd"/>
								<c:choose>
									<c:when test="${current == centerDate}">
										<fmt:formatDate value="${centerDto.centerTime}" pattern="HH:mm"/>
									</c:when>
									<c:otherwise>
										${centerDate}
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
	<div class="row mt-3">
		<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1 text-end">
			<button class="btn btn-md btn-light center-async-delete" type="button">삭제하기</button>
		</div>
	</div>
	
</div>

<style>
	.text-cutter{
		overflow:hidden;
		white-space:nowrap;
		text-overflow:ellipsis;
	}
	.connect-center-id{
		font-size: 14px;
		background-color: #EEEEEE;
		border-radius: 20px;
		padding: 0 0.5em 0.1em 0.5em;
		margin: 0.5em 0 0 0.5em;
	}
	.center-message-list{
		height: 500px;
		overflow:auto;
		padding: 0 0.5em 0 0.5em;
	}
	.center-message-list .time-font{
		font-size: 14px;
		color: grey;
	}
	.center-message{
		display: inline-block;
		width:auto;
		height:auto;
		border-radius: 10px;
		padding: 0.5em 1em 0 1em;
		margin-top: 0.5em;
		margin-bottom: 0;
		max-width: 300px;
	}
	.center-message.center-member{
		background-color: #EEEEEE;
	}
	.center-message.center-admin, 
	.center-admin .time-font{
		background-color: #6094ee;
		color: white;
	}
	.message-content-input{
		padding-left: 0.5em;
		border: none;
		outline-color: white;
	}
</style>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script type="text/javascript">
	$(function(){
		var modal = new bootstrap.Modal($(".center-connect-modal"), {});
		
		$(".center-connect").click(function(){
			//웹소켓 접속 주소
			var uri = "${pageContext.request.contextPath}/ws/center";
			socket = new SockJS(uri);

			//회원 아이디 방을 찾아서 들어간다.
			var centerMemberId = $(this).parent().prev().text();
			socket.onopen = function(){
				var data = {
					type:1,
					room:centerMemberId
				};
				socket.send(JSON.stringify(data));
			};
			
			//이전 대화를 불러온다
			historyMessage(centerMemberId);
			
			$(".connect-center-id").remove();
			var idSpan = $("<span>").addClass("connect-center-id").text(centerMemberId);
			$(".modal-title").after(idSpan);
			modal.show();
			
			socket.onclose = function(){
   			};
   			
   			socket.onerror = function(){
   			};
   			socket.onmessage = function(e){
   				var data = JSON.parse(e.data);//객체
   				
	        	var div = $("<div>");
	        	var p = $("<p>").addClass("center-message center-admin");
	        	if(data.centerId == "${loginId}"){
	        		div.addClass("text-end");
	        		p.addClass(".center-admin text-start");
	        	}
	        	else{
	        		p.addClass(".center-member");
	        	}
				var time = moment(data.centerTime).format("YYYY-MM-DD hh:mm");
				var t = $("<p>").addClass("time-font").text(time);
				var c = $("<p>").text(data.centerContent);
				p.append(c).append(t);
				div.append(p);
				$(".center-message-list").append(div);
   			};
			
		});
		
		$(".center-btn-close").click(function(){
			socket.close();
		});
		
		$(".message-content-input").keydown(function(e){
			if(e.keyCode == 13){
				$(".message-send-btn").click();
			}
		});
		
		$(".message-send-btn").click(function(){
			var text = $(".message-content-input").val();
			if(text.length == 0) return;
			
			var data = {
				type: 2,
				text : text
			};
			socket.send(JSON.stringify(data));
			
			var db = {
				centerMemberId : $(".connect-center-id").text(),
				centerId : "${loginId}",
				centerContent : text
			}
			saveMessage(db);
			$(".message-content-input").val("");
		});
		
		function saveMessage(db){
			$.ajax({
				url:"${pageContext.request.contextPath}/rest/center",
				method:"post",
				contentType:"application/json",
				data:JSON.stringify(db),
				success:function(resp){
				}
			});
		}
		
		function historyMessage(centerMemberId){
        	$.ajax({
        		url:"${pageContext.request.contextPath}/rest/center/"+centerMemberId,
        		method:"get",
        		success: function(data){
        			$(".center-message-list").empty();
		        	for(var i=0; i<data.length; i++){
			        	var div = $("<div>")
			        	var p = $("<p>").addClass("center-message");
		        		if(data[i].centerId == centerMemberId){
			        		p.addClass("center-member");
		        		}
		        		else{
		        			div.addClass("text-end");
		        			p.addClass("center-admin text-start");
		        		}
						var time = moment(data[i].centerTime).format("YYYY-MM-DD hh:mm");
						var t = $("<p>").addClass("time-font").text(time);
						var c = $("<p>").text(data[i].centerContent);
						p.append(c).append(t);
						div.append(p);
						$(".center-message-list").append(div);
		        	}
        		}
        	});
        }
	});
</script>
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>