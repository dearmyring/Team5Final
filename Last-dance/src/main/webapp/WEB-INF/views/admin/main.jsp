<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>



<style>
	.admin-main-container {
		width: 1200px;
		margin: auto;
	}

	.chart-list {
		display: flex;
		flex-direction: column;
		flex-wrap: wrap;
		align-items: center;
	}
	
	.user-active {
		display: flex;
		flex-direction: row;
		justify-content: space-around;
		width: 100%;
	}
	
	.top-recipe {
		display: flex;
		flex-direction: column;
		justify-content: space-around;
		width: 100%;
	}
	
	.top-recipe > div {
		display: flex;
		justify-content: space-around;
	}
	
	.top-list {
		display: flex;
		flex-direction: row;
		flex-wrap: wrap;
		margin-bottom: 100px;
		justify-content: space-between;
	}
	
	.chart-box {
		width: 400px;
		height: 400px;
		margin-bottom: 100px;
	}
	
	.lately-join-user > .chart-box {
		width: 700px;
	}
	
	.top-recipe > div:nth-child(2) > .chart-box {
		width: 700px;
	}
	
	.chart-box > p {
		margin-bottom: 50px;
		text-align: center;
	}
	
	.top-five-box {
		width: 580px;
	}
	
	.top-five-list {
		text-align: center;
	}
	
	.top-five-item  {
		border-bottom: 1px solid #E7E7E7;
		height: 30px;
	}
	
	thead > .top-five-item {
		border-bottom: 1px solid #373A3C;
	}
	
	.top-five-item > td {
		vertical-align: middle;
	}

	.top-five-item:hover {
		background-color: #F7F7F7;
		color: black;
	}
	
	 .top-five-item td:nth-child(2) {
		text-align: left;
	}
	
	.tfi-title > a {
		display: block;
		width: 100%;
		color: #373A3C;
	}
	
	.tfi-no,
	.tfi-time,
	.tfi-writer {
		width: 100px;
	}
	
	.tfi-title {
		width: 400px;
	}
	
</style>

<div class="mt-5">&nbsp;</div>
<div class="mt-5">&nbsp;</div>

<div class="admin-main-container">
	<h1 style="text-align: center; color: pink;">
		<i class="fa-solid fa-poo"></i>
		미농이 페이지
		<i class="fa-solid fa-poo"></i>
	</h1>
	
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
						<td class="tfi-title"><a href="recipe/detail/${recipeTopFive.recipeNo}">${recipeTopFive.recipeTitle}</a></td>
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
	    
    
    </div>
    
</div>



