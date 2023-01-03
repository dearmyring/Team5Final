/**
    전체 체크박스는 class="check-all"
    개별 체크박스는 class="check-item"
 */

window.addEventListener("load", function(){
    // [1] 전체선택을 체크하면 개별항목을 변경
    var checkAll = document.querySelectorAll(".check-all");
    
    for(var i=0; i<checkAll.length; i++){
        // addEventListener("input", 함수)-> input이 발생했을 때 함수를 발생시킨다.
        // 따라서 밖에 선언된 변수말고 이벤트가 실행된 this를 사용한다.
        checkAll[i].addEventListener("input", function(e){
            // this = 체크된 전체선택 체크박스 == e.target
            var checkItems = document.querySelectorAll(".check-item");
            var checkAll = document.querySelectorAll(".check-all");
            for(var i=0; i<checkItems.length; i++){
                checkItems[i].checked = this.checked;
            }
            for(var i=0; i<checkAll.length; i++){
                checkAll[i].checked = this.checked;
            }
        });
    }
        
    // [2] 개별항목을 체크하면 전체선택을 변경
    var items = document.querySelectorAll(".check-item");
    for(var i=0; i<items.length; i++){
        items[i].addEventListener("input", function(e){
            // this = 체크된 아이템 체크 박스 == e.target
            var checkedItems = document.querySelectorAll(".check-item:checked").length;
            var checkboxes = document.querySelectorAll(".check-item").length;
            var judge = checkedItems == checkboxes;
            
            var checkAll = document.querySelectorAll(".check-all");
            for(var i=0; i<checkAll.length; i++){
                checkAll[i].checked = judge;
            }
        });
    }
});