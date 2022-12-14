<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="레시피 리스트" name="title"/>
</jsp:include>
<style>
          .layout{
          max-width: 1200px;
          margin: 0 auto;
          padding: 20px;
          display: flex;
          flex-wrap: wrap
          gap: 1em;
      }

      article{
          flex-basis: 1100px;
          flex-grow: 1;
          flex-shrink: 1;
      }
      .flexbox{
          display: flex;
          flex-wrap: wrap;
          gap: 1em;
          padding: 10px;
          background-color: #f0f0f0;
          display: flex;
          flex-direction: row;
          flex-wrap: wrap;
          justify-content: center;
      }
      .item{
          min-height: 150px;
          flex-basis: 300px;
          flex-shrink: 1;
          flex-grow: 1;
          margin: 0 10px;
          position:relative;
      }

      .main-1-img {
      			width: 100%;
      			height:100%;
      			object-fit:cover;
      		}
      		
      	.main-heading {
			bottom: 13px;
			left: 400px;
		}

              .hash-tag {
      			position: absolute;
      			top: 20px;
      			left: 20px;
      		   	border: none;
      		    font-size: 15px;
      		    padding: 0.5em 1em 0.5em 1em;
      		    display: inline-block;
      		    text-align: center;
      		    text-decoration: none;
      		    border-radius: 10px;
      		    color: #373A3C;
      		    background-color: #EEEEEE;
      		}

              .hashtag-box {
      			left: 20px;
      			display: inline-block;
      			border: none;
      			background-color: #8BC96E;
      			text-align: center;
      			padding: 0.5em 0.8em 0.5em 0.8em;
      			border-radius: 7px;
      			font-weight: 600;
      			color: white;
      			font-size:13px;
      		}

              .how-long {
      			display: inline-block;
      			border: none;
      			background-color: #EDEDED;
      			text-align: center;
      			padding: 0.5em 0.8em 0.5em 0.8em;
      			border-radius: 7px;
      			font-weight: 600;
      			color: #757575;
      			font-size:13px;
      		}

      		.cooking-level {
      			display: inline-block;
      			border: none;
      			background-color: #ECBE42;
      			text-align: center;
      			padding: 0.5em 0.8em 0.5em 0.8em;
      			border-radius: 7px;
      			font-weight: 600;
      			color: white;
      			font-size:13px;
      		}

              .recipe-title {
      			color: #373A3C;
      			font-size: 23px;
      			font-weight: bold;
				margin: 10px 0 2px 0;
      			padding: 5px;
      		}

              .view-count,
      		.like-count {
				padding: 10px;
      			font-size:13px;
      			color: #757575;
      		}


              .img-box {
      			top: 0px;
      			left: 0px;
      			width: 100%;
      			height: 100%;
      			border-radius: 10px 10px 0 0;
      			overflow: hidden;
      		}
    </style>
  </head>
  <body>
    <div class="layout">
      <article>
			<h1>
				<span class="main-heading-text">${loginNick}님이 당장 할  수 있는 요리를 추천해드릴게요.</span><br><br>
			</h1>

        <div class="flexbox">
          <div class="item float-container">
            <div class="add-recipe-box main-box-shadow main-1 container-300 float-left">
            
            <c:forEach var = "recipeListVO" items = "${recipeList}">
              <div class="img-box">
                <div class="hash-tag">${recipeListVO.recipeDto.recipeHashtag}</div>                
               		 <c:forEach var="recipeImg" items="${recipeImgList}">
						<img class="main-1-img" src="${pageContext.request.contextPath}/rest/download/${recipeImg}"  >
					</c:forEach>                
              </div>

              <div class="info-box">
                <span class="view-count">조회수 ${recipeListVO.recipeDto.recipeClick}</span>
                <span class="like-count">좋아요 ${recipeListVO.recipeDto.recipeLike}</span>
                <div class="recipe-title">${recipeListVO.recipeDto.recipeTitle}</div>
                <div class="how-long mt-10 me-5">
                  <i class="fa-regular fa-clock"></i>
                  ${recipeListVO.recipeDto.recipeTime}분 이내
                </div>   
                 <div class="cooking-level">충분 불충분</div>
                  <div class="cooking-level">${recipeListVO.recipeDto.recipeDifficulty}</div>
                	<c:forEach var="ingredient" items="${recipeListVO.recipeIngredientList}">
		                 <div class="hashtag-box mt-10"> ${ingredient.recipeIngredientName} </div>
		            </c:forEach>        
              </div>
              </c:forEach>
            </div>
          </div>
        </div>
      </article>
    </div>
  </body>
</html>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

	


