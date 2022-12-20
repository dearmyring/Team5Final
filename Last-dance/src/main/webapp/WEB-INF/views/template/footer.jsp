<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	</div>
    <!-- 컨텐츠 영역 끝 -->
    
    	<!-- 송민영 -->
    <!-- 1:1 문의 영역 -->
    <div class="message-list">
    	<div class="center row">
    		<span>1:1 문의</span><i class="fa-solid fa-caret-up center-hide"></i>
    	</div>
		<div class="right center-message"></div>
		<hr>
		<div class="float-container">
			<input class="message-content-input input w-80" type="text">
			<button class="message-send-btn btn w-20" type="button">입력</button>
		</div>
	</div>
	

	 <script>
    $(function(){
    	
        $(".fa-solid").click(function(){
            if($(this).hasClass("fa-caret-up")){
                $(this).removeClass("fa-caret-up center-hide").addClass("fa-caret-down");
                
                var uri = "ws://localhost:8888/ws/center";
    			
                socket = new WebSocket(uri);
    			
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
//     				var height = $(document).height();
//     				$(window).scrollTop(height);
    			};
            }
            else{
                $(this).removeClass("fa-caret-down").addClass("fa-caret-up center-hide");
            	socket.close();
            }
        });
        
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
    <style>
        .message-list{
         position:fixed; 
         border-radius: 10px; 
         background-color: white; 
         width:300px;
         box-shadow: 0px 0px 30px 0px rgba(0, 0, 0, 0.1); 
         z-index: 99999; 
         right:0; 
         bottom:0;
         transition: 0.6s;
        }
        .message-list:has( i.center-hide) {
         right:0; 
         bottom:-32%;
         transition: 0.6s;
        }
        .message-list .fa-caret-up,
        .message-list .fa-caret-down{
            position:absolute; 
            right:0.5em; 
            top:0.5em;
            cursor: pointer;
        }
        .center-message{
            height:200px;
        }
    </style>
    <!-- 송민영 -->

    <!-- 푸터 영역 시작 -->
    <div id="footer">
        <div>
            <div class="footer-info">
                <ul class="info-list">
                    <li><a href="/"><img src="${pageContext.request.contextPath}/images/logo.png" class="logo-footer"/></a></li>
                    <li><a href="#">이용약관</a></li>
                    <li><a href="#">개인정보 처리 방침</a></li>
                    <li><a href="#">통합검색 고객센터</a></li>
                    <li><a href="${pageContext.request.contextPath}/center/${loginId}">고객센터 02-1111-1111</a></li>
                </ul>
            </div>
        </div>
    </div><!-- 푸터 영역 끝 -->
    
    
    <!-- 헤더 검색 -->
  	<script>
 		$(function(){
 			// 검색창 토글 이벤트
 			$(".complex").click(function(){
 				$("html, body").animate({scrollTop : 0}, 400);
                $(".search-box").slideToggle(600);
            });
 			
 			// form 기본 이벤트 차단
 			$(".search-form").submit(function(e){
 				e.preventDefault();
 			});
 			
 			// 목록 조회 결과를 전역 변수 배열에 넣기
 			const searchRepository = [];
 			
 			// 키워드 조회 비동기
 			$(".search-input").on("input", function(e){
 				e.preventDefault;
 				const keyword = $(this).val();
 				const noneList = $("<div>").addClass("not-in-keyword mt-20").text("검색 결과가 없습니다 😥");
 				
				if(keyword == "") {
					$(".search-list").css("display", "none");
					$(".search-list-select").css("display", "block");
				} 	
				
		  		$.ajax({
					url:"http://localhost:8888/rest/search/" + keyword,
					method:"get",
					async:false,
					success: function(resp) {
						$(".search-list").css("display", "block");
						$(".search-list-select").css("display", "none");
						$(".search-list").empty();
						if(resp.length == 0) {
							$(".search-list").append(noneList);
						}
						else {
							for(var i = 0; i < resp.length; i++) {
								const getList = $("<div>").addClass("left result-keyword").html("<i class='fa-solid fa-square-plus'></i><span class='ms-10 get-keyword'>" + resp[i].ingredientName + "</span>");
								$(".search-list").append(getList);
								searchRepository.push(resp[i].ingredientName);
							}
						}
					}
 				})
 			});
 			
 			// 사용자가 엔터키를 누를시 입력된 데이터 추가 이벤트
 			$(".search-input").keypress(function(key) {
 				const keyword = $(this).val();
 				const addList = $("<div>").addClass("get-ingredient ms-10 mt-10").text(keyword);
				if(key.keyCode == 13){
					if(!$(this).val() == "") {
						$(".search-list-select").append(addList);
						$(".search-list").css("display", "none");
						$(".search-list-select").css("display", "block");
						$(".search-input").val("");
						console.log(searchRepository);
						// 클릭 이벤트가 끝나기 직전에 배열 추가
						submitList.push(keyword);
					}
					else {
						alert("검색어 입력하고 엔터 누르길 요망");
					}
				} 
 			});
 			
 			//보낼 배열
 			const submitList = [];
 			
 			// 사용자가 검색 유사어를 클릭할 시 클릭된 데이터 추가 이벤트
 			$(document).on("click", ".result-keyword", function(){
 				$(".search-input").val($(this).text());
 				const keyword = $(".search-input").val();
 				const addList = $("<div>").addClass("get-ingredient ms-10 mt-10").text(keyword);
 				$(".search-list-select").append(addList);
 				$(".search-list").css("display", "none");
 				$(".search-list-select").css("display", "block");
				$(".search-input").val("");
				$(".search-input").focus();
				// 클릭 이벤트가 끝나기 직전에 배열 추가
				submitList.push(keyword);
 			});
 			
 			//보내기 버튼을 누르면 배열에 들어있는 원소를 확인+
 			$(".btn-list-submit").on("click", function(){
//  				console.log(submitList);
 				
 	 			//배열 값 보내기
 	 			$.ajax({
 					  url :'/recipe/searchList',
 					  type : 'post',
 					  dataType : 'json',
 					  data : {
 					  	"submitList" : submitList
 					  },
//  					  success: function(data){
//  					  	console.log("성공");

 					  
//  					  }
 					});
				  	window.location = ("/recipe/searchList");
 			})

 			
 			// 추가된 데이터를 삭제하는 이벤트
 			$(document).on("click", ".get-ingredient", function(){
 				$(this).remove();
 			});
 			
 		}); // jQuery 종료
 	</script>
 	<!-- 헤더 검색 끝 -->
</body>
</html>