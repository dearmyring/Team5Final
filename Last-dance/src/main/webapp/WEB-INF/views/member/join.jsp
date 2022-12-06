<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="회원가입" name="title"/>
</jsp:include>

	<form class="join-form" action="join" method="post">
		<div>
			<div>이메일</div>
			<input name="memberId" type="text" 
			placeholder="이메일" autocomplete="off">
			<button class="send-btn" type="button" disabled>이메일 중복확인</button>	
			<span></span>
			<div class="cert"></div>
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
			<label>영문, 한글, 숫자 10자 이내로 입력해 주세요.</label>
				<input name="memberNick" type="text" placeholder="사용하실 닉네임을 입력하세요." autocomplete="off">
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
			<label>입력하신 휴대폰 정보는 마케팅 용도로 사용하지 않습니다.</label>
				<input type="tel" name="memberPhone" placeholder="휴대폰 번호를 입력하세요.">
				<span></span>
		</div>
		<div>
			<div>
				<div>이용약관</div>
				<input class="check-all" type="checkbox">전체동의		
				<input class="check-agree" type="checkbox">이용약관<span>(필수)</span>		
				<input class="check-agree helper-text" type="checkbox">개인정보수집 및 이용동의<span>(필수)</span>
				<span></span>
			</div>
		</div>
		<button type="submit">회원가입하기</button>
		<span class="join-fail"></span>
	</form>
	<div>
		<span>이미 아이디가 있으신가요?</span>
		<span><a href="#">로그인</a></span>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
    <script>
        $(function (){
        	 // jQuery 시작
            var validChecking = {
            	memberIdValid: false,
            	memberIdConfirm: false,
                memberPwValid: false,
                memberPwChecking: false,
                memberNickValid: false,
            	memberGenderValid: false,
                memberPhoneValid: false,
                memberArgeeValid: false,
                memberPwRegex: /^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[a-zA-Z0-9!@#$]{8,16}$/,
                memberNickRegex: /^[a-zA-Z0-9가-힣]{1,10}$/,
                memberPhoneRegex: /^010\d{7,8}$/,
                isAllValid: function() {
                    return this.memberIdValid && this.memberIdConfirm && this.memberPwValid && this.memberPwChecking && this.memberNickValid && this.memberGenderValid && this.memberPhoneValid && this.memberArgeeValid;
                }
            };
            
            $("input[name=memberId]").on("input", function(){
            	var memberId = $(this).val();
            	var possible = $(".send-btn");
            	$("input[name=memberId]").next("button").next("span").text("");
            	 $.ajax({
                     url:"http://localhost:8888/rest/member/id",
                     method:"post",
                     data: {memberId:memberId},
                     success:function(resp){
                         if(resp == "NNNNY"){
                        	 possible.prop("disabled", false);
                             validChecking.memberIdValid = true;
                         }
                         else if(resp == "NNNNN") {
                             validChecking.userIdValid = false;
                             $("input[name=memberId]").next("button").next("span").text("이미 사용중인 아이디입니다.")
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
						var input = $("<input>")
						var button = $("<button>").attr("type", "button").text("번호 확인");
						
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
									btn.text("인증 완료");
									button.remove();
									input.remove()
									btn.prop("disabled", true);
								}
							});
						});
						div.append(input).append(button);
						$(".cert").html(div);
					}
				});
			});
            
            $("input[name=memberPw]").blur(function(){
                var memberPw = $(this).val();
                var regex = validChecking.memberPwRegex;
                $("input[name=memberPw]").next("span").text("");
                if(regex.test(memberPw)) {
                    validChecking.memberPwValid = true;
                } else {
                    validChecking.memberPwValid = false;
                    $("input[name=memberPw]").next("span").text("비밀번호 형식이 맞지 않습니다.");
                }
            });

            $("#memberPwChecking").blur(function(){
                var memberPwChecking = $(this).val();
                var memberPwOrigin = $("input[name=memberPw]").val();
                $("#memberPwChecking").next("span").text("");
                if(memberPwChecking === memberPwOrigin) {
                    validChecking.memberPwChecking = true;
                    $("#memberPwChecking").next("span").text("비밀번호가 일치합니다.");
                } else {
                    validChecking.memberPwChecking = false;
                    $("#memberPwChecking").next("span").text("비밀번호를 재확인하세요.");
                }
            });
            
            $("input[name=memberNick]").blur(function(){
                var memberNick = $(this).val();
                var regex = validChecking.memberNickRegex;
                $("input[name=memberNick]").next("span").text("");
                if(!regex.test(memberNick)) {
                	validChecking.memberNickValid = false;
                	$("input[name=memberNick]").next("span").text("닉네임 형식이 맞지 않습니다.");
                }
                else if(regex.test(memberNick)) {
                    $.ajax({
                        url:"http://localhost:8888/rest/member/nick",
                        method:"post",
                        data: {memberNick:memberNick},
                        success:function(resp){
                            if(resp == "NNNNY"){
                                validChecking.memberNickValid = true;
                            }
                            else if(resp == "NNNNN") {
                                validChecking.memberNickValid = false;
                                $("input[name=memberNick]").next("span").text("이미 사용중인 닉네임입니다.");
                            }
                        }
                    })
                };
            });
            
            $("input:radio[name=memberGender]").blur(function(){
            	var judge = $(this).length == 1;
            	if(judge) {
            		validChecking.memberGenderValid = true;
            		$("input[name=memberGender]").next("span").text("");
            	} 
            	else {
            		validChecking.memberGenderValid = false;
            		$("input[name=memberGender]").next("span").text("필수 입력 사항입니다.");
            	} 
            });
            
            $("input[name=memberPhone]").blur(function(){
                var memberPhone = $(this).val();
                var regex = validChecking.memberPhoneRegex;
                $("input[name=memberPhone]").next("span").text("");
                if(!regex.test(memberPhone)) {
                	validChecking.memberPhoneValid = false;
                    $("input[name=memberPhone]").next("span").text("전화번호 형식이 맞지 않습니다.");
                }
                else if(regex.test(memberPhone)) {
                    $.ajax({
                        url:"http://localhost:8888/rest/member/phone",
                        method:"post",
                        data: {memberPhone:memberPhone},
                        success:function(resp){
                            if(resp == "NNNNY"){
                                validChecking.memberPhoneValid = true;
                            }
                            else if(resp == "NNNNN") {
                                validChecking.memberPhoneValid = false;
                                $("input[name=memberPhone]").next("span").text("이미 사용중인 전화번호입니다.");
                            }
                        }
                    })
                };
            });
            
            $(".check-all").on("input", function(){
                var check = $(this).prop("checked");
                $(".check-agree").prop("checked", check);
                validChecking.memberArgeeValid = true;
            });
            
            $(".check-agree").change(function(){
                var count = 0;
                $(".check-agree").each(function(){
                    if($(this).prop("checked")){
                        count++;
                    }
                });
                var judge = $(".check-agree").length == count;
                if(judge) {
                	validChecking.memberArgeeValid = true;
                	$(".check-all").prop("checked", "checked");
                } else {
                	$(".check-all").prop("checked", "");
                	validChecking.memberArgeeValid = false;
                }
            });
            
            $(".join-form").submit(function(e){
                e.preventDefault();
                
                $(this).find("input").blur();
                
                if(validChecking.isAllValid()) {
                   	this.submit();
                } else {
                	$(".join-fail").text("입력 사항을 확인해 주세요.");
                }
            });
            // jQuery 끝
        });
    </script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>