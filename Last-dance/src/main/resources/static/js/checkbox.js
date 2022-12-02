$(function(){
    $(window).scroll(function(){
        var height = $(document).scrollTop();
        if($(document).scrollTop() > $("#header").height()) {
        $("#header").addClass("header-fix");
        }
        else {
            $("#header").removeClass("header-fix");
        }
    });
});