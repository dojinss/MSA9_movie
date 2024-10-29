$(document).ready(function() {
	/*==============
		파일 변경
	===============*/
	$('#file').change(function() {
		const fileName = $(this).val().split('\\').pop(); // 파일 이름 추출
		$('#imagename').val(fileName); // 파일 이름 표시
	});
	// 삭제 알림창
	$('#delconfirm').click(function() {
		const no = $(this).attr("data");
		const path = $(this).attr("path");
		const confirmation = confirm("정말 삭제하시겠습니까?");
		if (confirmation) {
			window.location.href = path + no;
		}
	});
});