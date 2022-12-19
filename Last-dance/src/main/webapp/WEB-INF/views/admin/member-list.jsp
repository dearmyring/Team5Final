<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<div class="mt-5">&nbsp;</div>

<div class="text-end">
	<a class="main-page-link"></a> > 회원 리스트
</div>

<form action="list" method="get">

<div class="container-fluid mt-5">
<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<select name="sort">
			<option value="member_join desc">최근 가입일 순</option>
			<option value="member_login desc">최근 방문자 순</option>
			<option value="member_disabled desc">비활성화 순</option>
		</select>
	</div>
</div>

<div class="row mt-3">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<table class="table table-sm">
			<thead>
				<tr class="text-center">
					<th>아이디</th>
					<th>닉네임</th>
					<th>전화번호</th>
					<th>성별</th>
					<th>포인트</th>
					<th>가입일</th>
					<th>최근접속일</th>
					<th>비활성화</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="memberDto" items="${memberList}">
					<tr class="text-center">
						<td class="text-start">${memberDto.memberId}</td>
						<td>${memberDto.memberNick}</td>
						<td>
							<fmt:formatNumber var="phoneNo" value="${memberDto.memberPhone}" pattern="###,####,####" minIntegerDigits="11" />
							<c:out value="${fn:replace(phoneNo, ',', '-')}" />
						</td>
						<td>${memberDto.memberGender}</td>
						<td>
							<fmt:formatNumber value="${memberDto.memberPoint}" pattern="#,##0"/>
						</td>
						<td>${memberDto.memberJoin}</td>
						<td>${memberDto.memberLogin}</td>
						<td>
							<c:if test="${memberDto.memberDisabled == 'Y'}">
								<i class="fa-solid fa-y"></i>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<div class="row mt-3">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<ul class="pagination border-none-pagination" style="justify-content: center;">
		
			<c:choose>
				<c:when test="${voPagination.hasPrev()}">
					<li class="page-item">
						<a class="page-link prev-page">
							<i class="fa-solid fa-chevron-left"></i>
						</a>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link"><i class="fa-solid fa-chevron-left"></i></a>
				</c:otherwise>
			</c:choose>
			</li>
			
			<c:forEach var="i" begin="${voPagination.startBlock()}" end="${voPagination.endBlock()}" step="1">
				<c:choose>
					<c:when test="${voPagination.p != i}">
						<li class="page-item">
					</c:when>
					<c:otherwise>
						<li class="page-item active">
					</c:otherwise>
				</c:choose>
					<a class="page-link">${i}</a>
				</li>
			</c:forEach>
			
			<c:choose>
				<c:when test="${voPagination.hasNext()}">
					<li class="page-item">
						<a class="page-link next-page">
							<i class="fa-solid fa-chevron-right"></i>
						</a>
				</c:when>
				<c:otherwise>
					<li class="page-item disabled">
						<a class="page-link"><i class="fa-solid fa-chevron-right"></i></a>
				</c:otherwise>
			</c:choose>
			</li>
			
		</ul>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-4 offset-lg-4 col-md-8 offset-md-2 col-sm-10 offset-sm-1 text-center">
		<div class="row">
			<div class="col-3">
				<select name="type" class="input-type form-select w-100 pe-3" id="exampleSelect1">
					<option value="member_id">아이디</option>
					<option value="member_nick">닉네임</option>
				</select>
			</div>
			<div class="col-9">
				<div class="input-group rounded">
					<input aria-describedby="button-addon2" name="keyword" 
					class="input-keyword form-control" type="text" value="${voPagination.keyword}">
					<button class="btn-search" type="button" id="button-addon2">
						<img width="25px" src="${pageContext.request.contextPath}/images/search-admin.png">
					</button>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
</form>

<script type="text/javascript">
	$(function(){
		$("[name=sort]").on("input", function(){
		});
	});
</script>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>