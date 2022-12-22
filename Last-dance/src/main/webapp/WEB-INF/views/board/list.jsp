<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp">
   <jsp:param value="자유 게시판" name="title" />
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
.item-bold{
   font-weight: bold;
}
.item-color{
   color :gray;
}
 .float-container {
    width : 80%;
    display: flex;
    flex-direction: row;
 }
.all-thumbnail-box {
   position:relative;
   width : 30%;
   
}
.thumbnail-box {
   position: relative;
    left: 200px;
    object-fit: cover;
}

.thumbnail {
    width: 230px;
    height: 160px;
}
.btn {
    border: none;
    font-size: 15px;
    padding: 0.75em;/*글자 크기의 0.75배*/
    cursor: pointer;
    /* a 태그를 버튼으로 만들기 위해 추가 */
    display: inline-block;
    text-align: center;
    text-decoration: none;
    border-radius: 5px;
}
.btn.btn-positive {
    background-color: #35C5F0;
    color: white;
    font-weight: bold;
}
.btn.btn-positive:hover {
    background-color: #1E90FF;
}
.board-list-title{
   font-size : 22px;
   font-weight: 900;
}
.board-list-item{
   position : relative;
   display: flex;
    font-size: 15px;
    height: 30px;
    margin: 10px;
}
.board-list-content{
   margin : 40px;
   font-size:18px;
   margin-left :7px;
   height: 37px;
   font-weight: 500;
   overflow:hidden;
   text-overflow:ellipsis;
   
}
.badge {
   position : absolute;
   width: 20px;
}
.search {
   position: relative;
}
h3 {
   font-size: 14px;
   font-weight: 100;
}
input {
   width: 50%;
   border: 2px solid #bbb;
   border-radius: 8px;
   padding: 10px 12px;
   font-size: 14px;
}
.input.input-seach {
   padding-right: 2.5em;
   background-image: url("/images/search.png");
   background-size: 1em;
   background-repeat: no-repeat;
   background-position-x: 27.75em;
   background-position-y: center;
}
.board-search-btn {
   display: none;
}


.board-bottom{
   width:700px;
   border-bottom : 1px solid lightgray;
   
}

.notice-bottom {
   width:700px;
   border-bottom : 0.5px solid lightgray;
   
}


.f{
width: 20%;
}

.container-901 {
    width: 900px;
    margin: 0 auto;
    height: 170px;
}
.float-container1 {
    width: 80%;
    display: flex;
    flex-direction: row;
    margin-top: 30px;
}
.board-table {
    border-collapse: collapse;
    width: 85%;
    font-size: 16px;
    margin-left: auto;
    margin-right: auto;
}

.notice-box {
	display: flex;
}

.notice-title {
	border: 1px solid none;
	padding-left: 7px;
	padding-right: 7px;
	padding-top: 5px;
	padding-bottom: 5px;
	border-radius: 15px;
	background-color: #EFFBFF;
	color: #3BC5F0;
}

.notice-badge{
   width : 5%;
}
.notice{
	margin-left: 20px;
	margin-top: 23px;
	font-weight: 900;
}


</style>

<div class="container-901 mt-5 float-center ">

   <h1 align="center">나만의 레시피를 공유 해보세요!!</h1>
   <h3 class="mt-20" align="center">레시피를 작성/댓글 작성으로 참여도를 올려서 귀여운 뱃지를
      착용해보세요 :)</h3>
   <div class="center search mt-10">
      <select class="input-type input">
         
         <option value="board_title">제목</option>
         <option value="member_nick">작성자</option>
         <option value="board_content">내용</option>
      </select> <input class="input input-keyword input-seach" type="text"
         placeholder="검색어를 입력하세요">
      <button class="board-search-btn" type="button"></button>
   </div>
</div>


<table class="board-table">

<thead>
   <tr>
      <th colspan="12"><select class="sort-click float-left input">
            <option value="">정렬</option>
            <option value="board_writetime desc">최근 작성일 순</option>
            <option value="board_click desc">조회수 높은 순</option>
            <option value="board_like desc">추천 많은 순</option>
            <option value="reply_cnt desc">댓글 많은 순</option>
            
      </select> <a class="btn btn-positive float-right mt-10" href="write">글쓰기</a></th>
  </tr>
