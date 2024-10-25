$(document).ready(function() {
	/*==============
		영화 게시판
	===============*/
	$('#file').change(function() {
		const fileName = $(this).val().split('\\').pop(); // 파일 이름 추출
		$('#imagename').val(fileName); // 파일 이름 표시
	});
	// 영화목록 페이지
	$('#delconfirm').click(function() {
		const movieNo = $(this).attr("data");
		const confirmation = confirm("정말 삭제하시겠습니까?");
		if (confirmation) {
			window.location.href = 'adminMovieDelete_pro.jsp?movieNo=' + movieNo;
		}
	});
});