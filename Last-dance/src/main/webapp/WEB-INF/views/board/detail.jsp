<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="자유 게시판" name="title"/>
</jsp:include>

<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

<script>
$(document).ready(function () {
	let like_count = document.getElementById('board_like')
	let likeval = document.getElementById('like_check').value
	const board_no = '${board_no}';
	const board_id = "${sessionScope.loginId}";
	const likeimg = document.getElementById("likeimg")

	if (likeval > 0) {
		likeimg.src = "/resources/img/좋아요후.png";
	}
	else {
		likeimg.src = "/resources/img/좋아요전.png";
	}
    // 좋아요 버튼을 클릭 시 실행되는 코드
$(".likeimg").on("click", function () {
	$.ajax({
      url: '/board/like',
      type: 'POST',
      data: { 'board_no': board_no, 'board_id': board_id },
      success: function (data) {
          if (data == 1) {
              $("#likeimg").attr("src", "/resources/img/좋아요후.png");
              location.reload();
          } else {
              $("#likeimg").attr("src", "/resources/img/좋아요전.png");
              location.reload();
          }
      }, error: function () {
          $("#likeimg").attr("src", "/resources/img/좋아요후.png");
          console.log('오타 찾으세요')
      }

  });

  });
  });
     </script>
     
     <body>
<c:if test="${sessionScope.loginId == null || sessionScope.loginId eq 'guest'}">
	<img src="/resources/img/좋아요전.png" id="likeimg" width="60px" height="60px"
		class="rounded-circle mt-2">
		${b.like_count} <br><br>
	추천 기능은 <a href="/member/login" type="button" id="newLogin"
	class="btn btn-outline-success">로그인</a> 후 사용 가능합니다.
	</c:if>
	<c:if test="${sessionScope.loginId != null}">
		<div>
	<input type="hidden" id="like_check" value="${like.like_check}">
	<img class="rounded-circle likeimg" id="likeimg" src="/resources/img/좋아요전.png"
	width="60px" height="60px"> ${b.like_count}
	</div>
	</c:if>
    </body>