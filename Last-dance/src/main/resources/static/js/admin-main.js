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
	
	
	
});