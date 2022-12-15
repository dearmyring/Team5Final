<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	</div>
    <!-- 컨텐츠 영역 끝 -->

    <!-- 푸터 영역 시작 -->
    <div id="footer">
        <div>
            <div class="footer-info">
                <ul class="info-list">
                    <li><a href="/"><img src="${pageContext.request.contextPath}/images/logo.png" class="logo-footer"/></a></li>
                    <li><a href="#">이용약관</a></li>
                    <li><a href="#">개인정보 처리 방침</a></li>
                    <li><a href="#">통합검색 고객센터</a></li>
                    <li><a href="#">고객센터 02-1111-1111</a></li>
                </ul>
            </div>
        </div>
    </div><!-- 푸터 영역 끝 -->
  	<script>
 		$(function(){
 			// 검색창 토글
 			$(".complex").click(function(){
 				$("html, body").animate({scrollTop : 0}, 400);
                $(".search-box").slideToggle(600);
            });
 			
 			// form 기본 이벤트 차단
 			$(".search-form").submit(function(e){
 				e.preventDefault();
 			});
 			
 			// 검색창 기능 시작
 			$(".search-input").keyup(function(key){
 				var keyword = $(this).val();
	 			var isEmpty = $(".search-list").empty();
 				if(keyword == "") {
		 			$(".search-list").css("display", "none");
 				} isEmpty;
 				
		  		$.ajax({
					url:"http://localhost:8888/rest/search/" + keyword,
					method:"get",
					success: function(resp) {
						$(".search-list").css("display", "block");
						$(".search-list").empty();
						
						if(resp.length == 0) {
							$(".search-list-select").css("display", "none");
							$(".search-list").append("<div class='mt-30 not-in-keyword'>검색 결과가 없습니다 😥</div>");
						}
						else {
							for(var i = 0; i < resp.length; i++) {
								$(".search-list-select").css("display", "none");
								$(".search-list").append("<div class='left result-keyword'><i class='fa-solid fa-square-plus'></i><span class='result-keyword'>" + resp[i].ingredientName + "</span></div>");
							}
						}
						if(key.keyCode == 13){
							if(resp.length > 0) {
				 				$(".search-list-select").append("<div class='get-ingredient ms-10 mt-10'>" + $(".search-input").val() + "</div>");
								$(".search-list").css("display", "none");
								$(".search-input").val("");
								$(".search-list-select").css("display", "");
							}
							else {
								alert("추가 불가, 임시 alert창임");
							}
		 				}
						$(".get-keyword").click(function(e){
							e.stopPropagation()
			 				$(".search-input").val($(this).val());
			 				$(".search-list-select").append($(".search-input").val());
			 				$(".search-list").css("display", "none");
			 				$(".search-input").val("");
						});
					}
				});
 			})
 			
	  		//검색창 바깥 영역 클릭시 목록 숨기기
	        $(document).click(function(){
	        	$(".search-list").css("display", "none");
	       	});
 		});
 	</script>
</body>
</html>