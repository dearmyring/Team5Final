$(function(){
	
	$(".withDrawal").click(function() {
        var choice = confirm("정말 탈퇴 하시겠습니까?");
        if(choice == true) {
        	$(location).attr('href', 'http://localhost:8888/mypage/deleteMember');
        }
    });
    





});