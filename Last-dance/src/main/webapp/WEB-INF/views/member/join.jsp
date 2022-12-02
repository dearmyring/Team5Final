<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="냉장고를 부탁해" name="title"/>
</jsp:include>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<form class="join-form" action="join" method="post">
		<div>
			<div>이메일</div>
			<input name="memberId" type="text" 
			placeholder="이메일" autocomplete="off">
			<span></span>
		</div>
		<div>
			<!-- <button>이메일 인증하기</button> -->
		</div>
		<div>
			<div>비밀번호</div>
			<label for="member-pw">8~16글자, 특수문자 !@#$를 포함해서 입력해 주세요.</label>
				<input class="member-pw" name="memberPw" type="password" placeholder="비밀번호를 입력하세요.">
				<span></span>
			
		</div>
		<div>
			<div>비밀번호 확인</div>
			<input id="memberPwChecking" type="password" placeholder="비밀번호를 확인하세요.">
			<span></span>
		</div>
		<div>
			<div>닉네임</div>
			<label>
				영문, 한글, 숫자 10자 이내로 입력해 주세요.
				<input name="memberNick" type="text" placeholder="사용하실 닉네임을 입력하세요." autocomplete="off">
			</label>
			<span></span>		
		</div>
		<div>
			<div>
				<input type="radio" name="memberGender" value="M"> 남성
				<input type="radio" name="memberGender" value="F"> 여성
				<span></span>
			</div>
		</div>
		<div>
			<div>휴대폰 번호</div>
			<label>
				입력하신 휴대폰 정보는 마케팅 용도로 사용하지 않습니다.
				<input type="tel" name="memberPhone" placeholder="휴대폰 번호를 입력하세요.">
				<span></span>
			</label>
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
	
	<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
    <script>
        $(function(){
         
            var validChecking = {
               	memberIdValid: true,
                memberPwValid: false,
                memberPwRegex: /^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[a-zA-Z0-9!@#$]{8,16}$/,
                memberPwChecking: false,
                memberNickValid: false,
                memberNickRegex: /^[a-zA-Z0-9가-힣]{1,10}$/,
                memberPhoneValid: false,
                memberPhoneRegex: /^010\d{7,8}$/,
                
                isAllValid: function () {
                    return this.memberIdValid && this.memberPwValid && this.memberPwChecking && this.memberNickValid, this.memberPhoneValid;
                }
            }

            $("input[name=memberPw]").blur(function(){
                var memberPw = $(this).val();
                var regex = validChecking.memberPwRegex;
                
                if(regex.test(memberPw)) {
                    validChecking.memberPwValid = true;
                    $("input[name=memberPw]").next("span").text("사용할 수 있는 비밀번호입니다.")
                } else {
                    validChecking.memberPwValid = false;
                    $("input[name=memberPw]").next("span").text("비밀번호 형식이 맞지 않습니다.")
                }
            });

            $("#memberPwChecking").blur(function(){
                var memberPwChecking = $(this).val();
                var memberPwOrigin = $("[name=memberPw]").val();
                if(memberPwChecking === memberPwOrigin) {
                    validChecking.memberPwChecking = true;
                    $("#memberPwChecking").next("span").text("비밀번호가 일치합니다.")
                } else {
                    validChecking.memberPwValid = false;
                    $("#memberPwChecking").next("span").text("비밀번호를 재확인하세요.")
                }
            });
            
            $("input[name=memberNick]").blur(function(){
                var memberNick = $(this).val();
                var regex = validChecking.memberNickRegex;
                if(regex.test(memberNick)) {
                    $.ajax({
                        url:"http://localhost:8888/rest/member/nick",
                        method:"post",
                        data: {memberNick:memberNick},
                        success:function(resp){
                            if(resp == "NNNNY"){
                                validChecking.memberNickValid = true;
                                $("input[name=memberNick]").next("span").text("좋은 닉네임이네요!");
                            }
                            else if(resp == "NNNNN") {
                                validChecking.memberNickValid = false;
                                $("input[name=memberNick]").next("span").text("이미 사용중인 닉네임입니다.");
                            }
                        }
                    })
                };
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