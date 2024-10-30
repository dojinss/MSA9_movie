
// 아이디 중복 조회
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
    });
});

//---------------------------------------아이디 유효성 검사----------------------------------------------------

// 요소 선택
const password = document.querySelector("#userpwd"); 
const passwordRetype = document.querySelector("#userpwd2");
const mismatchMessage = document.querySelector(".mismatch-message");


function strongPassword(str) {
    return /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/.test(str);
  }

function checkId() {
  let regExpId = /^[0-9a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣]+$/ // 아이디 패턴
  let regExpEmail = /^[0-9a-zA-Z](-_\.)?[0-9a-zA-Z]*@[0-9a-zA-Z](-_\.)?[0-9a-zA-Z]*\.[a-zA-Z]{2,3}$/; // 이메일 패턴

  
  let id = document.getElementById("userid").value;
  let pwd = document.getElementById("userpwd").value;
  let pwd2 = document.getElementById("userpwd2").value;
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

//---------------------------------------------회원 정보 수정--------------------------------------------------

function confirminfoup() {
    const confirmed = confirm("수정하시겠습니까?");
    if (confirmed) {
        const userId = document.getElementById("userid");
        const userPwd = document.getElementById("userpwd");
        const email = document.getElementById("mail");
        const profileUrl = document.getElementById("profile");

        $.ajax({
            url: "infoUpdate_pro.jsp",
            type: "post",
            data: {
                "id": userId.value,
                "userpwd": userPwd.value,
                "email": email.value,
                "profileUrl": profileUrl.value
            },
            dataType: "text",
            success: function(result) {
                console.log("서버 응답:", result.trim());
                if (result.trim() > 0) {
                    alert("수정이 완료되었습니다.");
                    window.location.href = "index.jsp";
                } else {
                    alert(result.trim()); // 서버의 응답 메시지를 표시
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
    } else {
        alert("수정이 취소되었습니다.");
    }
    return false; // 폼 제출 방지
}

//----------------------------------------------회원 탈퇴----------------------------------------------------

// 탈퇴
function confirmLeave() {
    const confirmed = confirm("탈퇴하시겠습니까?");
    if (confirmed) {
        const userId = document.getElementById("userid").value;
        const userPwd = document.getElementById("userpwd").value;
 
        $.ajax({
            url : "leave_pro.jsp",
            type : "post",
            data : {
                "id" : userId,
                "userpwd" : userPwd
            },
            dataType : "text",
            success : function(result) {
                console.log("서버 응답:", result.trim()); // 응답을 로그에 출력
                if (result.trim() === "탈퇴가 완료되었습니다.") {
                    alert("탈퇴가 완료되었습니다.");
                    window.location.href = "index.jsp";
                } else if (result.trim() === "아이디 또는 비밀번호가 일치하지 않습니다.") {
                    alert("아이디 또는 비밀번호가 일치하지 않습니다.");
                } else {
                    alert("탈퇴 실패. 다시 시도해주세요.");
                }
            },
            error: function() {
                alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
    } else {
        alert("탈퇴가 취소되었습니다.");
    }
    return false; // 제출 방지
}	
			