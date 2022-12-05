<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
<h3>레시피등록</h3>
<form action="write" method="post">
<select>
	<c:forEach var="hashtagDto" items="${hashtagList}">
		<option>${hashtagDto.hashtagName}</option>
	</c:forEach>
	<c:forEach var="ingredientDto" items="${ingredientList}">
		<option>${ingredientDto.ingredientCategory}</option>
	</c:forEach>
</select>
</form>
<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>