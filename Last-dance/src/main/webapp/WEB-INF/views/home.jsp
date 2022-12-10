<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp">
	<jsp:param value="회원가입" name="title"/>
</jsp:include>

	<h1>홈</h1>
	


<div>	
	<form action="findIngredient" method="post" class="ingredient-search-form">

<div>
   <input type="text" class="input-ingredient" placeholder="재료를 입력해주세요.">
   <button type="button" class="difficulty-clear">모두 지우기</button>
</div>

<div class="search-ingredient"></div>
<div class="add-ingredient"></div>

</form>
</div>

<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
    $(function(){
       /* 재료 입력 비동기 불러오기 */
       $(".input-ingredient").on("input", function(){
            setTimeout(() => {
                var search = $(".input-ingredient").val();
                if(search == ""){
                    $(".ingredientSearch").remove();
                }
                else{
                    $.ajax({
                        url: "http://localhost:8888/rest/ingredient/"+search,
                        method: "get",
                        success: function(resp){
                            $(".ingredientSearch").remove();
                            for(var i=0; i<resp.length; i++){
                                var pTag = $("<p>")
                                    .addClass("ingredientSearch")
                                    .text(resp[i]);
                                
                                pTag.click(function(){
                                    var xMark = $("<i>").addClass("fa-solid fa-xmark");
                                    xMark.click(function(){
                                        $(this).parent().remove();
                                    });
                                    
                                    var p = $("<p>")
                                   var input = $("<input>")
                              .attr("readolny", true)
                                       .attr("name", "recipeIngredientName")
                                       .val($(this).text());
                                    p.append(input).append(xMark);
                                    $(".add-ingredient").append(p);
                                    $(".ingredientSearch").remove();
                                    $(".input-ingredient").val("");
                                });
                                
                                $(".search-ingredient").append(pTag);
                            }
                        }
                    });
                }
            }, 1000);
        });

       /* 재료 엔터 등록 */
       $(".input-ingredient").keydown(function(e){
          if(e.keyCode == 13) {
             $(".ingredientSearch").remove();
             var search = $(this).val();
            var xMark = $("<i>").addClass("fa-solid fa-xmark");
            xMark.click(function(){
               $(this).parent().remove();
            });
            var p = $("<p>")
            var input = $("<input>")
               .attr("readonly", "readonly")
               .attr("name", "recipeIngredientName")
               .val(search);
            p.append(input).append(xMark);
            $(".add-ingredient").append(p);
            $(this).val("");
          }
       });
       
       /* 전체 삭제 클릭 시 등록된 재료 전부 삭제 */
       $(".difficulty-clear").click(function(){
          $("[name=recipeIngredientName]").parent().remove();
       });
       

       
       /* 상태객체 true이면 form 활성화 시킬 예정 */
//         var recipeStatus = {
//             recipeTitleStatus : false,
//             recipeInfoStatus : false, 
//             recipeTimeStatus : false, 
//             recipeHashtagStatus : false
//         };


       
       /* 레시피 등록 우선 비활성화 */
       $(".recipe-insert-form").submit(function(e){
          e.preventDefault();
          
       });


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>