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
    
    <!-- 헤더 검색 -->
     <script>
       $(function(){
          // 검색창 토글 이벤트
          $(".complex").click(function(){
             $("html, body").animate({scrollTop : 0}, 400);
                $(".search-box").slideToggle(600);
            });
          
          // form 기본 이벤트 차단
          //$(".search-form").submit(function(e){
             //e.preventDefault();
          //});
          
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
             });
          });
          
          // 사용자가 엔터키를 누를시 입력된 데이터 추가 이벤트
          $(".search-input").keypress(function(key) {
             const keyword = $(this).val();
             //const addList = $("<div>").addClass("get-ingredient ms-10 mt-10").text(keyword);
             const addList = $("<input>").addClass("get-ingredient ms-10 mt-10").attr("value", keyword).attr("name", "recipeIngredientName").attr("type", "text").attr("size", keyword.length);
            if(key.keyCode == 13){
               if(!$(this).val() == "") {
                  $(".search-list-select").append(addList);
                  $(".search-list").css("display", "none");
                  $(".search-list-select").css("display", "block");
                  $(".search-input").val("");
                  // 클릭 이벤트가 끝나기 직전에 배열 추가
                  submitList.push(keyword);
               }
               else {
                  alert("검색어 입력하고 엔터 누르길 요망");
               }
            } 
          });
          
          // 사용자가 검색 유사어를 클릭할 시 클릭된 데이터 추가 이벤트
          $(document).on("click", ".result-keyword", function(){
             $(".search-input").val($(this).text());
             const keyword = $(".search-input").val();
             const addList = $("<input>").addClass("get-ingredient ms-10 mt-10").attr("value", keyword).attr("name", "recipeIngredientName").attr("type", "text").css("width", "100px");
             $(".search-list-select").append(addList);
             $(".search-list").css("display", "none");
             $(".search-list-select").css("display", "block");
            $(".search-input").val("");
            $(".search-input").focus();
          });
          
          // 추가된 데이터를 삭제하는 이벤트
          $(document).on("click", ".get-ingredient", function(){
             $(this).remove();
          });
          
          // 재료 입력이 끝나고 검색 버튼을 누르면 폼으로 넘어간다.
          $(".btn-list-submit").on("click", ".get-ingredient", function(){
            $(".search-form").submit();
         });
          
       }); // jQuery 종료
    </script>
    <!-- 헤더 검색 끝 -->
</body>
</html>