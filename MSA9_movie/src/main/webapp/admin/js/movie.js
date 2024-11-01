function update(){

    let data = new FormData($("#movie-update")[0]);

    let url = `/movie`
    $.ajax({
        type: "PUT",                       // 요청 메소드
        url: url,                           // 요청 URL
        data: data,         // 요청 데이터
		contentType: false,
		processData: false,                // 응답 데이터 타입
        success: function(result){
			if($.trim(result)  > 0){
				document.location.href = "/admin/movie/adminMovieList.jsp";
			}
			else{
				alert("실패")
			}
        },
        error: function(xhr, status, error){

        }
    })
}


