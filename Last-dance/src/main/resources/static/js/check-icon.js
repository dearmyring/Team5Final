/*
    전체 체크박스는 class="icon-check-all"
    개별 체크박스는 class="icon-check-item"
 */

$(function(){

    $(".icon-check-item").click(function(){
        if(!$(this).hasClass("fa-square-check")){
            $(this).removeClass("fa-regular fa-square")
            $(this).addClass("fa-regular fa-square-check");
        }
        else{
            $(this).removeClass("fa-regular fa-square-check");
            $(this).addClass("fa-regular fa-square");
        }
    
        var checkItemBoxes = $(".icon-check-item");
        var checkItems = 0;
        for(var i=0; i<checkItemBoxes.length; i++){
            if(checkItemBoxes.eq(i).hasClass("fa-square-check")){
                checkItems++;
            }
            if(checkItems == checkItemBoxes.length){
                $(".icon-check-all").removeClass("fa-regular fa-square").addClass("fa-regular fa-square-check");
            }
            else{
                $(".icon-check-all").removeClass("fa-regular fa-square-check").addClass("fa-regular fa-square");
            }
        }
    });
    
    $(".icon-check-all").click(function(){
        if(!$(this).hasClass("fa-square-check")){
            $(this).removeClass("fa-regular fa-square")
            $(this).addClass("fa-regular fa-square-check");
        }
        else{
            $(this).removeClass("fa-regular fa-square-check");
            $(this).addClass("fa-regular fa-square");
        }
    
        var checkItemBoxes = $(".icon-check-item");
        if($(this).hasClass("fa-square-check")){
            for(var i=0; i<checkItemBoxes.length; i++){
                checkItemBoxes.removeClass("fa-regular fa-square").addClass("fa-regular fa-square-check");
            }
        }
        else{
            for(var i=0; i<checkItemBoxes.length; i++){
                checkItemBoxes.removeClass("fa-regular fa-square-check").addClass("fa-regular fa-square");
            }
        }
    });
});