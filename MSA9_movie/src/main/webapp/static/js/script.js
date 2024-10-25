/**
 * 
 */
$(function(){
	console.log("test");
});

function checkForm() {
	// 아이디 패턴 : 영문자, 한글 시작
	let regExpId = /^[a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣]+$/
	
	// 이름 패턴 : 한글
	let regExpName = /^[가-힣]{2,}$/
	
	// 전화번호 패턴 : [3자리 숫자]-[3~4자리 숫자]-[4자리 숫자]
	let regExpPhone = /^\d{3}-\d{3,4}-\d{4}$/
	
	let regExpEmail = /^[0-9a-zA-Z](-_\.)?[0-9a-zA-Z]*@[0-9a-zA-Z](-_\.)?[0-9a-zA-Z]*\.[a-zA-Z]{2,3}$/i          
	
	let id = form.id.value
	let name = form.name.value
	let phone = form.phone1.value + "-" + form.phone2.value + "-" + form.phone3.value
	let email = form.email.value
	
	// 순서대로 유효성 검사
	// test() : 부합O-true, 부합X-false
	if( !regExpId.test(id) ) {
		alert('아이디를 형식에 맞게 입력해주세요')
		return false
	}
	
	if( !regExpName.test(username) ) {
		alert('이름 형식에 맞게 입력해주세요')
		return false
	}
	
	/*if( !regExpPhone.test(phone) ) {
		alert('전화번호 형식에 맞게 입력해주세요')
		return false
	}*/
	
	if( !regExpEmail.test(email) ) {
		alert('이메일 형식에 맞게 입력해주세요')
		return false
	}
	
}








// 1. 아이디 입력창 정보 가져오기
let elInputUsername = document.querySelector('#userid'); // input#userid

// 2.비밀번호 입력창 정보 가져오기
let elInputUserpwd = document.querySelector('#userpwd'); // input#userpwd
let elInputUserpwd2 = document.querySelector('#userpwd2'); // input#userpwd2

// 3. 비밀 번호메시지 정보 가져오기
let elSuccessMessage = document.querySelector('.success-message'); // div.success-message.hide
// 4. 비번 실패 메시지 정보 가져오기 (중복 되었을때)
let elWrongMessage = document.querySelector('.wrong-message'); // div.wrong-message.hide

//아이디 중복 확인
function idMatch(value) {
	return value
}
//아이디 이벤트


// 비밀 번호 확인 일치
function isMatch (userpwd, userpwd2) {
  return userpwd === userpwd2;
}

//비밀번호 이벤트
elInputPasswordRetype.onkeyup = function () {

  // console.log(elInputPasswordRetype.value);
  if (elInputPasswordRetype.value.length !== 0) {
    if(isMatch(elInputUserpwd.value, elInputPasswordRetype.value)) {
      elMismatchMessage.classList.add('hide'); // 실패 메시지가 가려져야 함
    }
    else {
      elMismatchMessage.classList.remove('hide'); // 실패 메시지가 보여야 함
    }
  }
  else {
    elMismatchMessage.classList.add('hide'); // 실패 메시지가 가려져야 함
  }
};



