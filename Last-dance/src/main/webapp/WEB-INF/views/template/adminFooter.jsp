<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
	$(function(){
		$(".main-page-link").addClass("text-dark").attr("href", "${pageContext.request.contextPath}/admin/").text("메인 페이지");
		/* 모든 돌아가기 + 모달창 구현 예정 */
		$(".return-btn").click(function(){
			history.back();
		});
		
		$(".logout-btn").click(function(e){
			var choice = confirm("로그아웃 하시겠습니까?");
			if(!choice){
				e.preventDefault();
			}
		});
		
/* 		//페이지 이전 주소를 가져와서 저장
		var referrer = document.referrer;
// 		console.log(referrer);
		
		//li 클릭해서 이동시 뒤에 있는 태그들을 모두 삭제
		$(".before-address > li").click(function() {
			//history.back(); 뒤로가기
			//$(this).next().remove(); 자신의 뒤에 있는 요소들을 지움
			$(".before-address").append("<li>"+"성공"+"</li>");
		});
		
		//페이지 이동
		$(document).ready(function(){
			$(".before-address").each(function(){
				$(this).append("<li>"+referrer+"</li>");	
			console.log(referrer);
			});
			
		});
		
		
		
// 		$(window).on("beforeunload", function(){
// 			$(".before-address").append("<li>"+"성공"+"</li>");
// 			alert("성공"+referrer);
// 			console.log("성공");
// 			<a href="#"><li>여기가 거기</li></a>
// 		}); */
		 
	});

</script>


<div class="mt-4">&nbsp;</div>    

<footer class="text-center text-white">
  <!-- Grid container -->
  <div class="container pt-4">
    <!-- Section: Social media -->
    <section class="mb-4">

      <a class="col-2 btn btn-floating btn-md text-dark" href="${pageContext.request.contextPath}/admin/">
         <img class="w-100" src="${pageContext.request.contextPath}/images/logo.png"/>
      </a>

      <a class="col-2 btn btn-floating btn-md text-dark" href="#">이용약관</a>

      <a class="col-2 btn btn-floating btn-md text-dark" href="#">개인정보 처리 방침</a>

      <a class="col-2 btn btn-floating btn-md text-dark" href="#">고객센터</a>

      <a class="col-2 btn btn-floating btn-md text-dark" href="#">고객센터 02-1111-1111</a>

    </section>
    <!-- Section: Social media -->
  </div>
  <!-- Grid container -->

  <!-- Copyright -->
  <div class="text-center text-dark p-3" style="background-color: #f1f1f1;">
    &copy; Last-dance Corp. All rights reserved.
  </div>
  <!-- Copyright -->
</footer>
    <!-- Optional JavaScript; choose one of the two! -->

    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>

    <!-- Option 2: Separate Popper and Bootstrap JS -->
    <!--
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    -->
</body>
</html>