$(function(){
	/* 제목 블러 시 기존 제목 확인 */
	$("[name=recipeTitle]").blur(function(){
		var data = {recipeTitle : $(this).val()};
		var param = $.param(data);
		var that = $(this);
		$.ajax({
			url: root+"/rest/recipe_find?"+param,
			method: "get",
			success: function(resp){
				if(resp){
					that.addClass("is-invalid");
				}
			}
		});
	});
	
	$("[name=recipeTitle]").on("input", function(){
		$(this).removeClass("is-invalid");
	});
	
	/* 미리보기 클릭 시 파일 추가 */
	$(".preview").click(function(){
		if(!$(this).hasClass("preview-disabled")){
    		$(this).prev().click();
		}
	});
	
	/* 재료 등록 후 바로 추가 안내 */
	$(".ingredient-insert-btn").click(function(e){
		if(confirm("재료를 등록하시겠습니까?")){
			var ingredientName = $(this).parent().prev().find(".insert-ingredientName").val();
			var ingredientCategory = $(this).parent().prev().find(".insert-ingredientCategory").val();
			var ingredinetList = [{
				ingredientName : ingredientName,
				ingredientCategory : ingredientCategory
			}];
			$.ajax({
				url: root+"/rest/ingredient",
				method: "post",
				contentType: "application/json",
				data: JSON.stringify(ingredinetList),
				success: function(resp){
//					if(confirm("레시피에 바로 추가하시겠습니까?")){
						var xMark = $("<i>").addClass("fa-solid fa-xmark");
						xMark.click(function(){
							$(this).parent().remove();
						});
						var p = $("<p>")
						var input = $("<input>")
							.attr("readonly", "readonly")
							.attr("name", "recipeIngredientName")
							.val(ingredientName);
						p.append(input).append(xMark);
						$(".add-ingredient").append(p);
//					}
					$(".input-ingredient").val("");
					$(".insert-ingredientCategory").val("");
                    $(".ingredient-insert-modal").modal("hide");
				}
			});
		}
		$(".input-ingredient").focus();
	});
	
	/* 재료 등록 취소 */
	$(".ingredient-insert-cancel").click(function(e){
		if(!confirm("재료 등록을 취소하시겠습니까?")){
    		e.preventDefault();
		}
	});
	
	/* 썸네일 사진 모두 지우기 클릭 시 비동기 삭제 & 미리보기 사진 변경 */
	$(".thumb-all-clear").click(function(){
		if(confirm("모두 삭제하시겠습니까?")){
    		var param = $(".thumb-page .img-no").serialize();
    		$.ajax({
    			url: root+"/rest/attachment/delete?"+param,
    			method: "delete",
    			success: function(resp){
    				$(".thumb-page").find(".file-input").val("");
		    		$(".thumb-page").find(".preview").attr("src", "${pageContext.request.contextPath}/images/img_plus.png").addClass("preview-disabled");
		    		$(".thumb-page").find(".img-no").remove();
		    		$(".thumb-page").find(".preview").first().removeClass("preview-disabled");
    			}
    		});
		}
	});
	
	/* 엔터 시 폼 전송 방지 */
	$(".recipe-insert-form").keydown(function(e){
		if(e.keyCode === 13){
    		e.preventDefault();
		}
	});
	
	/* 등록하기 버튼 클릭 시 모든 칸 검사 후 제출 */
	$(".recipe-insert-form").submit(function(e){
   		var recipeTitle = $("[name=recipeTitle]");
   		if(!recipeTitle.val() || recipeTitle.hasClass("is-invalid")){
   			alert("레시피 제목을 등록해주세요.");
   			recipeTitle.focus();
   			$("html, body").animate({scrollTop: recipeTitle.offset().top-100},400);
   			return false;
   		}
   		
   		var recipeInfo = $("[name=recipeInfo]");
   		if(!recipeInfo.val()){
   			alert("레시피 소개를 등록해주세요.");
   			recipeInfo.focus();
   			$("html, body").animate({scrollTop: recipeInfo.offset().top-100},400);
   			return false;
   		}

   		var recipeTime = $("[name=recipeTime]");
   		if(!recipeTime.val()){
   			alert("레시피 소요시간을 선택해주세요.");
   			recipeTime.focus();
   			return false;
   		}
   		
   		var recipeDifficulty = $("[name=recipeDifficulty]");
   		if(!recipeDifficulty.val()){
   			alert("레시피 난이도를 선택해주세요.");
   			recipeDifficulty.focus();
   			return false;
   		}

   		var recipeIngredient = $("[name=recipeIngredientName]");
   		if(!recipeIngredient.val()){
   			alert("레시피 재료를 선택해주세요.");
   			$(".input-ingredient").focus();
   			$("html, body").animate({scrollTop: $(".input-ingredient").offset().top-100},400);
   			return false;
   		}
   		
		var contentText = $("[name=recipeContentText]");
		var contentImg = $(".content-page").find(".preview");
		//레시피 컨텐트 아예 없을 때 리턴
		var contentCnt = 0;
		var contentImgCnt = 0;
		for(var i=0; i<contentText.length; i++){
			if(contentText.eq(i).text()){
				contentCnt++;
			}
			if(!contentImg.eq(i).attr("src").includes("img_plus.png")){
				contentImgCnt++;
			}
			if(contentCnt != contentImgCnt){
			    alert("레시피 내용 작성을 완료해주세요.");
			    return false;
			}
		}
		//레시피 컨텐트 아예 아무 것도 없을 때
		if(contentCnt == 0 && contentImgCnt == 0){
			alert("레시피 내용을 등록해주세요.");
			contentText.first().focus();
   			$("html, body").animate({scrollTop: contentText.first().offset().top-100},400);
			return false;
		}

       //레시피 썸네일 아예 없을 때 리턴
		var recipeImg = $(".thumb-page").find(".preview");
		var recipeImgCnt = 0;
		for(var i=0; i<recipeImg.length; i++){
			if(!recipeImg.eq(i).attr("src").includes("img_plus.png")){
				recipeImgCnt++;	
			}
		}
		//레시피 썸네일 아예 없을 때
		if(recipeImgCnt == 0){
			alert("레시피 썸네일을 지정해주세요.");
   			$("html, body").animate({scrollTop: recipeImg.first().offset().top-100},400);
			return false;
		}
   		
   		var recipeHashtag = $("[name=recipeHashtag]");
   		if(!recipeHashtag.val()){
   			alert("레시피 해시태그를 선택해주세요.");
   			recipeHashtag.focus();
   			return false;
   		}
   		
   		var choice = confirm("등록하시겠습니까?");
   		if(!choice){
    		e.preventDefault();
   		}
   		else{
			//레시피 내용 작성 돼 있으면 그 다음 칸부터는 삭제
            for(var i=contentCnt; i<contentText.length; i++){
                contentText.eq(i).parents(".content-page").remove();
            }
			//레시피 썸네일 없는 칸부터 빈칸 삭제
			for(var i=0; i<recipeImg.length; i++){
				if(recipeImg.eq(i).attr("src").includes("img_plus.png")){
					recipeImg.eq(i).remove();
				}
			}
   		}
	});

	/* 레시피 돌아가기 클릭 시 비동기로 첨부파일 삭제 */
	$(".recipe-return-btn").click(function(e){
		var param = $(".recipe-insert-form .img-no").serialize();
		$.ajax({
			url: root+"/rest/attachment/delete?"+param,
			method: "delete",
			success: function(resp){
				history.back();
			}
		});
	});
	
	/* 레시피 내용 블러 시 textarea 안에 값 넣어주기 */
	$("[name=recipeContentText]").blur(function(){
		$(this).text($(this).val());
	});
	
	/* 재료 입력 비동기 불러오기 */
	$(".input-ingredient").on("input", function(){
        setTimeout(() => {
            var keyword = $(this).val();
            if(keyword == ""){
                $(".ingredientSearch").remove();
            }
            else{
            	var param = new String();
            	param.type = "ingredient_name";
            	param.keyword = keyword;
            	var search = $.param(param);
                $.ajax({
                    url: root+"/rest/ingredient?"+search,
                    method: "get",
                    success: function(resp){
                        $(".ingredientSearch").remove();
                        for(var i=0; i<resp.length; i++){
                            var pTag = $("<p>")
                                .addClass("ingredientSearch")
                                .text(resp[i].ingredientName);
                            
                            pTag.click(function(){
                            	var addIngredientCnt = $(".add-ingredient").find("[name=recipeIngredientName]");
                            	for(var i=0; i<addIngredientCnt.length; i++){
                                	if($(this).text() == addIngredientCnt.eq(i).val()){
                                		alert("이미 등록된 재료입니다.");
                                		$(".ingredientSearch").remove();
                                		$(".input-ingredient").val("");
                                		return;
                                	}
                            	}
                            		
                                var xMark = $("<i>").addClass("fa-solid fa-xmark");
                                xMark.click(function(){
                                    $(this).parent().remove();
                                });
                                
                                var p = $("<p>")
                   				var input = $("<input>")
									.attr("readonly", true)
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

	/* 재료 엔터 등록 없을 시 등록 모달 구현 예정 */
	$(".input-ingredient").keydown(function(e){
		if(e.keyCode == 13) {
    		$(".ingredientSearch").remove();
			var keyword = $(this).val();
			$.ajax({
                url: root+"/rest/ingredient/"+keyword,
                method: "get",
                success: function(resp){
                	if(!resp){
                		if(confirm("등록되지 않은 재료입니다. 해당 재료를 등록하시겠습니까?")){
                			$(".insert-ingredientName").val(keyword);
                            var modal = new bootstrap.Modal($(".ingredient-insert-modal"), {});
                            modal.show();
                		}
                	}
                	else{
                    	var addIngredientCnt = $(".add-ingredient").find("[name=recipeIngredientName]");
                    	for(var i=0; i<addIngredientCnt.length; i++){
                        	if(keyword == addIngredientCnt.eq(i).val()){
                        		alert("이미 등록된 재료입니다.");
                        		$(".ingredientSearch").remove();
                        		$(".input-ingredient").val("");
                        		return;
                        	}
                    	}
                    	
						var xMark = $("<i>").addClass("fa-solid fa-xmark");
						xMark.click(function(){
							$(this).parent().remove();
						});
						var p = $("<p>")
						var input = $("<input>")
							.attr("readonly", "readonly")
							.attr("name", "recipeIngredientName")
							.val(keyword);
						p.append(input).append(xMark);
						$(".add-ingredient").append(p);
						$(".input-ingredient").val("");
                	}
                }
			});
		}
	});
	
	/* 전체 삭제 클릭 시 등록된 재료 전부 삭제 */
	$(".ingredient-all-clear").click(function(){
		$("[name=recipeIngredientName]").parent().remove();
	});
	
	/* 순서 추가 버튼 클릭 시 다음 단계 등록 영역 생성 */
	$(".step-plus-btn").last().remove();
	$(".step-minus-btn").first().remove();
	$(".content-page").hide();
	$(".content-page").first().show();

	$(".step-plus-btn").click(function(){
		var contentText = $(this).parents(".content-page").find("[name=recipeContentText]").val();
		var contentImg = $(this).parents(".content-page").find(".preview").attr("src").includes("img_plus.png");
		if(!contentText || contentImg){
			alert("레시피 내용은 순서대로 등록해주세요.");
			return;
		}
		$(this).hide();
		$(this).next().hide();
		$(this).parents(".content-page").next().show();
	});
	$(".step-minus-btn").click(function(){
		var that = $(this);
		var contentText = $(this).parents(".content-page").find("[name=recipeContentText]");
		var contentImg = $(this).parents(".content-page").find(".preview");
		if(!contentText.val() && contentImg.attr("src").includes("img_plus.png")){
			$(this).parents(".content-page").prev().find(".step-plus-btn").show();
			$(this).parents(".content-page").prev().find(".step-minus-btn").show();
			$(this).parents(".content-page").hide();
			return;
		}
		if(contentText.val() || !contentImg.attr("src").includes("img_plus.png")){
			var choice = confirm("작성한 내용은 저장되지 않습니다. 삭제하시겠습니까?");
			if(!choice){
				return;
			}
			else{
	    		var recipeContentAttachmentNo = $(this).parents(".content-page").find(".img-no").val();
				var attachmentNo = {recipeContentAttachmentNo : recipeContentAttachmentNo};
				var param = $.param(attachmentNo);
			}
		}
		$.ajax({
			url: root+"/rest/attachment/delete?"+param,
			method: "delete",
			success: function(resp){
				contentText.val("");
				contentImg.attr("src", "${pageContext.request.contextPath}/images/img_plus.png");
				that.parents(".content-page").find(".img-no").remove();
				that.parents(".content-page").find(".file-input").val("");
				that.parents(".content-page").prev().find(".step-plus-btn").show();
				that.parents(".content-page").prev().find(".step-minus-btn").show();
				that.parents(".content-page").hide();
			}
		});
	});

	/* 이미지 업로드 비동기 후 미리보기 구현 */
    $(".file-input").change(function(){
    	var that = $(this);
        if(this.files.length > 0){
            var fd = new FormData();
            fd.append("attach", this.files[0]);
            $.ajax({
                url: root+"/rest/upload",
                method: "post",
                data: fd,
                processData: false,
                contentType: false,
                success: function(resp){
                	that.next().attr("src", resp);
                	var attachmentNo = parseInt((resp.split("download/"))[1]);
                	if(that.parent().hasClass("thumb-page")){
                    	var imgNo = $("<input>").attr("type", "hidden").addClass("img-no").attr("name", "recipeAttachmentNo").val(attachmentNo);
						that.parent().find(".preview-disabled").first().removeClass("preview-disabled");
                	}
                	if(that.parents(".content-page").hasClass("content-page")){
                    	var imgNo = $("<input>").attr("type", "hidden").addClass("img-no").attr("name", "recipeContentAttachmentNo").val(attachmentNo);
                	}
                	if(that.prev().hasClass("img-no")){
                		that.prev().val(attachmentNo);
                	}
                	else{
						that.before(imgNo);
                	}
                }
            });
        }
        else{
            that.next().attr("src", "${pageContext.request.contextPath}/images/img_plus.png");
			that.prev().remove();
        }
    });
});