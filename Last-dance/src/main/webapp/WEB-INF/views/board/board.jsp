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
		url:"http://localhost:8888/rest/board",
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

//목록을 불러오는 함수
function loadList(){
	$.ajax({
		url:"http://localhost:8888/rest/board",
		method:"get",
		success:function(resp){
			//console.log(resp);
			$(".list-view").empty();
			for(var i=0; i < resp.length; i++){
				var h3 = $("<h3>").text(
					resp[i].no+"/"+resp[i].name+"/"+resp[i].type
				)
				.attr("data-no", resp[i].no)
				.attr("data-name",resp[i].name)
				.attr("data-type", resp[i].type);
				
				h3.click(function(){
					$("[name=no]").val($(this).data("no"));
					$("[name=name]").val($(this).data("name"));
					$("[name=type]").val($(this).data("type"));
				});
				
				//삭제 버튼
				var span = $("<span>").text("x").attr("data-no", resp[i].no);
				span.click(function(e){
					e.stopPropagation();//전파 중지
					
					if(confirm("정말 삭제할래요?")) {
						var no = $(this).data("no");
						deleteData(no);
					}
				});
				
				h3.append(span);
				$(".list-view").append(h3);
			}
		}
	});
}
</script>

<h1>유저게시판 리스트</h1>

<form class="detail-view">
	<input type="text" name="board_title" placeholder="번호">
	<input type="text" name="board_content" placeholder="이름">
	<input type="text" name="board_id" placeholder="아이디">
	<input type="text" name="board_nick" placeholder="닉네임">
	<button type="submit">등록</button>
	<button type="button" class="edit-btn">수정</button>
</form>

<hr>

<div class="list-view">
	
</div>
