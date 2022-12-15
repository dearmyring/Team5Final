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
                $(".search-box").slideToggle(600);
            });
 			
 			// 검색창 기능 시작
 			
 			$(".search-input").keyup(function(){
 				var keyword = $(this).val();
	 			var isEmpty = $(".search-list").empty();
 				if(keyword == "") {
		 			$(".search-list").css("display", "none");
 				}
 				isEmpty;
		  		$.ajax({
					url:"http://localhost:8888/rest/search/"+keyword,
					method:"get",
					success: function(resp) {
						$(".search-list").css("display", "block");
						$(".search-list").empty();
						if(resp.length == 0) {
							$(".search-list").append("<div class='mt-30 not-in-keyword'>검색 결과가 없습니다 😥</div>");
						}
						else {
							for(var i = 0; i < resp.length; i++) {
									$(".search-list").append("<div class='left result-keyword'><i class='fa-solid fa-square-plus'></i><span class='result-keyword'>" + resp[i].ingredientName + "</span></div>");
							}
						}
					}
				}); // ajax 종료
 			})
 			// 검색창 기능 종료
 		});
 	</script>
</body>
</html>