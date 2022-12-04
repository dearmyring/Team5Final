<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param name="title" value="����������"/>
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
				<p>���ƿ�</p><p>${myLike.myLikeListCount}</p>
			</li>
		</ul>
		<div>
			<a href="pwConfirm">��������</a>
		</div>
	</div>
</div>
	
<c:forEach var="viewList" items="${viewList}">
	
	
	<ul>
		<li>�ֱ� �� ����: ${viewList.recipeTitle}</li>
	</ul>
	
</c:forEach>

<c:forEach var="likeList" items="${likeList}">
	<ul>
		<li>���ƿ� ����: ${likeList.recipeTitle}</li>
	</ul>
</c:forEach>

<c:forEach var="writeList" items="${writeList}">
	<ul>
		<li>���� �� �� ����: ${writeList.boardTitle}</li>
	</ul>
</c:forEach>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>