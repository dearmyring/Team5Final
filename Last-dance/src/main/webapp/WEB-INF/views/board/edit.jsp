<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="자유 게시판" name="title"/>
</jsp:include>
<style>
.input {
    font-size: 15px;
    padding: 0.75em;
    outline: none;
    border:1px solid #CBCACA;
    border-radius: 5px;
}
.input:focus {
    border-color: #3bc5f0;
    opacity: 70%;
}
.thumbnail-preview-wrapper {
	display:flex;
}
.thumbnail-preview-wrapper > label {
	width:50px;
	height:50px;
	position:relative;
	overflow:hidden;
}
.thumbnail-preview-wrapper > label > img {
	width:100%;
	height:100%;
}
.thumbnail-preview-wrapper > label > [type=radio] {
	position: absolute;
	top:-50px;
	left:-50px;
}
.thumbnail-preview-wrapper > label > [type=radio] + img {
	border:3px transparent solid;
}
.thumbnail-preview-wrapper > label > [type=radio]:checked + img {
	border:3px red solid;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script>
	$(function(){
		$("[name=boardContent]").summernote({
			 // 에디터 높이
			  height: 700,
			  // 에디터 한글 설정
			  lang: "ko-KR",
			  // 에디터에 커서 이동 (input창의 autofocus라고 생각하시면 됩니다.)
			  focus : true,
			  placeholder:"게시글 수정시 썸네일 첨부파일은 다시 선택해주세요!!",
			  toolbar: [
				    // 글꼴 설정
				    ['fontname', ['fontname']],
				    // 글자 크기 설정
				    ['fontsize', ['fontsize']],
				    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
				    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
				    // 글자색
				    ['color', ['forecolor','color']],
				    // 표만들기
				    ['table', ['table']],
				    // 글머리 기호, 번호매기기, 문단정렬
				    ['para', ['ul', 'ol', 'paragraph']],
				    // 줄간격
				    ['height', ['height']],
				    // 그림첨부, 링크만들기, 동영상첨부
				    ['insert',['picture','link','video']],
				    // 코드보기, 확대해서보기, 도움말
				    ['view', ['codeview','fullscreen', 'help']]
				  ],
				  // 추가한 글꼴
				fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
				 // 추가한 폰트사이즈
				fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
		});
	});
</script>

<form action="edit" method="post" enctype="multipart/form-data">
<input type="hidden" name="boardNo" value="${boardDto.boardNo}">
<%-- 답글이라면 부모글번호를 추가로 전송하도록 처리 --%>
<c:if test="${isReply}">
	<input type="hidden" name="boardParent" 
									value="${param.boardParent}">
</c:if>

<div class="container-800 mt-40">
	<div class="row center">
		<c:set var="isReply" value="${param.boardParent != null}"></c:set>
		<c:choose>
			<c:when test="${isReply}">
				<h1>답글 작성</h1>
			</c:when>
			<c:otherwise>
				<h1>게시글 수정</h1>
			</c:otherwise>
		</c:choose>
	</div>
	
	<div class="row left">
		<label>제목</label>
		<input class="input w-100" type="text" required value="${boardDto.boardTitle}" name="boardTitle" required>
	</div>
	
	<div class="row left">
		<label>내용</label>
		<textarea name="boardContent" required>${boardDto.boardContent}</textarea>
	</div>
	
	<div class="row left">
		<label>첨부파일(1개당 1MB. 최대 10MB 가능)</label>
	<input class="input w-100 file-input" type="file" name="attachment" multiple>
	<div class="thumbnail-preview-wrapper"></div>	
		
	</div>
	
	<div class="row right">
		<a class="btn btn-neutral" href="list">목록으로</a>
		<button class="btn btn-positive" type="submit">등록하기</button>
	</div>
</div>

</form>

<script>

$(function(){
    //목표: 파일이 선택되면 해당하는 파일을 서버에 업로드 
    $(".file-input").change(function(){
    	var that = $(this);
            //console.log("변화 감지!");
            //console.log(this.filed);//선택된 파일 리스트
            if(this.files.length>0){
                //console.log("파일선택")

                //프론트엔드에서 미리보기만 가능하며 향후에 관리가 안됨
               // var obj=URL.createObjectURL(this.files[0]);
                //$(".preview").attr("src",obj);

                //서버에 비동기로 파일을 업로드하는 코드(ajax를 이용해서 multipart 전송 구현)
                var fd= new FormData();
                fd.append("attach", this.files[0]);
                //fd.append("이름",데이터);



                $.ajax({
                    url:" http://localhost:8888/rest/upload",
                    method:"post",
                    data: fd,
                    processData: false,
                    contentType: false,
                    success: function(resp){
                    	var img = $("<img>").attr("src",resp);
						$("[name=boardContent]").summernote('insertNode', img[0]);
						
						var attachmentNo = parseInt((resp.split("download/"))[1]);
						
						var img2 = img.clone();
						var label = $("<label>");
						var checkbox = $("<input>").attr("type", "radio")
						.attr("name", "boardAttachmentNo")//전송될 이름(변경필요)
						.val(attachmentNo)//전송될 썸네일에 대한 값(변경필요)
						.prop("checked", true);
						label.append(checkbox).append(img2);
						$(".thumbnail-preview-wrapper").append(label);
                    }
                });
            }
            else{ 
                $(".preview").attr("src", "https:/via.placeholder.com/240x180");
            }
    });


});
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>