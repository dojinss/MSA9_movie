

$("#userid-check").click(function() {
    let userid = $("#userid").val();
	console.log("아이디 중복 클릭!")
    $.ajax({
        url: "user_pro.jsp?action=checkId", // action 파라미터 추가
        data: {
            "userid": userid
        }, 
        type: 'get',
        dataType: "text",
        success: function(result) {
            if ($.trim(result) == "1") {
				//일치한 아이디 없음(성공)
				console.log("성공!!!")
                $("#idSuccess").text("아이디 사용 가능");
                $("#idFalse").text(""); // 초기화
            } else {
				console.log("실패 ㅠㅠ")
                $("#idFalse").text("이미 사용 중인 아이디입니다.");
                $("#idSuccess").text(""); // 초기화
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 오류: " + error);
        }
    });
});



// 요소 선택
const password = document.querySelector("#userpwd"); 
const passwordRetype = document.querySelector("#userpwd2");
const mismatchMessage = document.querySelector(".mismatch-message");
// const idChk = document.querySelector("#userid-check");

function strongPassword(str) {
    return /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/.test(str);
  }


function checkId() {
  let regExpId = /^[a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣]+$/ // 아이디 패턴
  let regExpName = /^[가-힣]{2,}$/ 			// 이름 패턴
  let regExpEmail = /^[0-9a-zA-Z](-_\.)?[0-9a-zA-Z]*@[0-9a-zA-Z](-_\.)?[0-9a-zA-Z]*\.[a-zA-Z]{2,3}$/; // 이메일 패턴

  
  let id = document.getElementById("userid").value;
  let pwd = document.getElementById("userpwd").value;
  let pwd2 = document.getElementById("userpwd2").value;
  let name = document.getElementById("name").value;
  let email = document.getElementById("mail").value;
  
  

  // 아이디 유효성 검사
  if (!regExpId.test(id)) {
    document.getElementById("wrongId").innerHTML = "아이디를 입력하세요.";
    return false;
  } else {
    document.getElementById("wrongId").innerHTML = "";
  }
 
  
  // 비밀번호 유효성 검사
  if (!strongPassword(pwd)) {
    document.getElementById("pwdError").innerHTML = "비밀번호를 입력하세요.";
    return false;
  } else {
    document.getElementById("pwdError").innerHTML = "";
  }

  // 확인 비밀번호 유효성 검사
  if (!strongPassword(pwd2)) {
    document.getElementById("pwdError2").innerHTML = "비밀번호를 입력하세요.";
    return false;
  } else {
    document.getElementById("pwdError2").innerHTML = "";
  }

  
  // 이름 유효성 검사
  if (!regExpName.test(name)) {
    document.getElementById("nameError").innerHTML = "이름을 입력하세요.";
    return false;
  } 
  else {
    document.getElementById("nameError").innerHTML = "";
  }
  
  
  // 이메일 유효성 검사
  if (!regExpEmail.test(email)) {
	document.getElementById("emailError").innerHTML = "올바른 이메일 주소를 입력하세요.";
	return false;
  } else {
	document.getElementById("emailError").innerHTML = "";
  }
  
  
  return true
}

// 패스워드 일치 확인
passwordRetype.onkeyup = function() {
  if (isMatch(password.value, passwordRetype.value)) {
    mismatchMessage.classList.add("hide")
  } else {
    mismatchMessage.classList.remove("hide");
  }
};

// 패스워드 2개가 같다면 true 반환
function isMatch(password1, password2) {
  return password1 === password2;
}

//
//<b><%=id %>: </b>
//<%
//if(b){   //true일 경우 (중복된 아이디가 있을 경우)
//%>   
//   이미 사용 중인 id 입니다.<br>
//   <a href="#" onclick="opener.document.regForm.id.focus(); window.close();">닫기</a>
//   <%-- opener.document & 두개 한꺼번에 호출 실행 가능 --%>
//<%
//}else{
//%>
//   사용 가능한 id 입니다.<br>
//   <a href="#" onclick="opener.document.regForm.passwd.focus(); window.close();">닫기</a>
//<%
//}
//%>