<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<form action="join" method="post">
		<div>
			<div>이메일</div>
			<input name="memberId" type="text" 
			placeholder="이메일" autocomplete="off">
			<span></span>
		</div>
		<div>
			<button type="submit">이메일 인증하기</button>
		</div>
		<div>
			<div>비밀번호</div>
			<label>
				8~16글자, 특수문자 !@#$를 포함해서 입력해 주세요.
				<input name="memberPw" type="password" placeholder="비밀번호를 입력하세요.">
			</label>
			<span></span>
		</div>
		<div>
			<div>비밀번호 확인</div>
			<input type="password" placeholder="비밀번호를 확인하세요.">
			<span></span>
		</div>
		<div>
			<div>닉네임</div>
			<label>
				영문, 한글, 숫자 10자 이내로 입력해 주세요.
				<input name="memberNick" type="text" placeholder="사용하실 닉네임을 입력하세요.">
			</label>
			<span></span>		
		</div>
		<div>
			<div>
				<input type="radio" name="memberGender" value="M"> 남성
				<input type="radio" name="memberGender" value="F"> 여성
			</div>
			<span></span>
		</div>
		<div>
			<div>휴대폰 번호</div>
			<label>
				입력하신 휴대폰 정보는 마케팅 용도로 사용하지 않습니다.
				<input type="tel" name="memberPhone" placeholder="휴대폰 번호를 입력하세요.">
			</label>
			<span></span>
		</div>
		<div>
			<div>
				<div>이용약관</div>
				<input type="checkbox">전체동의		
				<input type="checkbox">이용약관<span>(필수)</span>		
				<input type="checkbox">개인정보수집 및 이용동의<span>(필수)</span>
			</div>
			<span></span>		
		</div>
		<button type="submit">회원가입하기</button>
	</form>
	<div>
		<span>이미 아이디가 있으신가요?</span>
		<span><a href="#">로그인</a></span>
	</div>
	
	<!-- js 검사 시작 -->
	<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
        <script>
            $(function(){
                // 상태객체
                var validChecking = {
                   	memberIdValid: false,
                    memberIdRegex: /^[a-zA-z0-9]{8,20}$/,
                    memberPwValid: false,
                    memberPwRegex: /^[a-zA-Z0-9!@#$]{8,16}$/,
                    memberPwChecking: false,
                    memberNickValid: false,
                    memberNickRegex: /^[a-zA-Z0-9가-힣]{1,10}$/,
                    memberPhoneValid: false,
                    memberPhoenRegex: /^010\d{7,8}$/
                    
                    isAllValid: function () {
                        return this
                        	.memberIdValid && this.memberPwValid && memberPwChecking
                        		&& memberNickValid, memberPhoneValid;
                    }
                }

                $("input[name=memberId]").blur(function(){
                    var memberId = $(this).val();
                    var regex = validChecking.memberIdRegex;
                    if(regex.test(memberId)) {
                        $.ajax({
                            url:"http://localhost:8888/rest/member/id",
                            method:"post",
                            data: {memberId:memberId},
                            success:function(resp){
                                if(resp == "NNNNY"){
                                    validChecking.memberIdValid = true;
                                    $("input[name=memberId]").next("span").text("사용할 수 있는 아이디입니다.")
                                }
                                else if(resp == "NNNNN") {
                                    validChecking.userIdValid = false;
                                    $("input[name=memberId]").next("span").text("이미 사용중인 아이디입니다.")
                                }
                            }
                        });
                    }
                });

                $("input[name=userPw]").blur(function(){
                    var userPw = $(this).val();
                    var regex = validChecking.userPwRegex;
                    if(regex.test(userPw)) {
                        validChecking.userPwValid = true;
                        $("input[name=userPw]").next("span").text("사용할 수 있는 비밀번호입니다.")
                    } else {
                        validChecking.userPwValid = false;
                        $("input[name=userPw]").next("span").text("비밀번호 형식이 맞지 않습니다.")
                    }
                });

                $("#userPwChecking").blur(function(){
                    var userPwChecking = $(this).val();
                    var userPwOrigin = $("[name=userPw]").val();
                    if(userPwChecking === userPwOrigin) {
                        validChecking.userPwChecking = true;
                        $("#userPwChecking").next("span").text("비밀번호가 일치합니다.")
                    } else {
                        validChecking.userPwValid = false;
                        $("#userPwChecking").next("span").text("비밀번호를 재확인하세요.")
                    }
                });

                $(".join-form").submit(function(e){
                    e.preventDefault();

                    $(this).find("input").blur();

                    if(validChecking.isAllValid()) {
                        this.submit();
                    }
                });
            });
        </script>
</body>
</html>