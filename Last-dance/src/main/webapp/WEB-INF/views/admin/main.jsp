<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>



<style>
	.member-chart-box,
	.trending-search-chart-box {
		width: 400px;
		height: 400px;
	}
</style>

<div class="mt-5">&nbsp;</div>
<div class="mt-5">&nbsp;</div>

<!-- 총 회원수 / 오늘 가입자 수 -->
<div>
	<h1>메인페이지</h1>
	<span>전체 회원 / 오늘 가입 수</span>
	<div class="member-chart-box">
        <canvas id="memberChart"></canvas>
    </div>
    <div class="trending-search-chart-box">
    	<canvas id="trendingSearchesChart"></canvas>
    </div>
</div>



<!-- jquery를 사용하기 위하여 라이브러리 js 파일을 불러온다 -->
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script>
$(function(){
	$.ajax({
		url: "http://localhost:8888/rest/member-count",
		method: "get",
		dataType: "json",
		success: function(resp) {
// 			console.log(resp);
			//비어있는 배열 2개를 만들고 resp의 데이터를 분산 저장
            var labels = [];
            var values = [];
            labels.push("전체 회원 수");
            labels.push("오늘 가입 수");
            values.push(resp.allCount); 
            values.push(resp.todayCount); 
            
                const ctx = document.querySelector('#memberChart');
                const myChart = new Chart(ctx, {
                    type: 'bar',
                    // type: 'line',
                    // type: 'doughnut',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '전체회원 / 가입자 수',
                            data: values,
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.2)',
                                'rgba(54, 162, 235, 0.2)',
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)',
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
	
	
	$.ajax({
		url: "http://localhost:8888/rest/trending-searches",
		method: "get",
		dataType: "json",
		success: function(resp) {
			console.log(resp);
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
	
	
});
</script>

<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>