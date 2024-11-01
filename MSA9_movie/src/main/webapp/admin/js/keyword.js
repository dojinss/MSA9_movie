function update(){

    let data = new FormData($("#keyword-update")[0]);

    let url = `/keyword`
    $.ajax({
        type: "PUT",                       // 요청 메소드
        url: url,                           // 요청 URL
        data: data,         // 요청 데이터
		contentType: false,
		processData: false,                // 응답 데이터 타입
        success: function(result){
			document.location.href = "/admin/keyword/adminKeywordList.jsp?movieNo="+result;
        },
        error: function(xhr, status, error){

        }
    })
}


