<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="자유 게시판" name="title"/>
</jsp:include>

<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script>
	$(function(){
		$("[name=boardContent]").summernote({
			height:300,
			minHeight:300,
		});
	});
</script>

<form action="write" method="post" enctype="multipart/form-data">
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
				<h1>게시글 작성</h1>
			</c:otherwise>
		</c:choose>
	</div>
	
	<div class="row left">
		<label>제목</label>
		<input class="input w-100" type="text" name="boardTitle" required>
	</div>
	
	<div class="row left">
		<label>내용</label>
		<textarea name="boardContent"></textarea>
	</div>
	
	<div class="row left">
		<label>첨부파일(1개당 1MB. 최대 10MB 가능)</label>
		<input class="input w-100 file-input" type="file" name="attachment" multiple>
		<img class="preview" src="https:/via.placeholder.com/200x200" width="200" height="200">
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
                            $(".preview").attr("src", resp);
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
