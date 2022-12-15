$(function(){
	
	// 파일업로드 비동기
            $(".file-input").change(function(){
                if(this.files.length > 0){
                    console.log()
                    var imgData = new FormData();

                    imgData.append("attach", this.files[0]);

                    $.ajax({
                        url: "http://localhost:8888/rest/upload",
                        method: "post",
                        data: imgData,
                        processData:false, // 일반 폼에서 전송되는 형식(key = value)
                        contentType:false, //형태가 없음을 의미 => multipart
                        success: function(resp) {
                            $(".profileImage").attr("src", resp);
                            
                            var attachmentNo = (resp.split("download/")[1]);
                            
                            $.ajax({
                                url: "http://localhost:8888/rest/profileImg?attachmentNo="+attachmentNo,
                                method: "post",
                                contentType: "application/json",
                                data: JSON.stringify({attachmentNo:attachmentNo}),
                                success: function(resp) {
	
                                }
                            });//inner ajax end
                            
                        }
                    });//ajax end

                }//if end
                else {
                    $(".profileImage").attr("src","");
                }//else end

            });//.file-input change end

    // 파일 추가 대체 버튼
    $(".img-change-btn").click(function(){
        $("input[type=file]").click();
    });

    //리스트 변경 기능
    $(".like-list-btn").click(function(){
        $(".view-recipe-list").addClass("box-hide");
        $(".write-board-list").addClass("box-hide");
        $(".confirm-form-box").addClass("box-hide");
        $(".like-recipe-list").removeClass("box-hide");
    });
    $(".write-list-btn").click(function(){
        $(".view-recipe-list").addClass("box-hide");
        $(".like-recipe-list").addClass("box-hide");
        $(".confirm-form-box").addClass("box-hide");
        $(".write-board-list").removeClass("box-hide");
    });
    $(".view-list-btn").click(function(){
        $(".like-recipe-list").addClass("box-hide");
        $(".write-board-list").addClass("box-hide");
        $(".confirm-form-box").addClass("box-hide");
        $(".view-recipe-list").removeClass("box-hide");
    });
    $(".edit-info-btn").click(function(){
        $(".like-recipe-list").addClass("box-hide");
        $(".write-board-list").addClass("box-hide");
        $(".view-recipe-list").addClass("box-hide");
        $(".confirm-form-box").removeClass("box-hide");
    });
    
    
    //비밀번호 확인
	$(".pw-confirm-btn").click(function(e){
		e.preventDefault();
		var inputPw = $(".login-input-password").val();
		$.ajax({
			url: "http://localhost:8888/rest/pwConfirm",
			method: "post",
			contentType: "application/json",
			data: JSON.stringify({memberPw : inputPw}),
			success: function(resp) {
				if(resp == "Y") {
					$(".pw-confirm-form").submit();
				}
				else {
					$(".pw-confirm-form").find("div").find("div").find("span").removeClass("box-hide");
					$(".pw-confirm-form").find("div").find("div").addClass("vibration");
				}
			}
		}); // ajax end
				$(".pw-confirm-form").find("div").find("div").removeClass("vibration");
	});
    





});