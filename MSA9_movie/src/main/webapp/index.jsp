<%@page import="movie.DTO.Users"%>
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
<title>메인 화면</title>
</head>
<body>
	<%
// 		String userid = (String) session.getAttribute("loginID");
		Users user = (Users) session.getAttribute("loginUser");
		
		if( user != null ){
			pageContext.setAttribute("user", user);
			pageContext.setAttribute("userid", user.getUserId());
		}
	%>
	
	<h1>메인 화면</h1>
	<ul>
		<c:if test="${ userid == null }">
			<li><a href="./signup.jsp">회원가입</a></li>
			<li><a href="./login.jsp">로그인</a></li>
		</c:if>
		<c:if test="${ userid != null }">
			<li>${ user.userId }님 환영합니다.</li>
			<li><a href="./logout.jsp">로그아웃</a></li>
		</c:if>
		
	</ul>
</body>
</html>