</thead>

  <c:forEach var="noticeDto" items="${noticeList}">
         
   <tr class="notice-bottom">
               <td>
               	<div class="notice-box">
                  <p class="notice-title">공지</p>
                  <a class="notice" href="/notice/detail/${noticeDto.noticeNo}">${noticeDto.noticeTitle}✌</a>
               	</div>
               </td>
   </tr>
   
  </c:forEach>
         
<tbody class="board-list center mt-50">
<c:forEach var="boardDto" items="${boardList}">
<tr class="board-bottom">
	<%-- <td>${boardDto.boardNo}</td> --%>
	<td>
		<div class="float-container1">
			<div class="float-left w-80">
				<div class="board-list-title left">
					<a href="detail?boardNo=${boardDto.boardNo}">
					${boardDto.boardTitle}</a>
				</div>
				<div class="board-content board-list-content left">
					<a href="detail?boardNo=${boardDto.boardNo}">
					${boardDto.boardContent}</a>         
				</div>
				<div class="board-list-item float-container left">
					<div class="w-20 item-bold">${boardDto.memberNick}
						<c:choose>
                    		<c:when test="${boardDto.memberPoint<=100}">
                    		
                    			<img class="badge" src="${pageContext.request.contextPath}/images/lev1.png"/>
                    		</c:when>
                    		<c:when test="${boardDto.memberPoint<=300}">
                    			
                    			<img class="badge" src="${pageContext.request.contextPath}/images/lev2.png"/>
                    		</c:when>
                    		<c:when test="${boardDto.memberPoint<=550}">
                    			
                    			<img class="badge" src="${pageContext.request.contextPath}/images/lev3.png"/>
                    		</c:when>
                    		<c:when test="${boardDto.memberPoint<=850}">
                    			
                    			<img class="badge" src="${pageContext.request.contextPath}/images/lev4.png"/>
                    		</c:when>
                    		<c:when test="${boardDto.memberPoint<=1200}">
                    			
                    			<img class="badge" src="${pageContext.request.contextPath}/images/lev5.png"/>
                    		</c:when>
                    		<c:when test="${boardDto.memberPoint<=1600}">
                    			
                    			<img class="badge" src="${pageContext.request.contextPath}/images/lev6.png"/>
                    		</c:when>
                    		<c:when test="${boardDto.memberPoint<=2050}">
                    			
                    			<img class="badge" src="${pageContext.request.contextPath}/images/lev7.png"/>
                    		</c:when>
                    		<c:when test="${boardDto.memberPoint<=2500}">
                    			
                    			<img class="badge" src="${pageContext.request.contextPath}/images/lev8.png"/>
                    		</c:when>
                    		<c:when test="${boardDto.memberPoint<3000}">
                    			
                    			<img class="badge" src="${pageContext.request.contextPath}/images/lev9.png"/>
                    		</c:when>
                    		<c:when test="${boardDto.memberPoint==3000}">
                    			
                    			<img class="badge" src="${pageContext.request.contextPath}/images/lev10.png"/>
                    		</c:when>
                    	</c:choose>
					</div>         
					<div class="f">${boardDto.boardWriteTime}</div>
					<div class="f item-color">추천 :${boardDto.boardLike}</div>
					<div class="f item-color">조회수 : ${boardDto.boardClick}</div>
					<div class="f item-color">댓글 : ${boardDto.replyCnt}</div>
				</div>
			</div>
			<div class="all-thumbnail-box w-20">
				<div class="thumbnail-box">
					 <img class="thumbnail w-100" src="${pageContext.request.contextPath}/rest/download/${boardDto.boardAttachmentNo}" onerror="this.style.display='none';">			
				</div>
			</div>                  
		</div>
	</td>
</tr>
</c:forEach>
   </tbody>
   
   <tfoot>
   		<tr>
   			<td>
   				<div class="center">
   					<button class="board-plus-btn btn w-100" type=button>더보기</button>
   					<button class="top btn" type=button>위로</button>
   				</div>
   			</td>
   		</tr>
   </tfoot>
</table>
<br>



