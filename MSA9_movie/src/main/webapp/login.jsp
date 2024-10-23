<%@page import="java.net.URLDecoder"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인	</title>
</head>
<body>
	<%
		String rememberID = "";
		String userID = "";
		Cookie[] cookies = request.getCookies();
		if(cookies != null){
			for( Cookie cookie : cookies ){
				String cookieName = cookie.getName();
				String cookieValue = URLDecoder.decode( cookie.getValue(), "UTF-8" );
				switch(cookieName){
					case "userID" 		: userID = cookieValue; break;
					case "rememberID" 	: rememberID = cookieValue; break;
				}
			}
		}
		
		pageContext.setAttribute("userID", userID);
		pageContext.setAttribute("rememberID", rememberID);
	%>
	<c:if test="${param.error == 0 }">
		<p style="color:red;">회원 정보가 일치하지 않습니다.</p>
	</c:if>
	<h1>로그인</h1>
	<form action="login_pro.jsp" method="post">
		<p>아이디 : <input type="text" name="userid" id="userid" value="${ userID }" /> </p>
		<p>비밀번호 : <input type="password" name="password" id="password" /> </p>
		<p>
			<!-- 아이디저장 -->
			<label for="remember-id">아이디 저장</label>
			<input type="checkbox" name="remember-id" id="remember-id" ${ (rememberID == "on")?"checked":""}/>
			
			<!-- 자동로그인 -->
			<label for="remember-me">자동 로그인</label>
			<input type="checkbox" name="remember-me" id="remember-me" />
		</p>
		<p>
			<input type="submit" value="로그인"/>
		</p>
	</form>
</body>
</html>