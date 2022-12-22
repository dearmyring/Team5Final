<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
    
    .side-banner {
        position: absolute;
        width: 150px;
        min-height: 200px;
        top: 300px;
        right: 100px;
        background-color: #ffffff;
        color: #373A3C;
        box-shadow: 0px 0px 30px 0px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        padding: 15px;
    }

    .a {
        background-color: green;
        width: 1200px;
        height: 5000px;
        margin: auto;
    }

    .banner-item-image {
        width: 100px;
        height: 100px;
        border-radius: 20px;
        object-fit: cover;
    }
    .banner-item {
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 100%;
        height: 121px;
        overflow-x: hidden;
        margin-bottom: 5px;
    }

    .banner-container {
        display: flex;
        flex-direction: column;
        flex-wrap: wrap;
        align-content: center;
    }

    .txt-label {
        overflow-x: hidden;
        width: 100%;
        height: 22px;
        overflow: hidden;
        overflow-y: hidden;
        text-align: center;
    }

    .txt-label::-webkit-scrollbar {
        display: none;
    }


</style>




<div class="side-banner">
    <div class="banner-container">
        <div class="banner-item">
            <img class="banner-item-image" src=""/>
            <span class="txt-label"></span>
        </div>
        <div class="banner-item">
            <img class="banner-item-image" src=""/>
            <span class="txt-label"></span>
        </div>
        <div class="banner-item">
            <img class="banner-item-image" src=""/>
            <span class="txt-label"></span>
        </div>
    </div>
</div>





<!-- jquery 사용 위한 라이브러리 파일 불러옴 -->
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script>
    $(function(){

        // 기본 위치(top)값
        var floatPosition = parseInt($(".side-banner").css('top'))

        // scroll 인식
        $(window).scroll(function() {
        
            // 현재 스크롤 위치
            var currentTop = $(window).scrollTop();
            var bannerTop = currentTop + floatPosition + "px";

            //이동 애니메이션
            $(".side-banner").stop().animate({
            "top" : bannerTop
            }, 900);

        }).scroll();
        
        $.ajax({
            url: "http://localhost:8888/rest/recipe-latelyViewList",
            method: "get",
            dataType: "json",
            success: function(resp) {
                console.log(resp);
                for(var i = 0; i < resp.length; i++) {
                	//console.log($(".banner-item:nth-child("+(i+1)+")").find("span").text());
                	$(".banner-item:nth-child("+(i+1)+")").find("img").attr("src","${pageContext.request.contextPath}/rest/download/"+resp[i].recipeImgList[0].recipeAttachmentNo);
                	$(".banner-item:nth-child("+(i+1)+")").find("span").text(resp[i].recipeDto.recipeTitle);
                }//for end
                
            }
        });//ajax end

    });


</script>