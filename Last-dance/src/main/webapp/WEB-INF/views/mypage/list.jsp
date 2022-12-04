<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param name="title" value="메인페이지"/>
</jsp:include>

<h2>Test</h2>

<div>
	<div>
	
	</div>
	<div>
		<ul>
			<li>
				${myInfo.memberNick}
			</li>
			<li>
				<p>좋아요</p><p>${myLike.myLikeListCount}</p>
			</li>
		</ul>
		<div>
			<a href="pwConfirm">정보변경</a>
		</div>
	</div>
</div>
	
<c:forEach var="viewList" items="${viewList}">
	
	
	<ul>
		<li>최근 본 제목: ${viewList.recipeTitle}</li>
	</ul>
	
</c:forEach>

<c:forEach var="likeList" items="${likeList}">
	<ul>
		<li>좋아요 제목: ${likeList.recipeTitle}</li>
	</ul>
</c:forEach>

<c:forEach var="writeList" items="${writeList}">
	<ul>
		<li>내가 쓴 글 제목: ${writeList.boardTitle}</li>
	</ul>
</c:forEach>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>