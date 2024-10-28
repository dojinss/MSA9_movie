<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Netstar - 영화 커뮤니티</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
	<%-- CSS 링크 파일 --%>
	<link rel="stylesheet" href="static/css/user.css">
	
</head>
<body>
	<jsp:include page="/layout/header.jsp" />
	<%-- [Contents] ######################################################### --%>
		
	<div class="user-category">
  		<input id="tab-1" type="radio" name="tab" class="edit-in tab-radio" checked>
  		<label for="tab-1" class="tab">회원 정보 수정</label>
  		<input id="tab-2" type="radio" name="tab" class="user-out tab-radio" OnClick="location.href='leave.jsp';">
  		<label for="tab-2" class="tab">회원 탈퇴</label>
		</div>


<form class="user-info" onsubmit="return checkId()">
  <div class="info-update">
  <label for="tab" id="tab">회원 정보 수정</label>
  

    <div class="user-edit">

      <div class="sign-edit">
        <div class="group">
          <label for="userid" class="label">아이디</label>
          <input id="userid"  type="text" class="input" name="id" autofocus >
          <button type="button" id="userid-check">중복확인</button>
          <!-- 유효성 검사 후 잘,잘못되었을때 경고문 -->      
           <div id="wrongId"></div>
        </div>
        
        <div class="group">
          <label for="userpwd" class="label">비밀번호</label>
          <input id="userpwd" type="password" class="input" >
          <div id="pwdError"></div>
        </div>
        
        <div class="group">
          <label for="userpwd2" class="label">비밀번호 확인</label>
          <input id="userpwd2" type="password" class="input" >
          <!-- <button id="userpwd2-check" onclick="pwdcheck()">확인</button> -->
          <!--작성 안했을때 경고문  -->
          <div id="pwdError2"></div>
          <!-- 유효성 검사 후 잘못되었을때 경고문 -->
          <div class="mismatch-message hide">비밀번호가 일치하지 않습니다</div>
        </div>
		
      <div class="user-edit">
        <div class="group">
          <label for="name" class="label">이름</label>
          <input id="name" type="text" class="input">
           <!-- 오류 메세지 -->
	      <div id="nameError"></div>s
        </div>

        <div class="group">
          <label for="userbirth" class="label">생년월일</label>
          <input id="userbirth" type="date" class="input" data-type="">
        </div>
        <div class="group">
          <label for="mail" class="label">이메일</label>
          <input id="mail" type="email" class="input" name="email"  placeholder="'@' 포함하여 입력해 주세요">
          <!-- 오류 메세지 -->
	      <div id="emailError"></div>
        </div>

        <div class="group">
          <label for="profile" class="label">프로필 이미지</label>
        </div>
        <div id="preview-box">
        	<img id="preview" src="" width="100" height="100" />
        </div>
        <input id="profile" type="file" class="input" >

      </div>
      </div>
        <div id="edit">
          <button type="submit" class="edit-btn" >수정하기</button>
        </div>
      </div> 
    </div>
  </form>


	
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	<%-- JS 링크 파일 --%>
	<script src="static/js/user.js"></script>
	<script>
		document.getElementById('profile').addEventListener('change', function(event) {
            const input = event.target;
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('preview').src = e.target.result;
                };
                reader.readAsDataURL(input.files[0]);
            } else {
                document.getElementById('preview').src = "";
            }
        });
		
		/* 마우스 올렸을때 이벤트 */
		 $('button').on('mouseover', function() {
	       $(this).css('color', 'white')
	       $(this).css('background-color', '#0c0f3d87')
			})
		 .on('mouseout', function() {    
	        $(this).css('color', 'white')
	        $(this).css('background-color', 'var(--main-color)')
	    })
		 $('.edit-btn').on('mouseover', function() {
	       $(this).css('color', 'white')
	       $(this).css('background-color', '#cba50fad')
			})
		 .on('mouseout', function() {    
	        $(this).css('color', 'white')
	        $(this).css('background-color', 'var(--sub-color)')
	    })
		
	</script>
</body>
</html>