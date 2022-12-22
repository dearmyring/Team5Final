<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="login" value="${loginId != null}"></c:set>

<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
   href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
   rel="stylesheet" />

<link rel="stylesheet" type="text/css" href="/css/reset.css" />
<link rel="stylesheet" type="text/css" href="/css/commons.css" />
<link rel="stylesheet" type="text/css" href="/css/recipeList.css" />

<link rel="stylesheet" type="text/css"    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />

<jsp:include page="/WEB-INF/views/template/header.jsp">
   <jsp:param value="레시피 리스트" name="title" />
</jsp:include>

<c:choose>
	<c:when test="${login}">
	<!-- 사이드 배너 템플릿 -->
	<jsp:include page="/WEB-INF/views/template/side-banner.jsp"></jsp:include>
	</c:when>
</c:choose>

<style>
/*
                  Flextbox 특징
                  1. flex 설정은 개별 항목이 아닌 영역에 한다
                  2. 배치 방향을 flex-direction 속성으로 지정할 수 있다
                  3. 폭을 지정하지 않으면 자동으로 비율로 할당되게 구현할 수있다
                      - flex-grow 속성
                  4. 줄바꿈 허용/불가를 flex-wrap 속성으로 설정할 수 있다
                  5. 정렬기준을 손쉽게 설정할 수 있다
                      - justify-content로 내부 항목의 가로 배치 형식을 설정할 수 있다
                      - align-items로 내부 항목의 세로 배치 형식을 설정할 수 있다
                  6. 내부 항목들의 배치 순서를 변경할 수 있다(개별 설정)
                      - order 속성
              */
.layout {
   max-width: 1330px;
   margin: 0 auto;
   padding: 20px;
   display: flex;
   flex-wrap: wrap gap: 1em;
}
article {
   flex-basis: 1250px;
   flex-grow: 1;
   flex-shrink: 1;
}
.flexbox {
   display: flex;
   flex-wrap: wrap;
   flex-direction: row;
   gap: 1em;
   /*background-color: #f0f0f0;*/
   justify-content: center;
}
.recipe-recommend{
   display: flex;
    flex-direction: row;
    height: 130px;
}
.recipe-recommend-text{
   font-size: 30px;
    font-weight: 600;
    margin: 35px 40px 30px 30px;
}
.recipe-box-shadow {
    box-shadow: 0px 0px 30px 0px rgb(0 0 0 / 10%);
    border-radius: 10px;
    margin-bottom: 60px;
}
.ingredient-box {
    height: 80px;
    overflow: auto;
  }
  
  .ingredient-name-box{
   display: inline-block;
   border: none;
   background-color: #88db9d;
   text-align: center;
   padding: 0.5em 0.8em 0.5em 0.8em;
   border-radius: 7px;
   font-weight: 600;
   color: white;
   font-size: 14px;
   margin: 6 2 3;
  }
.item {
   min-height: 200px;
   flex-shrink: 1;
   flex-grow: 1;
   position: relative;
}
.img-thumnail {
   width: 350px;
    height: 240px;
    object-fit: cover;
}
.img-box {
   position: relative;
}
.info-box{
    height: 235px;
    width: 350px;
    padding: 15px;
    display:block;
}
.hash-tag {
    position: absolute;
    top: 20px;
    left: 20px;
   font-size: 15px;
   padding: 0.5em 0.8em 0.5em 0.8em;
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
   font-size: 13px;
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
   font-size: 13px;
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
   font-size: 13px;
   margin: 0 3px;
}
.need-ingredient {
   display: inline-block;
   border: none;
   background-color: #abc9cc;
   text-align: center;
   padding: 0.5em 0.8em 0.5em 0.8em;
   border-radius: 7px;
   font-weight: 600;
   color: white;
   font-size: 13px;
   margin: 0 3px;
}
.recipe-info {
    color: #373A3C;
    font-size: 23px;
    font-weight: bold;
    height: 68;
    margin: 6 0 12;
    padding: 10px;
    display: block;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    line-height: 1.2;
}
.view-count, .like-count {
   margin: 10px;
   font-size: 13px;
   color: #757575;
}
.like-count {
   left: 30px;
}
.img-box {
   top: 0px;
   left: 0px;
   width: 100%;
    height: 240px;
   border-radius: 10px 10px 0 0;
   overflow: hidden;
}
.simple-info{
margin : 0 30px;
height  : 25px;
}
.float-margin-left{
   float: left;
    margin-left: 30px;
    margin-right: 30px;
}
.sort-click{
   font-size: 15px;
    font-weight: 600;
    height: 40;
    color: #373A3C;
    margin: 32px 40px 32px 40px;
    }
