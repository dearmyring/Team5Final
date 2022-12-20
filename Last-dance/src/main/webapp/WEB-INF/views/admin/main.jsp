<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>



<style>
	.chart-list {
		width: 1200px;
		margin: auto;
		display: flex;
		flex-direction: row;
		flex-wrap: wrap;
		justify-content: center;
	}
	.chart-box {
		width: 400px;
		height: 400px;
	}
	.recipe-top-five-box {
		width: 700px;
	}
	.recipe-top-five-list {
		display: flex;
		flex-direction: column;
	}
	.recipe-top-five-item {
		display: flex;
		flex-direction: row;
	}
	.recipe-top-five-list .recipe-top-five-item li {
		display: flex;
		justify-content: center;
		border: 1px solid black;
	}
	.recipe-top-five-list > li:nth-child(2) > .recipe-top-five-item li:nth-child(2) {
		justify-content: flex-start;
	}
	.rtfi-no {
		width: 100px;
	}
	.rtfi-title {
		width: 400px;
	}
	.rtfi-time {
		width: 100px;
	}
	.rtfi-writer {
		width: 100px;
	}
	
</style>

<div class="mt-5">&nbsp;</div>
<div class="mt-5">&nbsp;</div>

<!-- 총 회원수 / 오늘 가입자 수 -->
<div>
	<h1>미농이 페이지</h1>
	<div class="chart-list">
		<div class="recipe-top-five-box">
			<ul class="recipe-top-five-list">
				<li>
					<ul class="recipe-top-five-item">
						<li class="rtfi-no">번호</li>
						<li class="rtfi-title">제목</li>
						<li class="rtfi-time">소요시간</li>
						<li class="rtfi-writer">작성자</li>
					</ul>
				</li>
				<li>
				<c:forEach var="recipeTopFive" items="${recipeTopFive}">
					<ul class="recipe-top-five-item">
						<li class="rtfi-no">${recipeTopFive.recipeNo}</li>
						<li class="rtfi-title">${recipeTopFive.recipeTitle}</li>
						<li class="rtfi-time">${recipeTopFive.recipeTime}</li>
						<li class="rtfi-writer">${recipeTopFive.recipeNick}</li>
					</ul>
				</c:forEach>
				</li>
			</ul>
			
		</div>
	
		<div class="chart-box">
			<span>최근 일주일 가입자 수(이건 포기 못함)</span>
	        <canvas id="memberChart"></canvas>
	    </div>
	    
	    <div class="chart-box">
		    <span>오늘의 인기 검색어 탑10(이건 포기 못함)</span>
	    	<canvas id="trendingSearchesChart"></canvas>
	    </div>
	    
	    <div class="chart-box">
		    <span>현재 최고 조회수 레시피 TOP 5(리스트로 뽑아서 필요 없음)</span>
	    	<canvas id="recipeTopFiveChart"></canvas>
	    </div>
	    
	    <div class="chart-box">
		    <span>오늘 가장 많은 좋아요를 받은 레시피 TOP 5</span>
	    	<canvas id="recipeTodayLikeTopFiveChart"></canvas>
	    </div>
	    
	    <div class="chart-box">
		    <span>최근 일주일 조회 수 높은 레시피 TOP 5</span>
	    	<canvas id="latelyTopViewRecipeChart"></canvas>
	    </div>
	    
	    <div class="chart-box">
		    <span>오늘 최고 조회 수 레시피 TOP 5</span>
	    	<canvas id="todayTopViewRecipeChart"></canvas>
	    </div>
	    
	    <div class="chart-box">
		    <span>최근 일주일 좋아요 수 높은 레시피 TOP 5</span>
	    	<canvas id="latelyTopLikeRecipeChart"></canvas>
	    </div>
	    
	    <div class="chart-box">
		    <span>오늘 가장 많은 게시글을 쓴 사람 TOP 5</span>
	    	<canvas id="todayTopWriterChart"></canvas>
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
	
	//현재 최고 조회수 레시피 TOP 5
	$.ajax({
		url: "http://localhost:8888/rest/view-top-five",
		method: "get",
		dataType: "json",
		success: function(resp) {
			//비어있는 배열 2개를 만들고 resp의 데이터를 분산 저장
            var labels = [];
            var values = [];
            for(var i = 0; i < resp.length; i++) {
	            labels.push(resp[i].recipeTitle+" (조회 수: "+resp[i].rn+"위)");
	            values.push(resp[i].recipeClick); 
            }
            
                const ctx = document.querySelector('#recipeTopFiveChart');
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