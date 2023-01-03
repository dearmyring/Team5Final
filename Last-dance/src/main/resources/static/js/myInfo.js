$(function(){
	
	$(".withDrawal").click(function() {
        var choice = confirm("정말 탈퇴 하시겠습니까?");
        if(choice == true) {
        	$(location).attr('href', 'http://localhost:8888/mypage/deleteMember');
        }
    });
    
    
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
                        url:"${pageContext.request.contextPath}/rest/member/phone",
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
    





});