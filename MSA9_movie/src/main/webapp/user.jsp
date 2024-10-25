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
           <!-- 유효성 검사 후 잘못되었을때 경고문 -->
           <span id="wrongId" class="wrong-messeage"></span>
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
           <span id="wrongPw" class="wrong-messeage"></span>
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
	
</body>
</html>
	