.sort-select{
padding: 10px;
width: 100px;
}
.yellow-btn{
 width: 120px;
 color: #373A3C;
 font-size: 18px;
 font-weight: bold;
 height: 50;
}
</style>
</head>
<body>
   <div class="layout">
      <article>
         <div class="recipe-recommend">         
          <c:choose>
         <c:when test="${loginId != null}">    
            <div class="recipe-recommend-text w-70">안녕하세요 ${loginNick}님, 요리를 시작해볼까요?</div>
            </c:when> 
            <c:otherwise>
            <div class="recipe-recommend-text w-70">다양한 레시피를 보고 손쉽게 요리를 해보세요~</div>
            </c:otherwise>
             </c:choose>
            <div class= "sort-select w-30">
               <select class="sort-click form-select">
                  <option value="recipe_no desc">최근 작성일 순</option>
                  <option value="recipe_click desc">조회수 높은 순</option>
                  <option value="recipe_like desc">좋아요 많은 순</option>
                  <option value="recipe_time asc">조리시간 짧은 순</option>
                  <option value="recipe_time desc">조리시간 긴 순</option>
               </select>
            </div>
         </div>

         <div class="flexbox">
            <div class="item float-container">
               <c:forEach var="recipeListVO" items="${recipeList}">
               <a href="/recipe/detail?recipeNo=${recipeListVO.recipeDto.recipeNo}">
                  <div class="list add-recipe-box recipe-box-shadow main-1 container-350 float-margin-left">
                  
                     <div class="img-box">
                        <div class="hash-tag">${recipeListVO.recipeDto.recipeHashtag}</div>
                        <c:forEach var="recipeImg" begin="0" end="0" step="1" items="${recipeListVO.recipeImgList}">
                           <img class="img-thumnail"
                              src="${pageContext.request.contextPath}/rest/download/${recipeImg.recipeAttachmentNo}">
                        </c:forEach>
                     </div>

                     <div class="info-box">
                     
                        <span class="view-count">조회수 ${recipeListVO.recipeDto.recipeClick}</span> 
                        <span class="like-count">좋아요 ${recipeListVO.recipeDto.recipeLike}</span>
                        <div class="recipe-info">${recipeListVO.recipeDto.recipeInfo}</div>
                        
                        <div class="simpe-info">
	                        <div class="how-long">
	                           <i class="fa-regular fa-clock"></i>
	                           ${recipeListVO.recipeDto.recipeTime}분 이내
	                        </div>
	                        <div class="need-ingredient">필요 재료 : ${recipeListVO.recipeIngredientList.size()}개 </div>
	                        <div class="cooking-level">${recipeListVO.recipeDto.recipeDifficulty}</div>
                        </div>
                        
                        <div class="ingredient-box scroll">
	                        <c:forEach var="ingredient" items="${recipeListVO.recipeIngredientList}">
	                           <div class="ingredient-name-box mt-10"> ${ingredient.recipeIngredientName}</div>
	                        </c:forEach>
                     </div>
                     
                     </div>                     
                  </div>
                  </a>
               </c:forEach>
            </div>
            
           <div class="container-fluid row center"><button class="yellow-btn more">더보기</button></div>                 
         </div>
      </article>
   </div>
   

