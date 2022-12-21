<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>

<!-- css 파일 불러옴 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin-recipe-insert.css">

<!-- js 불러옴 -->
<script src="${pageContext.request.contextPath}/js/admin-recipe-insert.js"></script>

<div class="modal ingredient-insert-modal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">재료 등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       	<select class="insert-ingredientCategory" name="ingredientCategory">
       		<option value="">카테고리 선택</option>
       		<c:forEach var="category" items="${categoryList}">
	       		<option>${category}</option>
       		</c:forEach>
       	</select>
       	<input class="insert-ingredientName" type="text" name="ingredientName" placeholder="재료명">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary ingredient-insert-btn">등록하기</button>
        <button type="button" class="btn btn-secondary ingredient-insert-cancel" data-bs-dismiss="modal">돌아가기</button>
      </div>
    </div>
  </div>
</div>

<div class="mt-3">&nbsp;</div>
<div class="mt-3">&nbsp;</div>

<div class="text-end">
	<a class="main-page-link"></a> >
	<a href="list" class="text-dark">레시피</a> > 
	 레시피 등록하기
</div>

<form action="write" method="post" class="recipe-insert-form" autocomplete="off" enctype="multipart/form-data">

<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-2 fw-bolder">레시피 제목</div>
			<div class="col-8">
				<input type="text" name="recipeTitle" class="w-100 h-100 rounded pt-1 pb-1" placeholder="예) 소고기미역국">
				<div class="invalid-feedback">이미 존재하는 레시피 제목입니다.</div>
			</div>
		</div>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-2 fw-bolder">레시피 소개</div>
			<div class="col-8">
				<textarea name="recipeInfo" class="w-100 rounded" style="resize: none; overflow: hidden;" 
					placeholder="예) 생일에 빼놓을 수 없는 미역국 소고기를 넣어 더욱 깊은 맛으로 즐겨보세요."></textarea>
			</div>
		</div>
	</div>
</div>
	
<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-2 fw-bolder">레시피 정보</div>
			<div class="col-1 me-4">시간</div>
			<div class="col-2 me-1">
				<select style="color: #757575;" name="recipeTime" class="rounded pb-1 ps-1">
					<option value="">시간</option>
					<c:forEach var="i" begin="5" step="5" end="115">
						<option value="${i}">${i}분</option>
					</c:forEach>
					<option value="120">120분 이상</option>
				</select>
			</div>
			<div class="col-2 pe-0">난이도</div>
			<div class="col-2 ps-0">
				<select style="color: #757575;" name="recipeDifficulty" class="rounded pb-1 ps-1">
				    <option value="">난이도</option>
				    <option value="쉬워요">쉬워요</option>
				    <option value="보통이에요">보통이에요</option>
				    <option value="어려워요">어려워요</option>
				</select>
			</div>
		</div>
	</div>
</div>


<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<i class="fa-regular fa-lightbulb"></i>음식의 재료를 입력해주세요.
	</div>
</div>
<div class="row">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<input type="text" class="input-ingredient align-middle me-3 rounded" placeholder="재료">
		<button type="button" class="ingredient-all-clear btn btn-md btn-light">모두 지우기</button>	
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="search-ingredient col-6"></div>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="add-ingredient col-10"></div>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-3 fw-bolder">요리 순서</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<p class="fw-light mb-0" style="font-family: 'Noto Sans KR', sans-serif;">
			<i class="fa-regular fa-lightbulb"></i>요리의 맛이 좌우될 수 있는 중요한 부분은 빠짐없이 적어주세요.
		</p>
		<p class="fw-light mb-0 recipe-example" style="font-family: 'Noto Sans KR', sans-serif; text-indent: 8px;">
			예) 10분간 익혀주세요 <i class="fa-solid fa-caret-right"></i> 10분간 약한불로 익혀주세요. 
		</p> 
		<p class="fw-lighter mb-0 recipe-example" style="font-family: 'Noto Sans KR', sans-serif;">
			마늘편은 익혀주세요 <i class="fa-solid fa-caret-right"></i> 마늘편은 충분히 익혀주셔야 매운 맛이 사라집니다.
		</p> 
		<p class="fw-lighter mb-0 recipe-example" style="font-family: 'Noto Sans KR', sans-serif;">
			꿀을 조금 넣어주세요 <i class="fa-solid fa-caret-right"></i> 꿀이 없는 경우, 설탕 1스푼으로 대체 가능합니다.
		</p> 
	</div>
</div>

<c:forEach var="no" begin="0" end="9">
<div class="content-page">
<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-2 d-flex align-items-center fs-4">
				Step<fmt:formatNumber value="${no+1}" minIntegerDigits="2"/> 
			</div>
			<div class="col-7">
				<textarea name="recipeContentText" style="resize:none;" class="w-100 h-100 rounded"></textarea>
			</div>
			<div class="col-3">
				<input type="file" class="file-input" accept=".jpg, .png, .gif">
				<img class="preview rounded" src="${pageContext.request.contextPath}/images/img_plus.png" width="200" height="200">
			</div>
		</div>
	</div>
</div>
<div class="row mt-2">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1 text-center">
		<label class="step-plus-btn"><button class="green-btn btn btn-md ps-2 pe-2" type="button">
			<i class="ms-1 me-1 fa-solid fa-plus"></i></button> 순서 추가
		</label>
		<label class="step-minus-btn"><button class="green-btn btn btn-md ps-2 pe-2" type="button">
			<i class="ms-1 me-1 fa-solid fa-minus"></i></button> 순서 삭제
		</label>
	</div>
</div>
</div>
</c:forEach>

<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-2 pe-0">
				<span class="fw-bolder">요리 완성사진</span>
<!-- 				<button type="button">사진 한 번에 넣기</button> -->
				<button class="thumb-all-clear btn btn-md btn-light mt-3" type="button">모두 지우기</button>
			</div>
			<div class="thumb-page col-10">
				<c:forEach var="no" begin="0" end="3">
					<input type="file" class="file-input" accept=".jpg, .png, .gif">
					<c:choose>
						<c:when test="${no != 0}">
							<img class="preview preview-disabled rounded" src="${pageContext.request.contextPath}/images/img_plus.png" width="200" height="200">
						</c:when>
						<c:otherwise>
							<img class="preview rounded" src="${pageContext.request.contextPath}/images/img_plus.png" width="200" height="200">
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
		</div>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row pe-0">
			<div class="col-2 pe-0 fw-bolder">요리 해시태그</div>
			<div class="col-2">
				<select style="color: #757575;" name="recipeHashtag" class="rounded">
					<option value="">해시태그</option>
					<c:forEach var="hashtagDto" items="${hashtagList}">
						<option>${hashtagDto.hashtagName}</option>
					</c:forEach>
				</select>
			</div>
		</div>
	</div>
</div>

<div class="row mt-5">
	<div class="col-lg-8 offset-lg-2 col-md-8 offset-md-2 col-sm-10 offset-sm-1">
		<div class="row">
			<div class="col-6 text-end">
				<button class="col-6 btn btn-md text-lg btn-light recipe-return-btn" type="button">돌아가기</button>
			</div>
			<div class="col-6">
				<button class="col-6 btn btn-md text-lg yellow-btn recipe-insert-btn" type="submit">레시피 등록하기</button>
			</div>
		</div>
	</div>
</div>

</form>
</div>


<jsp:include page="/WEB-INF/views/template/adminFooter.jsp"></jsp:include>