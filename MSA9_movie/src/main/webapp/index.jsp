<%-- jstl 파일 include --%>
<%@ include file="/layout/jstl.jsp" %>
<%-- 기본 설정 파일 include --%>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Netstar - 영화 커뮤니티</title>
	<%-- 사이트 설정 파일 include --%>
	<jsp:include page="/layout/meta.jsp" />
	<%-- css 파일 include --%>
	<jsp:include page="/layout/link.jsp" />
	<%-- 페이지 전용 css 파일 --%>
	<link href="<%= root %>/static/css/<%-- css 이름 입력 --%>.css" rel="stylesheet" />
</head>
<body>
	<%-- 헤더 파일 include --%>
	<jsp:include page="/layout/header.jsp" />
	<%-- [Contents] ######################################################### --%>
		
<<<<<<< HEAD
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
=======
	<div class="container">
		<%-- 
		
				내용 입력 
				(주석 제거후 사용)				
				
		--%>
	</div>
>>>>>>> branch 'main' of https://github.com/LimeYun/MSA9_movie.git
	
	<%-- [Contents] ######################################################### --%>
	<%-- 푸터 파일 include --%>
	<jsp:include page="/layout/footer.jsp" />
	<%-- script 파일 include --%>
	<jsp:include page="/layout/script.jsp" />
</body>
</html>
	