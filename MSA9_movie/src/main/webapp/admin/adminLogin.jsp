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
	<link rel="stylesheet" href="css/adminLogin.css">
</head>
<body>
	<%
		String error = request.getParameter("error");
	%>
	<div class="container">
		<div class="title">
			<h1>Admin Page</h1>
			<h2>Log-in</h2>
		</div>
		<form action="adminLogin_pro.jsp" method="post">
			<div class="typing">
				<h3>Admin ID</h3>
				<input type="text" name="id" placeholder="Admin id"/>
				<h3>Password</h3>
				<input type="password" name="password" placeholder="Password" />
			</div>
			<div class="submit">
				<input type="submit" value="Sign in"/>
			</div>
		</form>
	</div>
</body>
</html>