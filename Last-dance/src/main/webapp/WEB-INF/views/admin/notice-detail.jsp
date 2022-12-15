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

<div class="text-end">
	<a class="main-page-link"></a> > <a class="text-decoration-none text-dark" href="../list">공지사항</a> > 상세보기
</div>


<div class="container-fluid mt-5">
<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
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
					<td colspan="3" class="w-75">${noticeDto.noticeContent}</td>
				</tr>
				<tr>
					<th>작성시간</th>
					<td>						
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
					</td>
					<td>
						<c:if test="${noticeDto.noticeEdittime != null}">
							수정시간
						</c:if>
					</td>
					<td>
						<c:if test="${noticeDto.noticeEdittime != null}">
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
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<div class="row mt-3">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-6 text-end">
				<a class="btn btn-md yellow-btn" href="../update?noticeNo=${noticeDto.noticeNo}">수정하기</a>
			</div>
			<div class="col-6">
				<a class="btn btn-md yellow-btn" href="../list">돌아가기</a>
			</div>
		</div>
	</div>
</div>
</div>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>