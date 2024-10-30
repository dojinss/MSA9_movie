
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
			dataType: "text",
			   success: function(result) {
			   	   console.log(result);
			       if (result.trim() === "탈퇴가 완료되었습니다.") {
			           alert("탈퇴가 완료되었습니다.");
			           window.location.href = "index.jsp"; // 성공
			       } else if (result.trim() === "탈퇴 실패하였습니다.") {
			           alert("탈퇴 실패하였습니다. 다시 시도해주세요.");
					   window.location.href = "leave.jsp";
			       } else {
			           alert("아이디 또는 비밀번호가 일치하지 않습니다."); // 로그인 실패
					   window.location.href = "leave.jsp";
			       }
			  },
			  //xhr,포함?
			  error: function( status, error) {
			    console.error("AJAX 호출 실패:", status, error); // AJAX 호출 실패 처리
			    alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
			 }
		});
	} else {
		alert("탈퇴가 취소되었습니다.");
	}
	return false; //제출끝
}
			
			
			
			
			
			
			
			
			
//			dataType : "text",
//			success : function(result){
//				console.log(result)
//			}
//		})
//         //AJAX 요청
//        const xhr = new XMLHttpRequest();
//        xhr.open("POST", "leave_pro.jsp", true);
//        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
//
//        xhr.onreadystatechange = function () {
//            if (xhr.readyState === 4 && xhr.status === 200) {
//                const response = xhr.responseText;
//				console.log(response)
//                if (response === "success") {
//                    alert("탈퇴가 완료되었습니다.");
//                    window.location.href = "index.jsp"; // 성공 후 페이지 이동
//                } else {
//                    alert("아이디와 비밀번호가 일치하지 않습니다. 다시 시도해주세요.");
//                }
//            }
//        };
//
//        // 아이디와 비밀번호를 전송
//        xhr.send("id=" + encodeURIComponent(userId) + "&userpwd=" + encodeURIComponent(userPwd));
//    } else {
//        alert("탈퇴가 취소되었습니다.");
//    }
//	return false; //  제출 방지
//}
