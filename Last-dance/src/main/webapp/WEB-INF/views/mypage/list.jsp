<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="login" value="${loginId != null}"></c:set>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param name="title" value="메인페이지"/>
</jsp:include>

<h2>마이페이지</h2>

<!-- 유저 정보 카드 -->
        <div>
            <div>
            	<c:choose>
            		<c:when test="${profileImg.attachmentNo>0}">
		                <img class="profileImage" src = "http://localhost:8888/rest/download/${profileImg.attachmentNo}" style="width: 50px; height: 50px;">
            		</c:when>
            		<c:otherwise>
	            		<img class="profileImage" src="${pageContext.request.contextPath}/img/basicProfileImage.png" style="width: 50px; height: 50px;">
            		</c:otherwise>
            	</c:choose>
                <input type="file" class="file-input" accept=".jpg, .png, .gif"/>
            </div>
            <div>
                <ul>
                    <li>
                    	<%-- <h2>${loginNick}</h2> --%>
                    	<h2>${myInfo.memberNick}</h2>
                    	
                        
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
	<div>
	
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
</div>
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
                            
                            var attachmentNo = (resp.split("download/")[1]);

                            $.ajax({
                                url: "http://localhost:8888/profileImg?attachmentNo="+attachmentNo,
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

        });
    </script>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>