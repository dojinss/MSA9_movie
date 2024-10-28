/**
 * 메인 페이지 script 
 */

/*
	함수 목록 [ Functions ]
*/
let movieIndex = 1;
let keywordIndex = 1;
function getPostList(no,type){
	console.log("getPostList 함수 호출...")
	let data;
	switch(type){
		case "movie" : 
			data = 	{  
				"movieNo" 	: no,
				"type" 		: type,
				"nowPage"	: movieIndex
		    }
		break;
		case "keyword" : 
			data = 	{  
				"keywordNo" : no,
				"type" 		: type,
				"nowPage"	: keywordIndex
		    }	
		break;
	}
	
	$.ajax({
	    type : 'get',           // 타입 (get, post, put 등등)
	    url : 'pro/postList_pro.jsp',           // 요청할 서버url
	    async : true,            // 비동기화 여부 (default : true)
	    headers : {              // Http header
	      "Content-Type" : "application/json",
	      "X-HTTP-Method-Override" : "POST"
	    },
	    dataType : 'text',       // 데이터 타입 (html, xml, json, text 등등)
	    data : data,
	    success : function(result) { // 결과 성공 콜백함수
			$("#modal-contents").empty().append(result)
			postFunctions()
			imgDragDrop()
	    },
	    error : function(request, status, error) { // 결과 에러 콜백함수
	        console.log("에러 : " +error)
	    }
	})
}

// 게시글 페이지 함수들
function postFunctions(){
	console.log("postFunctions 함수 호출...")
	// 탭 버튼
	$("input:radio[name='post-tab']").click(function(){
		$(".tab-btn-box > .btn").removeClass("active")
		$(this).parent(".btn").addClass("active")
		let tabViewer = $(".post-container")
		tabViewer.hide();
		tabViewer.eq($("input:radio[name='post-tab']").index(this)).show();
		$("#success-modal").hide();
	})
	$("#success-post").click(function(){
		$(".tab-btn-box > .btn").removeClass("active")
		$(".tab-btn-box > .btn").eq(0).addClass("active")
		let tabViewer = $(".post-container")
		tabViewer.hide();
		tabViewer.eq(0).show();
		$("#success-modal").hide();
	})
	// 이미지 드래그앤드롭
	
	// 게시글 작성하기
//	$("#image").on("change", function() {
//	    if ($("#image")[0].files.length > 2) {
//	        alert("You can select only 2 images");
//	    } else {
//	        $("#imageUploadForm").submit();
//	    }
//	});
	
}

function imgDragDrop(){
	console.log("imgDragDrop 함수 호출...")
	let uploadFiles = [];
	let $drop = $("#drop");
	$drop.on("dragenter", function() {  
		//드래그 요소가 들어왔을떄
		console.log("드래그온")
		$(this).addClass('drag-over');
	}).on("dragleave", function() {  //드래그 요소가 나갔을때  
		console.log("드래그아웃")
		$(this).removeClass('drag-over');
	}).on("dragover", function(e) {  
		e.stopPropagation();
		e.preventDefault();
	}).on('drop', function(e) {  //드래그한 항목을 떨어뜨렸을때  
		console.log("드래그드랍")
		$("#drop > .comment").hide();
		e.preventDefault();  
		$(this).removeClass('drag-over');  
		let files = e.originalEvent.dataTransfer.files;  //드래그&드랍 항목  
		for(let i = 0; i < files.length; i++) {    
			let file = files[i];    
			let size = uploadFiles.push(file);  //업로드 목록에 추가    
			preview(file, size - 1);  //미리보기 만들기  
		}
		
	});
	
	$("#thumbnails").on("click", ".close", function(e) {  
		let $target = $(e.target);  
		let idx = $target.attr('data-idx');  
		uploadFiles[idx].upload = 'disable';  //삭제된 항목은 업로드하지 않기 위해 플래그 생성  
		$target.parent().remove();  //프리뷰 삭제
		let ableCount = 0;   
		$.each(uploadFiles, function(i, file) {
			if(file.upload != 'disable')  //삭제하지 않은 이미지만 업로드 항목으로 추가
				ableCount++
		}); 
		if(ableCount == 0)  
			$("#drop > .comment").show();
	});
	// 게시글 작성하기
	$("#post-form-submit").on("click", function() {  
		let formData = new FormData($("#post-form")[0]);
		console.log("폼 전송중...")
		$.each(uploadFiles, function(i,file) {    
			if(file.upload != 'disable')  //삭제하지 않은 이미지만 업로드 항목으로 추가      
				formData.append('upload-file', file, file.name);  
		});
		$.ajax({    
			url: 'pro/postWrite_pro.jsp',    
			data : formData,    
			type : 'post',
			contentType: false,
			processData: false,
			success : function(result) {
				console.log("전송완료.")
				console.log("전송결과 : " + result)
				if(parseInt( $.trim( result ) ) > 0){
					$("#success-modal").show();
					console.log("완료");
				}else{
					console.log("실패");
				} 
			}  
		});
	});
}
function preview(file, idx) {  
	let reader = new FileReader();  
	reader.onload = (function(f, idx) {    
		return function(e) {      
			let div = '<div class="thumb">'
				+ '<div class="close" data-idx="' + idx + '">X</div>'        
				+	'<img src="' + e.target.result + '" title="' + escape(f.name) + '"/>'      
				+ '</div>';      
			$("#thumbnails").append(div);    
		};  
	})(file, idx);  
	reader.readAsDataURL(file);
}

$(function(){
	// 영화 정보 토글
	$(".info-view-btn").on("click",function(){
		console.log("show!")
		$(this).parents(".movie")
			.find(".right-box")
			.find(".info-box")
			.toggle()			
	});
	
	/**
	 * modal
	 */
	
	// 게시판 목록 열기
	$(".post-view-btn").click(function(){
		let movieNo = $(this).attr("data")
		getPostList(movieNo,"movie")
		$("#modal-wrap").fadeIn()
		$(".modal-container").animate({top:"0px"},function(){
			console.log("modal Show!")
		});
		
	});
	
	// 키워드 목록 열기
	$(".keyword-view-btn").click(function(){
		$("#modal-wrap").fadeIn()
		$(".modal-container").animate({top:"0px"},function(){
			console.log("modal Show!")
		});
	});
	
	// modal close
	$("#close-modal").click(function(){
		console.log("modal Close...")
		$("#modal-wrap").fadeOut();
		$(".modal-container").animate({top:"100%"})
	})
});