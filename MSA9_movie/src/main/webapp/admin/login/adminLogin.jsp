<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>관리자 로그인 화면</title>
	<link rel="stylesheet" href="<%= root %>/admin/css/adminLogin.css?after">
</head>
<body>
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
			<div class="error">
				<c:if test="${param.error == 400 }">
				<p style="text-align: center; color: red;">아이디 또는 비밀번호가 잘못되었습니다.</p>
			</c:if>
			</div>
			<div class="submit">
				<input type="submit" value="Sign in"/>
			</div>
		</form>
	</div>
</body>
</html>