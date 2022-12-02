<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
$(function(){
	loadList();		
	//수정 버튼 클릭 이벤트
	$(".edit-btn").click(function(){
		var boardId = $("[name=board_id]").val();
		var boardTitle = $("[name=board_title]").val();
		var boardContent = $("[name=board_content]").val();
		
		editData(boardId,boardTitle,boardContent);
		
		
		$("[name=board_id]").val("");
		$("[name=board_title]").val("");
		$("[name=board_content]").val("");
	});
	
	//form에 submit 이벤트를 설정해서 등록 처리
	$(".detail-view").submit(function(e){
		e.preventDefault();
		
		var boardId = $("[name=board_id]").val();
		var boardTitle = $("[name=board_title]").val();
		var boardContent = $("[name=board_content]").val();
		//검사
		saveData(boardId,boardTitle,boardContent);
		
		$("[name=board_id]").val("");
		$("[name=board_title]").val("");
		$("[name=board_content]").val("");
	});
});

//삭제 함수
function deleteData(boardNo) {
	$.ajax({
		url:"http://localhost:8888/rest/board/"+boardNo,
		method:"delete",
		success:function(resp){
			loadList();
		}
	});
}

//수정 함수
function editData(boardId,boardTitle,boardContent) {
	var data = {
			boardId:boardId,
			boardTitle:boardTitle,
			boardContent:boardContent
	};
	
	$.ajax({
		url:"http://localhost:8888/rest/pocketmon",
		method:"put",
		contentType:"application/json",
		data:JSON.stringify(data),
		success:function(){
			loadList();
		}
	});
}

//등록 함수
function saveData(no, name, type){
	var data = {
		boardId:boardId,
		boardTitle:boardTitle,
		boardContent:boardContent
	};
	
	$.ajax({
		url:"http://localhost:8888/rest/board",
		method:"post",
		contentType:"application/json",
		data:JSON.stringify(data),
		success:function(){
			loadList();
		}
	});
}
</script>
