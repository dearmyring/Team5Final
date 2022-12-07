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
				<form class="edit-form" action="edit_pw" method="post">
				
					<label for=".input" class="helper-text">비밀번호를 변경하세요.</label>
					<input name="memberId" value="${memberDto.memberId}" type="hidden">
					<div>
						<input class="input w-100 mt-10" name="memberPw" type="password" 
						placeholder="비밀번호" autocomplete="off">
						<div class="mt-5 help-text"></div>
					</div>
					<div>
						<input class="input w-100 mt-10" id="memberPwChecking" type="password" 
						placeholder="비밀번호 확인" autocomplete="off">
						<div class="mt-5 help-text"></div>
					</div>					
					<button class="w-100 mt-10 btn btn-positive" type="submit">비밀번호 변경</button>
				</form>
				<span class="join-fail"></span>
			</div>
		</div>
		
		<!-- jQuery 시작 -->
		<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
    	<script>
    		$(function(){
    			var validChecking = {
   	                memberPwValid: false,
   	                memberPwChecking: false,
   	                memberPwRegex: /^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[a-zA-Z0-9!@#$]{8,16}$/,
   	                isAllValid: function() {
   	                    return this.memberPwValid && this.memberPwChecking;
   	                }
   	            };
    			$("input[name=memberPw]").blur(function(){
                    var memberPw = $(this).val();
                    var regex = validChecking.memberPwRegex;
                    $("input[name=memberPw]").next("div").text("");
                    
                    if(regex.test(memberPw)) {
                        validChecking.memberPwValid = true;
                    } else {
                        validChecking.memberPwValid = false;
                        $("input[name=memberPw]").next("div").text("비밀번호 형식이 맞지 않습니다.");
                    }
                });

                $("#memberPwChecking").blur(function(){
                    var memberPwChecking = $(this).val();
                    var memberPwOrigin = $("input[name=memberPw]").val();
                    $("#memberPwChecking").next("div").text("");
                    if(memberPwChecking === memberPwOrigin) {
                        validChecking.memberPwChecking = true;
                        $("#memberPwChecking").next("div").text("비밀번호가 일치합니다.");
                    } else {
                        validChecking.memberPwChecking = false;
                        $("#memberPwChecking").next("div").text("비밀번호를 재확인하세요.");
                    }
                });
                
                $(".edit-form").submit(function(e){
                    e.preventDefault();
                    
                    $(this).find("input").blur();
                    
                    console.log(validChecking.isAllValid());
                    
                    if(validChecking.isAllValid()) {
                       	this.submit();
                    } else {
                    	$(".join-fail").text("입력 사항을 확인해 주세요.").addClass("help-text mt-5");
                    }
                });
                
    		});
    	</script>
	</body>
</html>