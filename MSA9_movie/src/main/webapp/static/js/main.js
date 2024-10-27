/**
 * 메인 페이지 script 
 */

/*
	함수 목록 [ Functions ]
*/
let movieIndex = 1;
let keywordIndex = 1;
function getPostList(no,type){
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
	        console.log(result);
	    },
	    error : function(request, status, error) { // 결과 에러 콜백함수
	        console.log(error)
	    }
	})
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