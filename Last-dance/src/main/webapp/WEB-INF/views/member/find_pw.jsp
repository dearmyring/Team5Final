<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
		<!-- css commons -->
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/commons-ring-join.css">
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css">
		<title>이메일 인증</title>
	</head>
	<style>
		
	</style>
	<body>
		<div class="container-300 screen-center">
			<div class="center">
				<a href="/">
					<img src="/images/logo.png" style="width: 80%">
				</a>
			</div>
			<div class="mt-20">
				<form class="join-form" action="find_pw" method="post">
					<label for="input" class="helper-text">가입한 이메일을 입력해주세요.</label>
					<input class="input w-100 mt-10" name="memberId" type="text" 
					placeholder="이메일" autocomplete="off">
					<button class="w-100 mt-10 send-btn btn" type="button" disabled>이메일 확인</button>
					<div class="mt-5 help-text"></div>
					<div class="cert"></div>
				</form>
			</div>
		</div>
		
		<!-- jQuery 시작 -->
		<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
    	<script>
    		$(function(){
    			var validChecking = {
   	            	memberIdValid: false,
   	            	memberIdConfirm: false,
   	            	isAllValid: function() {
   	            		return this.memberIdValid && this.memberIdConfirm;
   	            	}
    			}
    			
    			$(".join-form").submit(function(e){
                    e.preventDefault();
                });
    			
                $("input[name=memberId]").blur(function(){
                	var memberId = $(this).val();
                	var possible = $(".send-btn");
                	$("input[name=memberId]").next("button").next("div").text("");
	               	$.ajax({
                        url:"http://localhost:8888/rest/member/id",
                        method:"post",
                        data: {memberId:memberId},
                        success:function(resp) {
                            if(resp == "NNNNN") {
                           	 	possible.prop("disabled", false);
                               	validChecking.memberIdValid = true;
                            }
                            else if(resp == "NNNNY") {
                                validChecking.memberIdValid = false;
                                $("input[name=memberId]").next("button").next("div").text("가입된 이메일이 아닙니다.");
                            }
                        }
                    });
                });
    			$(".send-btn").click(function(){
    				var email = $("input[name=memberId]").val();
    				if (email.length == 0) return;
    				var btn = $(this);
    				btn.prop("disabled", true);
    				
    				$.ajax({
    					url:"${pageContext.request.contextPath}/member/send_email",
    					method:"post",
    					data:{certWho:email},
    					success: function() {
    						btn.prop("disabled", false);
    						
    						var div = $("<div>")
    						var input = $("<input>").addClass("input w-100 mt-10");
    						var button = $("<button>").attr("type", "button").text("번호 확인").addClass("btn w-100 mt-10");
    						
    						button.click(function(){
    							var serial = input.val();
    							if(serial.length != 6) return;
    							$.ajax({
    								url:"${pageContext.request.contextPath}/member/confirm_email",
    								method:"post",
    								data:{
    									certWho:email,
    									certSerial:serial
    								},
    								success:function(resp){
    									console.log(resp);
    									validChecking.memberIdConfirm = resp;
    									$(".join-form").submit();
    									//btn.text("인증 완료");
    									//button.remove();
    									//input.remove()
    									//btn.prop("disabled", true);
    								}
    							});
    						});
    						div.append(input).append(button);
    						$(".cert").html(div);
    					}
    				});
    			});
    		});
    	</script>
	</body>
</html>