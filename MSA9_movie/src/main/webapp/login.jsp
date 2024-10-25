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
</head>
<body>
	<jsp:include page="/layout/header.jsp" />
	<%-- [Contents] ######################################################### --%>
		
	<div class="login-container">
      <!-- 로그인 영역 -->
      <form action="/login" method="post">
        <!--  로그인 박스 -->
        <div class="login-wrap">

          <div class="login-text">
            <p>로그인</p>
          </div>
          

          <div id="login">
            <!-- 아이디 -->
            <div class="login-inputbox">
                <input type="text" name="id" placeholder="ID" autofocus required>
            </div>
            <!-- 비밀번호 -->
              <div class="login-inputbox">
                <input type="password" name="pw" placeholder="PW" required>
              </div>
              
              <!-- 로그인 / 회원 가입 -->
              <div class="login-btn">
                  <a href="#" class="login-btn">로그인</a>
              </div>
              <div class="or">
                <p>또는</p>
              </div>
              <div class="login-btn">
                  <a href="#" class="login-btn2"> 회원가입</a>
              </div>
              
              <!-- 아이디 저장/ 로그인  -->
              <div class="login-remember">
                <label for="remember-id">
                    <input type="checkbox" name="remember-id" id="remember-id">
                    <span class="checkmark"></span>
                    <span>아이디 저장</span>
                </label>
                <label for="remember-me">
                    <input type="checkbox" name="remember-me" id="remember-me">
                    <span class="checkmark"></span>
                    <span>자동 로그인</span>
                </label>
              </div>
          </div>
        </div>
      </form>
    </div>
	
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>
	

