<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- 현재 시간 -->
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<c:set var="today">
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/>
</c:set>

<div class="container-600 mt-30">
		<table class="table table-slit">
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
					<td colspan="3" class="w-75">
						<pre style="font-family: 'Noto Sans KR', sans-serif; font-size:16px !important;">${noticeDto.noticeContent}</pre>
					</td>
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

<div class="row center">
	<a class="btn yellow-btn return-btn">돌아가기</a>
</div>

</div>
<script>
	$(function(){
		$(".return-btn").click(function(){
			history.back();
		});
	});
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>