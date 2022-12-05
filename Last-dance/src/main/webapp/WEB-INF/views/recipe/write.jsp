<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class = "container-1200">
		<div class = "row">
			<h2>레시피 등록</h2>
		</div>
		<form action = "write" method = "post">
			<div class = "row">
			레시피 제목 : <input name = "recipeTitle" class="input input-underline w-50" placeholder="레시피 제목">
			</div>
			
			<div class = "row">
			레시피 소개 : <input name = "recipeInfo" class="input input-underline w-50"   placeholder="레시피 소개">
			</div>
			
			<div class = "row">
			레시피 정보 : <input name = "recipeInfo" class="input input-underline w-50" placeholder="레시피 정보">
			</div>
			
			<div class = "row">
			레시피 재료 : <input name = "recipeInfo" class="input input-underline w-50" placeholder="재료를 입력해주세요"><br><br>
			</div>
	
			<div class = "row">
				요리순서 :<br><textarea name = "recipeContent" class="input w-100 fix-size mt-10" rows="8" placeholder="레시피 내용을 입력해 주세요."></textarea>
			</div>

			<div class = "row">
				요리사진: 			<button>사진 한번에 넣기</button>
										<button>사진 모두 지우기</button><br>
										<input name = "첨부파일" class="input w-100 fix-size mt-10"   placeholder="요리사진을 첨부해주세요">
			</div>
			<div>
						레시피 해시태그 :
							<select name = "selectHashtag">
								<option value = "">선택</option>
								<c:forEach var = "selectHashtagList" items = "${selectHashtagList}">
									<option value = "${selectHashtagList.hashtagName}">${selectHashtagList.hashtagName}</option>
								</c:forEach>
							</select>
							</div>
		<div class = "row right">
					<a href="list" class="btn btn-neutral">돌아가기</a>
					<button type = "submit" class="btn">레시피 등록하기</button>
		</div>
</form>
</div>