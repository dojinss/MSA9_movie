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
		
<div class="user-login">
  <div class="login-box">
  <label for="tab" id="tab">회원 가입</label>
  

    <div class="login-info">

      <div class="sign">
        <div class="group">
          <label for="userid" class="label">아이디</label>
          <input id="userid" type="text" class="input" >
          <button id="userid-check" onclick="idcheck()">중복확인</button>
           <!-- 유효성 검사 후 잘,잘못되었을때 경고문 -->           
           <span id="wrongId" class="successId-messeage">사용할 수 있는 아이디 입니다.</span>
           <span id="wrongId" class="wrongId-messeage">사용할 수 없는 아이디 입니다.</span>
        </div>
        <div class="group">
          <label for="userpwd" class="label">비밀번호</label>
          <input id="userpwd" type="password" class="input" data-type="password">
        </div>
        <div class="group">
          <label for="userpwd2" class="label">비밀번호 확인</label>
          <input id="userpwd2" type="password" class="input" data-type="password">
          <button id="userpwd2-check" onclick="pwdcheck()">확인</button>
          <!-- 유효성 검사 후 잘못되었을때 경고문 -->
           <span id="wrongPw" class="wrongPw-messeage">비밀 번호가 일치하지 않습니다.</span>
        </div>

      <div class="user-edit">
        <div class="group">
          <label for="name" class="label">이름</label>
          <input id="name" type="text" class="input" >
        </div>

        <div class="group">
          <label for="userbirth" class="label">생년월일</label>
          <input id="userbirth" type="date" class="input" data-type="">
        </div>
        
        <div class="group">
          <label for="mail" class="label">이메일</label>
          <input id="mail" type="email" class="input">
        </div>

        <div class="group">
          <label for="profile" class="label">프로필 이미지</label>
        </div>
        <div id="preview-box"></div>
        <input id="profile" type="file" class="input" >
        

      </div>
      </div>
        <div id="edit">
          <button class="edit-btn"  onclick="">가입하기</button>
        </div>
      </div> 
    </div>
  </div>
    

	
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	<%-- JS 링크 파일 --%>
	<script type="text/javascript">
	
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
	
	<!-- 중복 확인 알림  -->
	
	
	
	<!-- 비밀번호 확인 알림 -->
	
	</script>
	
	
	
	
</body>
</html>
	