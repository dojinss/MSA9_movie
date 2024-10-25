/**
 * 
 */
$(function(){
	console.log("test");
});

function checkId() {
	// 아이디 패턴 : 영문자, 한글 시작
	let regExpId = /^[a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣]+$/
	
	// 이름 패턴 : 한글
	let regExpName = /^[가-힣]{2,}$/
	
	let regExpEmail = /^[0-9a-zA-Z](-_\.)?[0-9a-zA-Z]*@[0-9a-zA-Z](-_\.)?[0-9a-zA-Z]*\.[a-zA-Z]{2,3}$/i          
	
	function strongPassword (str) {
	  return /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/.test(str);
	}
	
	let id = document.getElementById("userid").value;
	let pwd = document.getElementById("userpwd").value;
	let pwd2 = document.getElementById("userpwd2").value;
	let name = document.getElementById("name").value;
	let email = document.getElementById("mail").value;
	

	// 순서대로 유효성 검사
	// test() : 부합O-true, 부합X-false

	
	if( !regExpId.test(id) ) {
		document.getElementById("wrongId").innerHTML = "아이디를 입력하세요.";
		return false;
	} else {
		 document.getElementById("wrongId").innerHTML = "";
	 }
	 
	 if( !regExpId.test(pwd) ) {
	 		document.getElementById("pwdError").innerHTML = "비밀번호를 입력하세요.";
	 		return false;
	 	} else {
	 		 document.getElementById("pwdError").innerHTML = "";
	 	 }
		 
	if( !regExpId.test(pwd2) ) {
		 	 document.getElementById("pwdError2").innerHTML = "비밀번호를 입력하세요.";
		 	 return false;
		 } else {
		 	 document.getElementById("pwdError2").innerHTML = "";
		 }
	 	 
	 
		
	if( !regExpName.test(name) ) {
		document.getElementById("nameError").innerHTML = "이름을 입력하세요.";
		return false;
	} else {
		 document.getElementById("nameError").innerHTML = "";
	 }
				
	
	if( !regExpEmail.test(email) ) {
		document.getElementById("emailError").innerHTML = "올바른 이메일 주소를 입력하세요.";
		    return false;
		  } else {
		    document.getElementById("emailError").innerHTML = "";
		  }

 }

// 비밀 번호 확인
function isMatch (userpwd, userpwd2) {
  return userpwd === userpwd2;
}

//비번 확인 이벤트
elInputPassword.onkeyup = function () {
	
	let elInputPassword = document.getElementById("userpwd");
	let elStrongPasswordMessage = document.querySelector(".mismatch-message");


  // console.log(elInputPassword.value);
  // 값을 입력한 경우
  if (elInputPassword.value.length !== 0) {
    if(strongPassword(elInputPassword.value)) {
      elStrongPasswordMessage.classList.add('hide'); // 실패 메시지가 가려져야 함
    }
    else {
      elStrongPasswordMessage.classList.remove('hide'); // 실패 메시지가 보여야 함
    }
  }
  // 값을 입력하지 않은 경우 (지웠을 때)
  // 모든 메시지를 가린다.
  else {
    elStrongPasswordMessage.classList.add('hide');
  }
}



