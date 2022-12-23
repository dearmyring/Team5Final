<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin-main.css">

<!-- chart.js cdn 불러옴 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- js 불러옴 -->
<script src="${pageContext.request.contextPath}/js/admin-main.js"></script>


<div class="mt-5">&nbsp;</div>
<div class="mt-5">&nbsp;</div>

<div class="admin-main-container">
	<div class="top-list">
		<!-- 인기 레시피 탑 5 -->
		<div class="top-five-box">
			<h3>인기 레시피</h3>
			<table class="top-five-list">
				<thead>
					<tr class="top-five-item">
						<th class="tfi-no">번호</th>
						<th class="tfi-title">제목</th>
						<th class="tfi-time">소요시간</th>
						<th class="tfi-writer">작성자</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="recipeTopFive" items="${recipeTopFive}">
					<tr class="top-five-item">
						<td class="tfi-no">${recipeTopFive.recipeNo}</td>
						<td class="tfi-title text-cutter">
							<a href="recipe/detail/${recipeTopFive.recipeNo}">${recipeTopFive.recipeTitle}</a>
						</td>
						<td class="tfi-time">${recipeTopFive.recipeTime}</td>
						<td class="tfi-writer">${recipeTopFive.recipeNick}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>	
		</div>
		
		<!-- 인기 게시글 탑 5(닉네임까지 찍히도록 쿼리 수정해야함) -->
		<div class="top-five-box">
			<h3>인기 게시글</h3>
			<table class="top-five-list">
				<thead>
					<tr class="top-five-item">
						<th class="tfi-no">번호</th>
						<th class="tfi-title">제목</th>
						<th class="tfi-time">작성시간</th>
						<th class="tfi-writer">작성자</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="boardTopFive" items="${boardTopFive}">
					<tr class="top-five-item">
						<td class="tfi-no">${boardTopFive.boardNo}</td>
						<td class="tfi-title"><a href="board/detail/${boardTopFive.boardNo}">${boardTopFive.boardTitle}</a></td>
						<td class="tfi-time">
						<fmt:formatDate value="${boardTopFive.boardWriteTime}" pattern="yy.MM.dd"/>
						</td>
						<td class="tfi-writer">${boardTopFive.boardId}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>	
		</div>
	</div>
	<!-- top-list end -->
	
	<!-- 차트 시작  -->
	<div class="chart-list">
		<div class="lately-join-user">
			<div class="chart-box">
				<p>최근 일주일 가입자 수</p>
		        <canvas id="memberChart"></canvas>
		    </div>
		</div>
		
	    <div class="user-active">
	    	<div class="chart-box">
			    <p>오늘의 인기 검색어 탑10</p>
		    	<canvas id="trendingSearchesChart"></canvas>
		    </div>
	    	<div class="chart-box">
			    <p>오늘 가장 많은 게시글을 쓴 사람 TOP 5</p>
		    	<canvas id="todayTopWriterChart"></canvas>
		    </div>
	    </div>
	    <!-- user-active end -->
	    
	    <div class="top-recipe">
	    	<div>
	    		<div class="chart-box">
				    <p>오늘 가장 많은 좋아요를 받은 레시피 TOP 5</p>
			    	<canvas id="recipeTodayLikeTopFiveChart"></canvas>
			    </div>
			    
			    <div class="chart-box">
				    <p>최근 일주일 조회 수 높은 레시피 TOP 5</p>
			    	<canvas id="latelyTopViewRecipeChart"></canvas>
			    </div>
	    	</div>
			<div>
				<div class="chart-box">
				    <p>오늘 최고 조회 수 레시피 TOP 5</p>
			    	<canvas id="todayTopViewRecipeChart"></canvas>
			    </div>
			    
			    <div class="chart-box">
				    <p>최근 일주일 좋아요 수 높은 레시피 TOP 5</p>
			    	<canvas id="latelyTopLikeRecipeChart"></canvas>
			    </div>
			</div>
	    </div>
	    <!-- top-recipe end  -->
	    
    </div>
    <!-- chart-list end -->
    
</div>


<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>