<!-- jquery를 사용하기 위하여 라이브러리 js 파일을 불러온다 -->
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script>
$(function(){
	//최근 일주일 가입자 수
	$.ajax({
		url: "http://localhost:8888/rest/member-count",
		method: "get",
		dataType: "json",
		success: function(resp) {
//  			console.log(resp);
			//비어있는 배열 2개를 만들고 resp의 데이터를 분산 저장
            var labels = [];
            var values = [];
            for(var i = 0; i < resp.length; i++) {
	            labels.push(resp[i].join);
	            values.push(resp[i].cnt); 
            }
            
                const ctx = document.querySelector('#memberChart');
                const myChart = new Chart(ctx, {
                    //type: 'bar',
                     type: 'line',
                    // type: 'doughnut',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '가입자 수',
                            data: values,
                            backgroundColor: [
                            	'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(255, 159, 64, 0.2)'
                            ],
                            borderColor: [
                            	'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)'
                            ],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
			
		}//success end
		
	});
	//ajax() end
	
	//오늘의 인기 검색어 1~10위
	$.ajax({
		url: "http://localhost:8888/rest/trending-searches",
		method: "get",
		dataType: "json",
		success: function(resp) {
			//비어있는 배열 2개를 만들고 resp의 데이터를 분산 저장
            var labels = [];
            var values = [];
            for(var i = 0; i < resp.length; i++) {
	            labels.push(resp[i].searchIngredient+" (검색 순위: "+resp[i].rn+"위)");
	            values.push(resp[i].cnt); 
            }
            
                const ctx = document.querySelector('#trendingSearchesChart');
                const myChart = new Chart(ctx, {
                    //type: 'bar',
                    // type: 'line',
                     //type: 'doughnut',
                     type: 'pie',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '검색 횟수',
                            data: values,
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(255, 159, 64, 0.2)'
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)'
                            ],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
			
		}//success end
		
	});
	//ajax() end
	
	
	//오늘 가장 많은 좋아요 레시피 탑5
	$.ajax({
		url: "http://localhost:8888/rest/recipe-today-like-top",
		method: "get",
		dataType: "json",
		success: function(resp) {
			//비어있는 배열 2개를 만들고 resp의 데이터를 분산 저장
            var labels = [];
            var values = [];
            for(var i = 0; i < resp.length; i++) {
	            labels.push(resp[i].recipeTitle+" (좋아요 수: "+resp[i].rn+"위)");
	            values.push(resp[i].cnt); 
            }
            
                const ctx = document.querySelector('#recipeTodayLikeTopFiveChart');
                const myChart = new Chart(ctx, {
                    type: 'bar',
                    // type: 'line',
                     //type: 'doughnut',
                     //type: 'pie',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '좋아요 수',
                            data: values,
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(255, 159, 64, 0.2)'
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)'
                            ],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
			
		}//success end
		
	});
	//ajax() end
	
	//최근 일주일 조회 수 높은 레시피 탑5
	$.ajax({
		url: "http://localhost:8888/rest/lately-top-view-recipe",
		method: "get",
		dataType: "json",
		success: function(resp) {
			//비어있는 배열 2개를 만들고 resp의 데이터를 분산 저장
            var labels = [];
            var values = [];
            for(var i = 0; i < resp.length; i++) {
	            labels.push(resp[i].recipeTitle+" (조회 수: "+resp[i].rn+"위)");
	            values.push(resp[i].cnt); 
            }
            
                const ctx = document.querySelector('#latelyTopViewRecipeChart');
                const myChart = new Chart(ctx, {
                    type: 'bar',
                    // type: 'line',
                     //type: 'doughnut',
                     //type: 'pie',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '조회 수',
                            data: values,
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(255, 159, 64, 0.2)'
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)'
                            ],
                            borderWidth: 1
                        }]
                    },
                    options: {
                    	plugins:{
                            legend: {
                                display: false
                            },
                        },
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
			
		}//success end
		
	});
	//ajax() end
	
	//오늘 조회 수 높은 레시피 탑5
	$.ajax({
		url: "http://localhost:8888/rest/today-top-view-recipe",
		method: "get",
		dataType: "json",
		success: function(resp) {
			//비어있는 배열 2개를 만들고 resp의 데이터를 분산 저장
            var labels = [];
            var values = [];
            for(var i = 0; i < resp.length; i++) {
	            labels.push(resp[i].recipeTitle+" (조회 수: "+resp[i].rn+"위)");
	            values.push(resp[i].cnt); 
            }
            
                const ctx = document.querySelector('#todayTopViewRecipeChart');
                const myChart = new Chart(ctx, {
                    type: 'bar',
                    // type: 'line',
                     //type: 'doughnut',
                     //type: 'pie',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '조회 수',
                            data: values,
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(255, 159, 64, 0.2)'
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)'
                            ],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
			
		}//success end
		
	});
	//ajax() end
	
	//최근 일주일 좋아요 레시피 탑5
	$.ajax({
		url: "http://localhost:8888/rest/lately-top-like-recipe",
		method: "get",
		dataType: "json",
		success: function(resp) {
			//비어있는 배열 2개를 만들고 resp의 데이터를 분산 저장
            var labels = [];
            var values = [];
            for(var i = 0; i < resp.length; i++) {
	            labels.push(resp[i].recipeTitle+" (좋아요 수: "+resp[i].rn+"위)");
	            values.push(resp[i].cnt); 
            }
            
                const ctx = document.querySelector('#latelyTopLikeRecipeChart');
                const myChart = new Chart(ctx, {
                    type: 'bar',
                    // type: 'line',
                     //type: 'doughnut',
                     //type: 'pie',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '좋아요 수',
                            data: values,
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(255, 159, 64, 0.2)'
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)'
                            ],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        },
                        legend: {
                            display: false,
                            labels: {
                                fontColor: 'rgb(255, 99, 132)'
                            }
                        }
                    }
                });
			
		}//success end
		
	});
	//ajax() end
	
	//오늘 가장 많은 게시글을 쓴 사람 탑5
	$.ajax({
		url: "http://localhost:8888/rest/today-top-writer",
		method: "get",
		dataType: "json",
		success: function(resp) {
			//비어있는 배열 2개를 만들고 resp의 데이터를 분산 저장
            var labels = [];
            var values = [];
            for(var i = 0; i < resp.length; i++) {
	            labels.push(resp[i].memberNick+"("+resp[i].memberId+")"+" (작성 글 수: "+resp[i].rn+"위)");
	            values.push(resp[i].cnt); 
            }
            
                const ctx = document.querySelector('#todayTopWriterChart');
                const myChart = new Chart(ctx, {
                    type: 'bar',
                    // type: 'line',
                     //type: 'doughnut',
                     //type: 'pie',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '작성 글 수',
                            data: values,
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                                'rgba(255, 206, 86, 0.2)',
                                'rgba(75, 192, 192, 0.2)',
                                'rgba(153, 102, 255, 0.2)',
                                'rgba(255, 159, 64, 0.2)'
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 206, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(153, 102, 255, 1)',
                                'rgba(255, 159, 64, 1)'
                            ],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
			
		}//success end
		
	});
	//ajax() end
	
	
	
});
</script>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>