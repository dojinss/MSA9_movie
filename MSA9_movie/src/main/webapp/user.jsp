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
		
		
							<!--★★submitForm 보이면 삭제/검색해도안나와 ㅜㅡ★★  -->
<form class="user-login" method="post" action="user_pro.jsp" onsubmit="return checkId()">
  <div class="login-box">
  <label for="tab" id="tab">회원 가입</label>
  

    <div class="login-info">

      <div class="sign">
        <div class="group" >
          <label for="userid" class="label">아이디</label>
          <input id="userid"  type="text" class="input" name="id" autofocus>
          <button type="button" id="userid-check">중복확인</button>
           <!-- 입력창 오류 경고문 -->      
           <div id="wrongId"></div>
           <div id="idSuccess"></div>
           <div id="idFalse"></div>
           
        </div>

        <div class="group">
          <label for="userpwd" class="label">비밀번호</label>
          <input id="userpwd" type="password" class="input" name="userpwd">
          <div id="pwdError"></div>        
        </div>
        
        <div class="group">
          <!--  수정 -->
			<label for="userpwd2" class="label">비밀번호 확인</label>
			<input id="userpwd2" type="password" class="input" name="userpwd2" >
			<!-- 오류 메세지 -->
			<div id="pwdError2"></div>
			 <!-- 유효성 검사 후 잘못되었을때 경고문 -->
			<div class="mismatch-message hide">비밀번호가 일치하지 않습니다</div>

        </div>

      <div class="user-edit">
        <div class="group">
          <label for="mail" class="label">이메일</label>
          <input id="mail" type="email" class="input" name="email"  placeholder="'@' 포함하여 입력해 주세요">
          <!-- 오류 메세지 -->
	      <div id="emailError"></div>
        </div>

        <div class="group">
          <label for="profile" class="label">프로필 이미지</label>
        </div>
        <div class="preview">
	        <div id="preview-box">
	        	<p class="comment">프로필 이미지를 업로드 해주세요.</p>
	        	<img id="preview" src="" width="100" height="100" />
	        </div>
	        <input id="profile" type="file" class="input" name="profile">
        </div>
      </div>
      </div>
        <div id="edit">
          <button type="submit" class="edit-btn" >가입하기</button>
        </div>
      </div> 
    </div>
  </form>
     
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	<%-- JS 링크 파일 --%>
	<script src="<%=root %>/static/js/user.js"></script>
	<script>
	
	// 프로필 사진 등록 시 텍스트 숨기기 이벤트
	document.getElementById('profile').addEventListener('change', function(event) {
	    const input = event.target;
	    if (input.files && input.files[0]) {
	        const reader = new FileReader();
	        reader.onload = function(e) {
	            document.getElementById('preview').src = e.target.result;
	        };
	        reader.readAsDataURL(input.files[0]);
	        
	        // 파일이 있을때 텍스트 보이기
	        document.getElementById('preview').style.display = 'block';
	        document.querySelector('.comment').style.display = 'none';
	    } else {
	        //파일이 없을때 이미지 보이기
	        document.querySelector('.comment').style.display = 'block';
	        document.getElementById('preview').style.display = 'none';
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
	