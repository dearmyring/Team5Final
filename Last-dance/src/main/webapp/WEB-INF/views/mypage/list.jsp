<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param name="title" value="메인페이지"/>
</jsp:include>

<h2>마이페이지</h2>

<!-- 유저 정보 카드 -->
        <div>
            <div>
                <img class="profileImage" src="http://localhost:8888/rest/download/${profileImg}" style="width: 200px; height: 200px;">
                <input type="file" class="file-input" accept=".jpg .png .gif"/>
            </div>
            <div>
                <ul>
                    <li>
                        ${myInfo.memberNick}
                    </li>
                    <li>
                        <p>좋아요</p><p>${myLike.myLikeListCount}</p>
                    </li>
                </ul>
                <div>
                    <a href="pwConfirm">정보변경</a>
                </div>
            </div>
        </div>
        <!-- 유저 정보 카드 끝 -->
	
<c:forEach var="viewList" items="${viewList}">
	
	
	<ul>
		<li>최근 본 제목: ${viewList.recipeTitle}</li>
	</ul>
	
</c:forEach>

<c:forEach var="likeList" items="${likeList}">
	<ul>
		<li>좋아요 제목: ${likeList.recipeTitle}</li>
	</ul>
</c:forEach>

<c:forEach var="writeList" items="${writeList}">
	<ul>
		<li>내가 쓴 글 제목: ${writeList.boardTitle}</li>
	</ul>
</c:forEach>

<script>
        $(function(){
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
                        }
                    });//ajax end

                }//if end
                else {
                    $(".profileImage").attr("src","");
                }//else end

            });//.file-input change end

        });
    </script>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>