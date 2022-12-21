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

<div class="mt-3">&nbsp;</div>
<div class="mt-3">&nbsp;</div>

<div class="history-link text-end"> 
	<a class="main-page-link"></a> <i class="fa-solid fa-chevron-right"></i> 
	<a href="../list">공지사항</a> <i class="fa-solid fa-chevron-right"></i> 상세보기
</div>


<div class="container-fluid mt-5">
<div class="row mt-5">
	<div class="col-lg-6 offset-lg-3 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<table class="table">
			<tbody>
				<tr>
					<th>No.</th>
					<td>${boardDto.boardNo}</td>
					<th>조회수</th>
					<td>${boardDto.boardClick}</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td colspan="3">${boardDto.memberNick}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td colspan="3">${boardDto.boardTitle}</td>
<!-- 					<th>조회수</th> -->
<%-- 					<td colspan="3">>${boardDto.boardClick}</td> --%>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3" class="w-75">
						<!-- pre 태그는 엔터, 띄어쓰기, 탭키 등을 있는 그대로 표시하는 영역 -->
						<pre>${boardDto.boardContent}</pre>
						<img src="${pageContext.request.contextPath}/rest/download/${boardImgDto.boardAttachmentNo}">
					</td>
				</tr>	
				<tr>
					<th>작성시간</th>
					<td>				
							<fmt:formatDate value="${boardDto.boardWriteTime}" pattern="yyyy-MM-dd"/>
					</td>
					<td>
						<c:if test="${boardDto.boardEditTime != null}">
							수정시간
						</c:if>
					</td>
					<td>
						<c:if test="${boardDto.boardEditTime != null}">
							<c:set var="editCurrent">
								<fmt:formatDate value="${boardDto.boardEditTime}" pattern="yyyy-MM-dd"/>
							</c:set>
							<c:choose>
								<c:when test="${today == editCurrent}">
									<fmt:formatDate value="${boardDto.boardEditTime}" 
																pattern="HH:mm"/>
								</c:when>
								<c:otherwise>
									<fmt:formatDate value="${boardDto.boardEditTime}" 
																pattern="yyyy-MM-dd"/>
								</c:otherwise>
							</c:choose>
						</c:if>
						
			<c:if test="${attachmentList != null}">
				<tr>
					<th>첨부파일</th>
					<td>
						<ul class="attachment-list">
							<c:forEach var="attachmentDto" items="${attachmentList}">
							<li>
								${attachmentDto.attachmentName} 
								(${attachmentDto.attachmentSize} bytes) 
								- 
								[${attachmentDto.attachmentType}]
								<a href="/attachment/download/${attachmentDto.attachmentNo}"><img src="/images/download.png" width="15" height="15"></a>
							</li>
							</c:forEach>
						</ul>
					</td>
				</tr>
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
			<div class="col-8">
				<a class="btn btn-md yellow-btn" href="../list">돌아가기</a>
			</div>
		</div>
	</div>
</div>
</div>

<script type="text/javascript">
    $(function(){
    	$(".delete-btn").click(function(e){
    		
    		var choice = confirm("정말 삭제하시겠습니까?");
    		if(!choice){
    			e.preventDefault();
    		}
    	});
    });
</script>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>