<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="mt-5">&nbsp;</div>
<h3>공지사항 리스트</h3>
<c:forEach var="noticeDto" items="${noticeList}">
	${noticeDto.noticeNo}
	<a href="detail/${noticeDto.noticeNo}">${noticeDto.noticeTitle}</a>
	${noticeDto.noticeNick}
</c:forEach>

<a href="write">작성하기</a>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include><!DOCTYPE html>
