function update(){

    let data = new FormData($("#post-update")[0]);

    let url = `/post`
    $.ajax({
        type: "PUT",                       // 요청 메소드
        url: url,                           // 요청 URL
        data: data,         // 요청 데이터
		contentType: false,
		processData: false,                // 응답 데이터 타입
        success: function(result){
			if($.trim(result)  > 0){
				document.location.href = "/admin/post/adminPostList.jsp";
			}
			else{
				alert("실패")
			}
        },
        error: function(xhr, status, error){

        }
    })
}


