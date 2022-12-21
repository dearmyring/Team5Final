<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="회원가입" name="title"/>
</jsp:include>
<!-- 글꼴 Noto Sans Korean -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<!-- css commons -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/commons-ring-join.css">
	
	<div class="container-400 mt-50">
		<form class="join-form" action="join" method="post">
			<div class="mt-20">
				<div class="title-bold"><h3>이메일</h3></div>
				<input class="input w-100 mt-10" name="memberId" type="text" 
				placeholder="이메일" autocomplete="off">
				<button class="w-100 mt-10 send-btn btn" type="button" disabled>이메일 중복확인</button>
				<div class="mt-5 help-text"></div>
				<div class="cert"></div>
			</div>
			<div>
				<div class="mt-30 mb-10"><h3>비밀번호</h3></div>
				<label class="mb-5 helper-text" for="member-pw">8~16글자, 특수문자 !@#$를 포함해서 입력해 주세요.</label>
				<input class="w-100 member-pw input mt-5" name="memberPw" type="password" placeholder="비밀번호를 입력하세요.">
				<div class="mt-5 help-text"></div>
			</div>
			<div>
				<div class="mt-30 mb-10"><h3>비밀번호 확인</h3></div>
				<input class="w-100 input mt-5" id="memberPwChecking" type="password" placeholder="비밀번호를 확인하세요.">
				<div class="mt-5 help-text"></div>
			</div>
			<div>
				<div class="mt-30 mb-10"><h3>닉네임</h3></div>
					<label class="helper-text">영문, 한글, 숫자 10자 이내로 입력해 주세요.</label>
					<input class="w-100 input mt-5" name="memberNick" type="text" placeholder="사용하실 닉네임을 입력하세요." autocomplete="off">
					<div class="mt-5 help-text"></div>		
			</div>
			<div class="mt-30">
				<div>
					<div class="mt-30 mb-10"><h3>성별</h3></div>
					<div class="select-gender-line">
						<div class="mb-10">
							<label>
								<input class="check-mail" type="radio" name="memberGender" value="M"> 남성
							</label>
						</div>
						<div>
							<label>
								<input class="check-femail" type="radio" name="memberGender" value="F"> 여성
							</label>
						</div>
						<div class="help-text"></div>
					</div>
				</div>
			</div>
			<div class="mt-30">
				<div class="mt-30 mb-10"><h3>휴대폰 번호</h3></div>
				<label class="helper-text">입력하신 휴대폰 정보는 마케팅 용도로 사용하지 않습니다.</label>
				<input class="input w-100 mt-5" type="tel" name="memberPhone" 
				autocomplete="off" placeholder="휴대폰 번호를 입력하세요.">
				<div class="mt-5 help-text"></div>
			</div>
			<div class="mt-30">
				<div>
					<div class="mt-30 mb-10"><h3>이용약관</h3></div>
					<div class="select-agree-line">
						<div class="mb-30">
							<label>
								<input class="check-all" type="checkbox">전체동의
							</label>
						</div>
						<div class="mb-20">
							<label>
								<input class="check-agree" type="checkbox">이용약관<span class="essential-agree">(필수)</span>		
							</label>
						</div>
						<div>
							<label>
								<input class="check-agree helper-text" type="checkbox">개인정보수집 및 이용동의<span class="essential-agree">(필수)</span>
							</label>
						</div>
						<div></div>
					</div>
				</div>
			</div>
			<button class="mt-30 mb-30 btn btn-positive w-100" type="submit">회원가입하기</button>
			<span class="join-fail"></span>
		</form>
		<div class="center mb-50">
			<span>이미 아이디가 있으신가요?</span>
			<span><a href="../member/login">로그인</a></span>
		</div>
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
            
            $("input[name=memberId]").on("input", function(e){
            	e.preventDefault();
            	var memberId = $(this).val();
            	var possible = $(".send-btn");
            	$("input[name=memberId]").next("button").next("div").text("");
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
                        	 possible.prop("disabled", true);
                             validChecking.memberIdValid = false;
                             $("input[name=memberId]").next("button").next("div").text("이미 사용중인 아이디입니다.")
                         }
                     }
                 });
            });
            
            
			$(".send-btn").click(function(){
				var email = $("input[name=memberId]").val();
				if (email.length == 0) return;
				var btn = $(this);
				//btn.prop("disabled", true);
				
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
            
            $("input[name=memberNick]").blur(function(){
                var memberNick = $(this).val();
                var regex = validChecking.memberNickRegex;
                $("input[name=memberNick]").next("div").text("");
                if(!regex.test(memberNick)) {
                	validChecking.memberNickValid = false;
                	$("input[name=memberNick]").next("div").text("닉네임 형식이 맞지 않습니다.");
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
                                $("input[name=memberNick]").next("div").text("이미 사용중인 닉네임입니다.");
                            }
                            else if(resp.memberNick == "관리자") {
                            	 validChecking.memberNickValid = false;
                                 $("input[name=memberNick]").next("div").text("닉네임에는 '관리자'를 포함할 수 없습니다.");
                            }
                        }
                    })
                };
            });
            
            $("input:radio[name=memberGender]").blur(function(){
            	var judge = $(this).length == 1;
            	if(judge) {
            		validChecking.memberGenderValid = true;
            		$("input[name=memberGender]").next("div").text("");
            	} 
            	else {
            		validChecking.memberGenderValid = false;
            		$("input[name=memberGender]").find("div").text("필수 입력 사항입니다.");
            	} 
            });
            
            $("input[name=memberPhone]").blur(function(){
                var memberPhone = $(this).val();
                var regex = validChecking.memberPhoneRegex;
                $("input[name=memberPhone]").next("div").text("");
                if(!regex.test(memberPhone)) {
                	validChecking.memberPhoneValid = false;
                    $("input[name=memberPhone]").next("div").text("전화번호 형식이 맞지 않습니다.");
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
                                $("input[name=memberPhone]").next("div").text("이미 사용중인 전화번호입니다.");
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