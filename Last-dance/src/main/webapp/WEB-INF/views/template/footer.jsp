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
 			
 			$(".complex").click(function(){
                $(".search-box").slideToggle(600);
            });
 			
 			var searchList = [];
 			
 			$(".search-input").on("input", function(){
 				var keyword = $(this).val();
		  		$.ajax({
					url:"http://localhost:8888/rest/search/"+keyword,
					method:"get",
					success: function(resp) {
						searchList = resp;
						for(var i = 0; i < searchList.length; i++) {
							console.log(searchList[i]);
						}
					}
				}); // ajax 종료
 			})
 			
 		});
 	</script>
</body>
</html>