$(function(){
    var swiper = new Swiper('.swiper', {
        // Optional parameters
        direction: 'horizontal', // 슬라이드 방향
        loop: true, // 반복 여부

        //페이징
        pagination: {
            el: '.swiper-pagination', //페이징 적용 대상
            type: "bullets", //페이징 도구 모양
            clickable: true //클릭 가능 여부
        },

        //자동 재생 옵션
        autoplay: {
            delay: 3500,//자동 재생 간격(ms)
        },

        //effect:"slide", //슬라이드 방식(기본)
        //effect:"fade",//페이드인-아웃 효과
        effect:"fade",//카드 전환 효과

        });
});