<script type="text/javascript">
   $(function() {
      $(".board-content").find("img").remove();
      var contentCnt = $(".board-content");
      for(var i=0; i<contentCnt.length; i++){
         $(".board-content").eq(i).text($(".board-content").eq(i).text());
      }
      /* 레시피 검색창에서 엔터치면 검색 */
      $(".input-keyword").keydown(function(e) {
         if (e.keyCode == 13) {
            $(".board-search-btn").click();
         }
      });
      
      $(".top").click(function() {
    	  $("html, body").animate({ scrollTop: 0 }, "slow");
    	  return false;
    	});
      
      	var p = 1;
		
		$(".board-plus-btn").click(function(){
			var sort = $(".sort-click").val();
            var type = $(".input-type").val();
            var keyword = $(".input-keyword").val();
				p = p+1;
			
			$.ajax({
		           url: "http://localhost:8888/rest/board",
		           method: "post",
		           contentType: "application/json",
		           data: JSON.stringify({
		        	   type : type,
                       keyword : keyword,
                       sort : sort,
		             	 p : p
         	}),
         	success: function(resp){
           	console.log(resp);
           /* 	$(".board-list").empty(); */
            for (var i = 0; i < resp.length; i++) {
                
            	
            	var divSecond1 = $("<div>").addClass("float-left w-80")
            	
            	var title = $("<a>").attr("href","detail?boardNo="+ resp[i].boardNo).text(resp[i].boardTitle);
                var divTitle = $("<div>").addClass("board-list-title left").append(title);
                 
                var content = $("<a>").attr("href","detail?boardNo="+ resp[i].boardNo)
                	.html(resp[i].boardContent);
                var divContent = $("<div>").addClass("board-content board-list-content left").append(content);
                
                var url = "";
                if (resp[i].memberPoint <= 100) {
                   url = "/images/lev1.png";
                }
                else if(resp[i].memberPoint <= 300){
                	url = "/images/lev2.png";
                }
                else if(resp[i].memberPoint <= 550){
                	url = "/images/lev3.png";
                }
                else if(resp[i].memberPoint <= 850){
                	url = "/images/lev4.png";
                }
                else if(resp[i].memberPoint <= 1200){
                	url = "/images/lev5.png";
                }
                else if(resp[i].memberPoint <= 1600){
                	url = "/images/lev6.png";
                }
                else if(resp[i].memberPoint <= 2050){
                	url = "/images/lev7.png";
                }
                else if(resp[i].memberPoint <= 2500){
                	url = "/images/lev8.png";
                }
                else if(resp[i].memberPoint <= 3000){
                	url = "/images/lev9.png";
                } 
                else if(resp[i].memberPoint == 3000){
                	url = "/images/lev10.png";
                }
                
             
                var badge = $("<img>").attr("src", url)
                .addClass("badge");
                
                var nick = $("<div>").addClass("w-20 item-bold")
                .text(resp[i].memberNick)
                .append(badge);
                
                
                var tdWriteTime = $("<div>").addClass("f").text(resp[i].boardWriteTime);
                                                                                    
                var Like = $("<div>").addClass("f item-color").text("추천 :"+resp[i].boardLike);
                
                var Click = $("<div>").addClass("f item-color").text("조회수 : "+resp[i].boardClick);
                
                var Reply = $("<div>").addClass("f item-color").text("댓글 : " +resp[i].replyCnt);
                
                
                var divNick =  $("<div>").addClass("board-list-item float-container left")
                      .append(nick).append(tdWriteTime)
                      .append(Like).append(Click).append(Reply);
 
 
 				divSecond1.append(divTitle).append(divContent).append(divNick);
                      

                var thumbnailImg = $("<img>").addClass("thumbnail w-100").attr("src", "${pageContext.request.contextPath}/rest/download/"+resp[i].boardAttachmentNo).attr("onerror","this.style.display='none'");
               // var thumbnailImg = $("<img>").addClass("thumbnail").attr("src", "${pageContext.request.contextPath}/images/image 3.png");
                var thumbnail = $("<div>").addClass("thumbnail-box").append(thumbnailImg);
                var divSecond2 = $("<div>").addClass("all-thumbnail-box w-20").append(thumbnail);
                
            	var divFirst1 = $("<div>").addClass("float-container1").append(divSecond1).append(divSecond2);
            	var td = $("<td>").append(divFirst1);
            	var tr = $("<tr>").addClass("board-bottom").append(td);
            	
                $(".board-list").append(tr);
             }
                $(".board-content").find("img").remove();
           	   	var contentCnt = $(".board-content");
                for(var i=0; i<contentCnt.length; i++){
                   $(".board-content").eq(i).text($(".board-content").eq(i).text());
                }
          }
       });
});
      
    /*   /* 레시피 리스트 검색 */
      $(".board-search-btn").click(function() {
                     var sort = $(".sort-click").val();
                     var type = $(".input-type").val();
                     var keyword = $(".input-keyword").val();
                     if (type == "" || keyword == "") {
                        alert("검색어는 필수 입력입니다.");
                        return;
                     }
                     $.ajax({
                              url : "http://localhost:8888/rest/board",
                              method : "post",
                              contentType : "application/json",
                              data : JSON.stringify({
                            	  type : type,
                                  keyword : keyword,
                                  sort : sort,
           		             		p : p
                                 
                              }),
                              success : function(resp) {
                                 $(".board-list").empty();
                                 for (var i = 0; i < resp.length; i++) {
                                
                                	
                                	var divSecond1 = $("<div>").addClass("float-left w-80")
                                	
                                	var title = $("<a>").attr("href","detail?boardNo="+ resp[i].boardNo).text(resp[i].boardTitle);
                                    var divTitle = $("<div>").addClass("board-list-title left").append(title);
                                     
                                    var content = $("<a>").attr("href","detail?boardNo="+ resp[i].boardNo)
                                    	.html(resp[i].boardContent);
                                    var divContent = $("<div>").addClass("board-content board-list-content left").append(content);
                                    
                                    var url = "";
                                    if (resp[i].memberPoint <= 100) {
                                        url = "/images/lev1.png";
                                     }
                                     else if(resp[i].memberPoint <= 300){
                                     	url = "/images/lev2.png";
                                     }
                                     else if(resp[i].memberPoint <= 550){
                                     	url = "/images/lev3.png";
                                     }
                                     else if(resp[i].memberPoint <= 850){
                                     	url = "/images/lev4.png";
                                     }
                                     else if(resp[i].memberPoint <= 1200){
                                     	url = "/images/lev5.png";
                                     }
                                     else if(resp[i].memberPoint <= 1600){
                                     	url = "/images/lev6.png";
                                     }
                                     else if(resp[i].memberPoint <= 2050){
                                     	url = "/images/lev7.png";
                                     }
                                     else if(resp[i].memberPoint <= 2500){
                                     	url = "/images/lev8.png";
                                     }
                                     else if(resp[i].memberPoint <= 3000){
                                     	url = "/images/lev9.png";
                                     } 
                                     else if(resp[i].memberPoint == 3000){
                                     	url = "/images/lev10.png";
                                     }
                                    var badge = $("<img>").attr("src", url)
                                    .addClass("badge");
                                    
                                    var nick = $("<div>").addClass("w-20 item-bold")
                                    .text(resp[i].memberNick)
                                    .append(badge);
                                    
                                    
                                    var tdWriteTime = $("<div>").addClass("f").text(resp[i].boardWriteTime);
                                                                                                        
                                    var Like = $("<div>").addClass("f item-color").text("추천 :"+resp[i].boardLike);
                                    
                                    var Click = $("<div>").addClass("f item-color").text("조회수 : "+resp[i].boardClick);
                                    
                                    var Reply = $("<div>").addClass("f item-color").text("댓글 : " +resp[i].replyCnt);
                                    
                                    
                                    var divNick =  $("<div>").addClass("board-list-item float-container left")
                                          .append(nick).append(tdWriteTime)
                                          .append(Like).append(Click).append(Reply);
                     
                     
                     				divSecond1.append(divTitle).append(divContent).append(divNick);
                                          

                                    var thumbnailImg = $("<img>").addClass("thumbnail w-100").attr("src", "${pageContext.request.contextPath}/rest/download/"+resp[i].boardAttachmentNo).attr("onerror","this.style.display='none'");
                                   // var thumbnailImg = $("<img>").addClass("thumbnail").attr("src", "${pageContext.request.contextPath}/images/image 3.png");
                                    var thumbnail = $("<div>").addClass("thumbnail-box").append(thumbnailImg);
                                    var divSecond2 = $("<div>").addClass("all-thumbnail-box w-20").append(thumbnail);
                                    
                                	var divFirst1 = $("<div>").addClass("float-container1").append(divSecond1).append(divSecond2);
                                	var td = $("<td>").append(divFirst1);
                                	var tr = $("<tr>").addClass("board-bottom").append(td);
                                	
                                    $(".board-list").append(tr);
                                    $(".board-content").find("img").remove();
                                    var contentCnt = $(".board-content");
                                    for(var i=0; i<contentCnt.length; i++){
                                       $(".board-content").eq(i).text($(".board-content").eq(i).text());
                                    }
                                 }
                              }
                           });
                  });
      /* 레시피 리스트 정렬 */
      $(".sort-click").on(
            "input",
            function() {
               var sort = $(this).val();
               var type = $(".input-type").val();
               var keyword = $(".input-keyword").val();
               $.ajax({
                  url : "http://localhost:8888/rest/board",
                  method : "post",
                  contentType : "application/json",
                  data : JSON.stringify({
                	  type : type,
                      keyword : keyword,
                      sort : sort,
		             p : p
                     
                  }),
                  success : function(resp) {

                	  $(".board-list").empty();
                      for (var i = 0; i < resp.length; i++) {
                     
                     	
                     	var divSecond1 = $("<div>").addClass("float-left w-80")
                     	
                     	var title = $("<a>").attr("href","detail?boardNo="+ resp[i].boardNo).text(resp[i].boardTitle);
                         var divTitle = $("<div>").addClass("board-list-title left").append(title);
                          
                         var content = $("<a>").attr("href","detail?boardNo="+ resp[i].boardNo)
                         	.html(resp[i].boardContent);
                         var divContent = $("<div>").addClass("board-content board-list-content left").append(content);
                         
                         if (resp[i].memberPoint <= 100) {
                             url = "/images/lev1.png";
                          }
                          else if(resp[i].memberPoint <= 300){
                          	url = "/images/lev2.png";
                          }
                          else if(resp[i].memberPoint <= 550){
                          	url = "/images/lev3.png";
                          }
                          else if(resp[i].memberPoint <= 850){
                          	url = "/images/lev4.png";
                          }
                          else if(resp[i].memberPoint <= 1200){
                          	url = "/images/lev5.png";
                          }
                          else if(resp[i].memberPoint <= 1600){
                          	url = "/images/lev6.png";
                          }
                          else if(resp[i].memberPoint <= 2050){
                          	url = "/images/lev7.png";
                          }
                          else if(resp[i].memberPoint <= 2500){
                          	url = "/images/lev8.png";
                          }
                          else if(resp[i].memberPoint <= 3000){
                          	url = "/images/lev9.png";
                          } 
                          else if(resp[i].memberPoint == 3000){
                          	url = "/images/lev10.png";
                          }
                         var badge = $("<img>").attr("src", url)
                         .addClass("badge");
                         
                         var nick = $("<div>").addClass("w-20 item-bold")
                         .text(resp[i].memberNick)
                         .append(badge);
                         
                         
                         var tdWriteTime = $("<div>").addClass("f").text(resp[i].boardWriteTime);
                                                                                             
                         var Like = $("<div>").addClass("f item-color").text("추천 :"+resp[i].boardLike);
                         
                         var Click = $("<div>").addClass("f item-color").text("조회수 : "+resp[i].boardClick);
                         
                         var Reply = $("<div>").addClass("f item-color").text("댓글 : " +resp[i].replyCnt);
                         
                         
                         var divNick =  $("<div>").addClass("board-list-item float-container left")
                               .append(nick)
                               .append(tdWriteTime)   
                               
                               .append(Like)
                               .append(Click)
                               .append(Reply);
          
          
          				divSecond1.append(divTitle).append(divContent).append(divNick);
                               

                       var thumbnailImg = $("<img>").addClass("thumbnail w-100").attr("src", "${pageContext.request.contextPath}/rest/download/"+resp[i].boardAttachmentNo).attr("onerror","this.style.display='none'");
                      //   var thumbnailImg = $("<img>").addClass("thumbnail").attr("src", "${pageContext.request.contextPath}/images/image 3.png");
                         var thumbnail = $("<div>").addClass("thumbnail-box").append(thumbnailImg);
                         var divSecond2 = $("<div>").addClass("all-thumbnail-box w-20").append(thumbnail);
                         
                     	var divFirst1 = $("<div>").addClass("float-container1").append(divSecond1).append(divSecond2);
                     	var td = $("<td>").append(divFirst1);
                     	var tr = $("<tr>").addClass("board-bottom").append(td);
                     	
                         $(".board-list").append(tr);
                         $(".board-content").find("img").remove();
                         var contentCnt = $(".board-content");
                         for(var i=0; i<contentCnt.length; i++){
                            $(".board-content").eq(i).text($(".board-content").eq(i).text());
                         }
                      }

                  }
               });
            }); 
   });
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

