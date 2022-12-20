<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<button class="btn-connect"><i class="fa-solid fa-caret-up"></i></button>

<h2>1:1 문의</h2>

<div class="message-list">
	<c:forEach var="centerDto" items="${centerHistoryList}">
		<p class="center-message">
			<p>
				${centerDto.centerContent} 
			</p>
			<p>
				${centerDto.centerTime}
			</p>
		</p>
	</c:forEach>
</div>

<hr>
<input class="message-content-input" type="text">
<button class="message-send-btn" type="button">입력</button>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script type="text/javascript">
	$(function(){
		function disconnectState(){
			$(".fa-solid").removeClass("fa-caret-down").addClass("fa-caret-up");
		};
		function connectState(){
			$(".fa-solid").removeClass("fa-caret-up").addClass("fa-caret-down");
		}
		
		/* 위 버튼 누르면 연결 */
		$(".fa-caret-up").click(function(){
			
			var uri = "${pageContext.request.contextPath}/ws/center";
			
			socket = new SockJS(uri);
			
			socket.onopen = function(){
			};
			socket.onclose = function(){
			};
			socket.onerror = function(){
			};
			socket.onmessage = function(e){
				saveMessage(e.data);
				var data = JSON.parse(e.data);
				
				var p = $("<p>").addClass("center-message");
				var time = moment(data.centerTime).format("YYYY-MM-DD hh:mm");
				var t = $("<p>").text(time);
				var c = $("<p>").text(data.centerContent);
				p.append(c).append(t);
				$(".message-list").append(p);
				
				//스크롤 하단으로 이동
// 				var height = $(document).height();
// 				$(window).scrollTop(height);
			};
		});
		
		$(window).on("beforeunload", function(){
			socket.close();
		});
		
// 		/* 아래 버튼 누르면 연결 해제 */
// 		$(".fa-caret-down").click(function(){
// 			disconnectState();
// 			socket.close();
// 		});
		

		function saveMessage(e){
			$.ajax({
				url:"http://localhost:8888/rest/center",
				method:"post",
				contentType:"application/json",
				data:e,
				success:function(resp){
					console.log(resp);
				}
			});
		}
		
		$(".message-content-input").keydown(function(e){
			if(e.keyCode == 13){
				$(".message-send-btn").click();
			}
		});
		
		/* 메세지 전송 */
		$(".message-send-btn").click(function(){
			var text = $(".message-content-input").val();
			if(text.length == 0) return;
			
			var data = {
				centerContent : text
			};
			socket.send(JSON.stringify(data));
			$(".message-content-input").val("");
		});
	});
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>