<script type="text/javascript">
          
       /* 레시피 리스트 정렬 */
      $(".sort-click").on("input", function(){
         var sort = $(this).val();
         $.ajax({
            url: "http://localhost:8888/rest/recipe",
            method: "post",
            contentType: "application/json",
            data: JSON.stringify({
               sort: sort
            }),
            success: function(resp){
               $(".list").find("a").remove();
               for(var i=0; i<resp.length; i++){
                  var a = $("<a>");
                  var acheck = $("<input>").addClass("check-item").attr("name", "recipeNo").val(resp[i].recipeNo).attr("type", "checkbox");
                  var listCheck = $("<list>").append(check); 
                  var link = $("<a>").addClass("text-decoration-none link-dark")
               .attr("href", "detail/"+resp[i].recipeNo).text(resp[i].recipeTitle);
                  var listThumbnail = $("<td>").addClass("img-thumnail").append(link); /*첨부파일은 파일이아니라 링크? 주소를 가져오는것 주소로 다 가져올수 있음*/
                  var listInfo = $("<list>").append($("<a>").attr("src", "detail/"+resp[i].recipeNo).text(resp[i].recipeInfo));
                  var listClick = $("<list>").text(resp[i].recipeClick);   /*${pageContext.request.contextPath}/rest/download/${recipeImg.recipeAttachmentNo}*/
                  var listLike = $("<list>").text(resp[i].recipeLike);
                  var listTime = $("<list>").text(resp[i].recipeTime+'분');
               /*   var listEnough = $("<list>").text(resp[i].recipeEnough);
                  var listLack = $("<list>").text(resp[i].recipeLack);*/
                  var listDifficulty = $("<list>").text(resp[i].recipeDifficulty);
                  var listIngredient = $("<list>").text(resp[i].recipeIngredientName);
                  list.append(aCheck).append(listThumbnail).append(listInfo).append(listClick).append(listLike).append(listTime)
                  .append(listDifficulty).append(listIngredient);
                  $(".list").append(a);
               }
            }
         });
      });       
	
	 $(function(){
		// 초기 페이지를 1페이지로
		var p = 1;
		
		$(".more").click(function(){
			
			p = p+1;
			
			$.ajax({
		           url: "http://localhost:8888/rest/recipe1",
		           method: "post",
		           contentType: "application/json",
		           data: JSON.stringify({
		              p : p
           	}),
           	success: function(resp){
             	console.log(resp);
             	
 		               for(var i = 0 ; i < resp.length ; i ++) {					          
 			              var div_outer_container = $("<a>").attr("href", "/recipe/detail?recipeNo=" + resp[i].recipeDto.recipeNo);				              			              
			             
 			              var div_inner_container = $("<div>").attr("class", "list add-recipe-box recipe-box-shadow main-1 container-350 float-margin-left");
			              
			              
  			              var div_img_container = $("<div>").attr("class", "img-box");		    			              
			              
 			              var div_hashtag = $("<div>").attr("class", "hash-tag").html(resp[i].recipeDto.recipeHashtag);	
			              
  			              div_img_container.append(div_hashtag);
			              
   			               var div_img;
 			              for(var j= 0 ; j < resp[i].recipeImgList.length ; j++) {	
   			            	  div_img = div_img_container.append($("<img>").attr("class", "img-thumnail").attr("src", "/rest/download/" + resp[i].recipeImgList[j].recipeAttachmentNo));          	          
   			              }		
			                    
  			              var div_info_container = $("<div>").attr("class", "info-box");	
   			              var span_click =$("<span>").attr("class","view-count").text("조회수 " + resp[i].recipeDto.recipeClick); 		  //2-1            
   			              var span_like = $("<span>").attr("class", "like-count").text(" 좋아요 " + resp[i].recipeDto.recipeLike); 	 //2-2
   			              var div_recipe_info = $("<div>").attr("class", "recipe-info").text(resp[i].recipeDto.recipeInfo); //2-3
			              			              		            			              
 			              var div_simple_info_container = $("<div>").attr("class", "simpe-info");    		             
			              var div_difficulty = $("<div>").attr("class", "cooking-level").text(resp[i].recipeDto.recipeDifficulty); 				              
   			              var div_ingredient_count = $("<div>").attr("class", "need-ingredient").html("필요 재료 : " +resp[i].recipeIngredientList.length+"개"); 
  			              var div_time = $("<div>").attr("class", "how-long").text(" "+resp[i].recipeDto.recipeTime+"분 이내").prepend($("<i>").attr("class","fa-regular fa-clock"));         		                         
		                          
  			              
 			              var div_ingredient_container = $("<div>").attr("class","ingredient-box scroll");
 			              var ingredient_box; //2-5
  			               for(var k = 0 ; k < resp[i].recipeIngredientList.length ; k ++) {
  			            	 ingredient_box =  div_ingredient_container.append($("<div>").attr("class", "ingredient-name-box mt-10").text(resp[i].recipeIngredientList[k].recipeIngredientName));  	   
			               }
  			               			               
 			           	  //var ingredient_box = div_ingredient_container.append(div_ingredient);
 			           	  
 	 		              var simple_info = div_simple_info_container.append(div_time).append(div_ingredient_count).append(div_difficulty); //2-4
  			              var div_info = div_info_container.append(span_click).append(span_like).append(div_recipe_info).append(simple_info).append(div_ingredient_container);	      
 			              var div_inner = div_inner_container.append(div_img_container).append(div_info_container);	
			              var div_outer = div_outer_container.append(div_inner);	
			              $(".item").append(div_outer);
 		              }
		              
 		             
		               
		           }
		        });
		})
	}); 
	 
 	/* 레시피 리스트 정렬 */
		$(".sort-click").on("input", function(){
			var sort = $(this).val();
			console.log(sort);
			var data = {
					sort: sort,
					p: 1,
					table: "recipe"
			};
			$.ajax({
		           url: "http://localhost:8888/rest/recipe1",
		           method: "post",
		           contentType: "application/json",
		           data: JSON.stringify(data),
        	success: function(resp){
          	console.log(resp);
          	$(".item").empty();
          	
		               for(var i = 0 ; i < resp.length ; i ++) {					          
			              var div_outer_container = $("<a>").attr("href", "/recipe/detail?recipeNo=" + resp[i].recipeDto.recipeNo);				              			              
			             
			              var div_inner_container = $("<div>").attr("class", "list add-recipe-box recipe-box-shadow main-1 container-350 float-margin-left");
			              
			              
			              var div_img_container = $("<div>").attr("class", "img-box");		    			              
			              
			              var div_hashtag = $("<div>").attr("class", "hash-tag").html(resp[i].recipeDto.recipeHashtag);	
			              
			              div_img_container.append(div_hashtag);
			              
			               var div_img;
			              for(var j= 0 ; j < resp[i].recipeImgList.length ; j++) {	
			            	  div_img = div_img_container.append($("<img>").attr("class", "img-thumnail").attr("src", "/rest/download/" + resp[i].recipeImgList[j].recipeAttachmentNo));          	          
			              }		
			                    
			              var div_info_container = $("<div>").attr("class", "info-box");	
			              var span_click =$("<span>").attr("class","view-count").text("조회수 " + resp[i].recipeDto.recipeClick); 		  //2-1            
			              var span_like = $("<span>").attr("class", "like-count").text(" 좋아요 " + resp[i].recipeDto.recipeLike); 	 //2-2
			              var div_recipe_info = $("<div>").attr("class", "recipe-info").text(resp[i].recipeDto.recipeInfo); //2-3
			              			              		            			              
			              var div_simple_info_container = $("<div>").attr("class", "simpe-info");    		             
			              var div_difficulty = $("<div>").attr("class", "cooking-level").text(resp[i].recipeDto.recipeDifficulty); 				              
			              var div_ingredient_count = $("<div>").attr("class", "need-ingredient").html("필요 재료 : " +resp[i].recipeIngredientList.length+"개"); 
			              var div_time = $("<div>").attr("class", "how-long").text(" "+resp[i].recipeDto.recipeTime+"분 이내").prepend($("<i>").attr("class","fa-regular fa-clock"));         		                         
		                          
			              
			              var div_ingredient_container = $("<div>").attr("class","ingredient-box scroll");
			              var ingredient_box; //2-5
			               for(var k = 0 ; k < resp[i].recipeIngredientList.length ; k ++) {
			            	 ingredient_box =  div_ingredient_container.append($("<div>").attr("class", "ingredient-name-box mt-10").text(resp[i].recipeIngredientList[k].recipeIngredientName));  	   
			               }
			               			               
			           	  //var ingredient_box = div_ingredient_container.append(div_ingredient);
			           	  
	 		              var simple_info = div_simple_info_container.append(div_time).append(div_ingredient_count).append(div_difficulty); //2-4
			              var div_info = div_info_container.append(span_click).append(span_like).append(div_recipe_info).append(simple_info).append(div_ingredient_container);	      
			              var div_inner = div_inner_container.append(div_img_container).append(div_info_container);	
			              var div_outer = div_outer_container.append(div_inner);	
			              $(".item").append(div_outer);
		              }
		              
		             
		               
		           }
		        });
		});
	 
</script>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>