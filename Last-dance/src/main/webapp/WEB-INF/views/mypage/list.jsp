<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param name="title" value="����������"/>
</jsp:include>

<h2>Test</h2>
<c:forEach var="list" items="${list}">
	<ul>
		<li>����: ${list.recipeTitle}</li>
	</ul>
	
</c:forEach>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>