<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<!-- 현재 시간 -->
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<c:set var="today">
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/>
</c:set>

<div class="mt-5">&nbsp;</div>
<h3>공지사항 상세</h3>

<table class="table">
	<tbody>
		<tr>
			<th>No.</th>
			<td>${noticeDto.noticeNo}</td>
			<th>조회수</th>
			<td>${noticeDto.noticeClick}</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td colspan="3">${noticeDto.noticeNick}</td>
		</tr>
		<tr>
			<th>제목</th>
			<td colspan="3">${noticeDto.noticeTitle}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="3">${noticeDto.noticeContent}</td>
		</tr>
	</tbody>
</table>

작성시간
<c:set var="writeCurrent">
	<fmt:formatDate value="${noticeDto.noticeWritetime}" pattern="yyyy-MM-dd"/>
</c:set>
<c:choose>
	<c:when test="${today == writeCurrent}">
		<fmt:formatDate value="${noticeDto.noticeWritetime}" 
									pattern="HH:mm"/>
	</c:when>
	<c:otherwise>
		<fmt:formatDate value="${noticeDto.noticeWritetime}" 
									pattern="yyyy-MM-dd"/>
	</c:otherwise>
</c:choose>

<c:if test="${noticeDto.noticeEdittime != null}">
수정시간
	<c:set var="editCurrent">
		<fmt:formatDate value="${noticeDto.noticeEdittime}" pattern="yyyy-MM-dd"/>
	</c:set>
	<c:choose>
		<c:when test="${today == editCurrent}">
			<fmt:formatDate value="${noticeDto.noticeEdittime}" 
										pattern="HH:mm"/>
		</c:when>
		<c:otherwise>
			<fmt:formatDate value="${noticeDto.noticeEdittime}" 
										pattern="yyyy-MM-dd"/>
		</c:otherwise>
	</c:choose>
</c:if>

<a href="../update?noticeNo=${noticeDto.noticeNo}">수정하기</a>
<a href="../list">돌아가기</a>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>