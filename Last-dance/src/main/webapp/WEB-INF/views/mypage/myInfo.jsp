<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param name="title" value="개인정보수정"/>
</jsp:include>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mypage.css">

<!-- js 불러옴 -->
<script src="/js/myInfo.js"></script>


<form class="update-form" action="infoEdit" method="post">
	<div class="my-info-box container-1200">
		<div class="w-100">
			<label for="memberId">이메일</label>
			<input class="w-100 login-input-password" id="memberId" type="text" name="memberId" readonly value="${userInfo.memberId}"/>
			<!-- <span>@</span> -->
			<!-- <input type="text"  readonly/> name="emailAddress" -->
		</div>
		<div>
			<label for="memberPw">비밀번호</label>
			<input class="w-100 login-input-password" id="memberPw" type="password" name="memberPw"/>
			<div class="mt-5 help-text"></div>	
		</div>
		<div>
			<label for="memberPwChecking">비밀번호 확인</label>
			<input class="w-100 login-input-password" id="memberPwChecking" type="password"/>
			<div class="mt-5 help-text"></div>	
		</div>
		<div>
			<label for="memberNick">닉네임</label>
			<input readonly class="w-100 login-input-password" id="memberNick" type="text" name="memberNick" value="${userInfo.memberNick}"/>
		</div>
		<div>
			<label>성별</label>
			<c:choose>
				<c:when test="${userInfo.memberGender=='M'}">
					<input id="genderM" type="radio" name="memberGender" value="M" checked/>
					<label for="genderM">남</label>
					<input id="genderF" type="radio" name="memberGender" value="F"/>
					<label for="genderF">여</label>
				</c:when>
				<c:otherwise>
					<input id="genderM" type="radio" name="memberGender" value="M"/>
					<label for="genderM">남</label>
					<input id="genderF" type="radio" name="memberGender" value="F" checked/>
					<label for="genderF">여</label>
				</c:otherwise>
			</c:choose>
		</div>
		<div>
			<label for="memberPhone">휴대폰 번호</label>
			<input class="w-100 login-input-password" id="memberPhone" type="text" name="memberPhone" value="${userInfo.memberPhone}"/>
			<div class="mt-5 help-text"></div>	
		</div>
		<div>
			<button class="w-100 mt-10 btn btn-positive" type="submit">변경하기</button><!-- 구현 완료 후 type submit으로 변경 -->
			<button class="withDrawal w-100 mt-10 btn btn-neutral" type="button">탈퇴하기</button>
		</div>
	</div>
</form>

<script type="text/javascript">

	$(function() {
		
		var validChecking = {
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
                    return this.memberPwValid && this.memberPwChecking && this.memberGenderValid && this.memberPhoneValid;
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
            
            
            $(".update-form").submit(function(e){
                e.preventDefault();
                
                $(this).find("input").blur();
                
                if(validChecking.isAllValid()) {
                   	this.submit();
                } else {
                	$(".join-fail").text("입력 사항을 확인해 주세요.").addClass("btn fail-btn screen-bottom-join notice-in notice-out");
                }
            });
            // jQuery 끝
		
	});

</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>