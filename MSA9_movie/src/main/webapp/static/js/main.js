/**
 * 메인 페이지 script 
 */

/*
	함수 목록 [ Functions ]
*/
let movieIndex = 1;
let keywordIndex = 1;
// 게시글 목록 불러오기
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
			let tabViewer = $(".post-container")
			tabViewer.hide();
			tabViewer.eq(0).show();
	    },
	    error : function(request, status, error) { // 결과 에러 콜백함수
	        console.log("에러 : " +error)
	    }
	})
}
// 키워드 목록 불러오기
function getKeywordList(movieNo){
	console.log("getKeywordList 함수 호출...")
	let data = 	{  
		"movieNo" 	: movieNo,
		"nowPage"	: keywordIndex
    }
	$.ajax({
	    type : 'get',
	    url : 'pro/keywordList_pro.jsp',
	    dataType : 'text',
	    data : data,
	    success : function(result) {
			console.log("키워드 목록 조회 성공.")
			$("#modal-contents").empty().append(result)
			keywordFunctions()
	    }
	})
	
}
// 키워드 목록페이지 함수들
function keywordFunctions(){
	$(".keyword-item").click(function(){
		let keywordNo = $(this).attr("data")
		let type = "keyword"
		getPostList(keywordNo,type)
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
	
	// 등록완료 버튼 클릭 - 페이지 새로고침
	$("#success-post").click(function(){
		postList();
	})
}
// 뷰페이지 함수들
function viewFunctions(){
	// 삭제하기
	$("#delete-post-btn").click(function(){
		let deleteConfirm = confirm("삭제 하시겠습니까?")
		let postNo = $(this).attr("data")
		if(deleteConfirm){
			console.log("삭제 요청...")
			$.ajax({
				url : "pro/postDelete_pro.jsp",
				data : {
					postNo : postNo
				},
				type : "post",
				dataType : "text",
				success : function(result){
					let check = $.trim(result)
					if(check){
						console.log("삭제완료.")
						postList();
					}
					else{
						console.log("삭제실패.")
					}
				}
			})
		}
	})
	// 수정하기
	$("#update-post-btn").click(function(){
		console.log("수정 요청...")
		
		let postNo = $(this).attr("data")
		let content = 
		
		// 수정탭으로 변경
		$(".tab-btn-box > .btn").removeClass("active")
		$(".tab-btn-box > .btn").eq(1).addClass("active")
		let tabViewer = $(".post-container")
		tabViewer.hide();
		tabViewer.eq(1).show();
		$("#success-modal").hide();
		$("#write-mode").val("update")
		$("#post-form").find("input[name=postNo]").val(postNo)
		$("#post-form").find("textarea[name=content]").val(postNo)
	})
}

// 이미지 드래그앤드롭
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
	
	// 썸네일 삭제
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
		let mode = $("#write-mode").val()
		console.log("폼 전송중...")
		$.each(uploadFiles, function(i,file) {    
			if(file.upload != 'disable')  //삭제하지 않은 이미지만 업로드 항목으로 추가      
				formData.append('upload-file', file, file.name);  
		});
		writePost(formData, mode)
	});
	
	// 게시글 조회
	$(".post-item").on("click", function() {  
		let postNo = $(this).attr("data")
		console.log("게시글 조회...")
		postView(postNo)
	});
	
}
// 게시글 작성 함수
function writePost(formData, mode){
	formData.append("mode",mode)
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
}

// 게시글 페이지 새로고침 (비동기)
function postList(){
	let type = $("#postType").val()
	let no
	if(type == "movie")
		no = $("#movieNo").val()
	else if(type == "keyword")
		no = $("#keywordNo").val()
	getPostList(no,type);
}
// 게시글 조회 (비동기)
function postView(postNo){
	$.ajax({    
		url: 'pro/postView_pro.jsp',    
		data : {
			postNo : postNo
		},    
		type : 'post',
		success : function(result) {
			console.log("전송완료.")
			$("#post-view-tab").empty().append(result)
			$(".tab-btn-box > .btn").removeClass("active")
			$(".tab-btn-box > .btn").eq(0).addClass("active")
			let tabViewer = $(".post-container")
			tabViewer.hide();
			tabViewer.eq(2).show();
			$("#success-modal").hide();
			viewFunctions()
		}  
	});
}

// 썸네일 미리보기
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
		let movieNo = $(this).attr("data")
		getKeywordList(movieNo)
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