<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="login" value="${loginId != null}"></c:set>
<!-- css 불러옴  -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mypage.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/user-card.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/commons-ring-join.css">

<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param name="title" value="마이페이지"/>
</jsp:include>

<!-- js 불러옴 -->
<script src="/js/mypage.js"></script>

<!-- 유저 정보 카드 -->
        <div class="user-card">
            <div class="profileImgBox">
            	<c:choose>
            		<c:when test="${profileImg.attachmentNo>0}">
		                <img class="profileImage" src = "${pageContext.request.contextPath}/rest/download/${profileImg.attachmentNo}">
            		</c:when>
            		<c:otherwise>
	            		<img class="profileImage" src="${pageContext.request.contextPath}/img/basicProfileImage.png">
            		</c:otherwise>
            	</c:choose>
                <input type="file" class="file-input" accept=".jpg, .png, .gif"/>
                <button type="button" class="img-change-btn"><i class="fa-solid fa-camera"></i></button>
            </div>
            <div class="user-card-detail">
                <div>
                    <h2>${myInfo.memberNick}</h2>
                        <div class="edit-info-btn" href="#">정보변경</div>
                </div>
                <div>
                    <span>10%</span>
                    <div class="progressbar">
                        <div class="inner"></div>
                    </div>
                </div>
                <div>
                    <ul class="user-card-count-list">
                        <li class="like-list-btn">
                            <i class="fa-regular fa-heart"></i>
                            <p>좋아요</p>
                            <p>${myLike}</p>
                        </li>
                        <li class="write-list-btn">
                            <i class="fa-regular fa-pen-to-square"></i>
                            <p>내가 쓴 글</p>
                            <p>${myWrite}</p>
                        </li>
                        <li class="view-list-btn">
                            <i class="fa-regular fa-bookmark"></i>
                            <p>읽은 레시피</p>
                            <p>${myRead}</p>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- 유저 정보 카드 끝 -->
        
        
	
<div class="my-activity-list-box">
        <div class="view-recipe-list">
            <div>
                <img class="detail-list-img" src="/images/detail-list-paper.png">
                <h1>내가 읽은 레시피</h1>
            </div>
        <c:forEach var="viewList" items="${viewList}">
            <div class="recipe-item-box">
            
                <a class="recipe-item" href="/recipe/detail?recipeNo=${viewList.recipeDto.recipeNo}">
                    <div>
                        <ul>
                            <li>
                                <ul>
                                    <li>조회 수: ${viewList.recipeDto.recipeClick}</li>
                                    <li>좋아요 수: ${viewList.recipeDto.recipeLike}</li>
                            </ul>
                        </li>
                        <li>${viewList.recipeDto.recipeTitle}</li>
                        <li>
                            <ul>
                                <c:forEach var="ingredient" items="${viewList.recipeIngredientList}">
                                    <li>
                                        ${ingredient.recipeIngredientName}
                                    </li>
                                </c:forEach>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div>
                    <c:forEach var="recipeImg" begin="0" end="0" step="1" items="${viewList.recipeImgList}">
                        <img class="thumbnailImage" src = "${pageContext.request.contextPath}/rest/download/${recipeImg.recipeAttachmentNo}">
                    </c:forEach>
                </div>
                </a>
               
            </div>
        </c:forEach>
        </div>
        
<div class="like-recipe-list box-hide">
            <div>
                <img class="detail-list-img" src="/images/detail-list-heart.png">
                <h1>좋아요 한 레시피</h1>
            </div>
            <c:forEach var="likeList" items="${likeList}">
            <div class="recipe-item-box">
                <a class="recipe-item" href="/recipe/detail?recipeNo=${likeList.recipeDto.recipeNo}">
                    <div>
                        <ul>
                            <li>
                                <ul>
                                    <li>조회 수: ${likeList.recipeDto.recipeClick}</li>
                                    <li>좋아요 수: ${likeList.recipeDto.recipeLike}</li>
                            </ul>
                        </li>
                        <li>${likeList.recipeDto.recipeTitle}</li>
                        <li>
                            <ul>
                                <c:forEach var="ingredient" items="${likeList.recipeIngredientList}">
                                    <li>
                                        ${ingredient.recipeIngredientName}
                                    </li>
                                </c:forEach>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div>
                    <c:forEach var="recipeImg" items="${likeList.recipeImgList}">
                        <img class="thumbnailImage" src = "${pageContext.request.contextPath}/rest/download/${recipeImg.recipeAttachmentNo}">
                    </c:forEach>
                </div>
                </a>
            </div>
        </c:forEach>
        </div>

<div class="write-board-list box-hide">
            <div>
                <img class="detail-list-img" src="/images/detail-list-write.png">
                <h1>내가 쓴 게시글</h1>
            </div>
            <c:forEach var="writeList" items="${writeList}">
            <div class="board-item-box">
                <a class="recipe-item" href="/board/detail?=${writeList.boardNo}">
                    <div>
                        <ul>
                            <li>
                                <ul>
                                    <li>좋아요 수: ${writeList.boardLike}</li>
                                    <li>조회 수: ${writeList.boardClick}</li>
                                    <li>댓글 수: 8546</li>
                                    <li>작성 시간: ${writeList.boardWriteTime}</li>
                                </ul>
                            </li>
                            <li>내가 쓴 글 제목: ${writeList.boardTitle}</li>
                        </ul>
                    </div>
                    <div>
                        <img src="/images/logo.png" />
                    </div>
                </a>
            </div>
            </c:forEach>
        </div>
        
        <!-- 비밀번호 확인창 -->
        <div class="confirm-form-box box-hide">
        	<div class="confirm-form">
				<form class="pw-confirm-form" action="myInfo" method="get">
					<div>
						<label for="pwConfirm">비밀번호 확인</label>
						<input class="w-100 login-input-password" id="pwConfirm" type="password" placeholder="비밀번호를 입력해주세요"/>
						<div>
							<span class="box-hide">비밀번호가 일치하지 않습니다.</span>
						</div>
					</div>
					<div>
						<button class="w-100 mt-10 btn btn-positive pw-confirm-btn" type="submit">확인</button>
					</div>
				</form>
        	</div>
		</div>
        
</div>
<script>

</script>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>