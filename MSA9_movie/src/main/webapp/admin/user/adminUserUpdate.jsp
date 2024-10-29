<%@page import="movie.Service.UserServiceImpl"%>
<%@page import="movie.Service.UserService"%>
<%@page import="movie.DTO.Users"%>
<%@ include file="/layout/jstl.jsp"%>
<%@ include file="/admin/layout/login.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원 수정 화면</title>
<jsp:include page="/admin/layout/link.jsp"/>
<link rel="stylesheet" href="<%= root %>/admin/css/adminUserForm.css?after">

</head>
<%
	int userNo = Integer.parseInt(request.getParameter("userNo"));
	UserService userService = new UserServiceImpl();
	Users user = userService.select(userNo);
%>
<c:set var="user" value="<%=user%>" />
<body>
	<div class="container">
		<jsp:include page="/admin/layout/sidebar.jsp" />
		<div class="main">
			<div class="mainhead">
				<h1>회원 수정</h1>
			</div>
			<div class="mainbody">
				<div class="contentbox">
					<form action="adminUserUpdate_pro.jsp" method="post">
						<div class="content">
							<input type="hidden" name="userNo" value="${user.userNo}">
							<div class="content-head">
								<p>아이디</p>
								<input class="normal-input" type="text" name="userId" value="${user.userId}" maxlength="20"/>
							</div>
							<div class="content-body">
								<div class="bodyform">
									<p>이메일</p>
									<input class="normal-input" type="text" name="email" value="${user.email}" maxlength="30"/>
								</div>
								<div class="bodyform">
									<p>휴면</p>
									<c:choose>
										<c:when test="${user.enabled}">
											<input class="check" type="checkbox" value="1" name="enabled"
												checked>
										</c:when>
										<c:otherwise>
											<input class="check" type="checkbox" value="1" name="enabled">
										</c:otherwise>
									</c:choose>
								</div>
								<div class="bodyform">
									<p>권한</p>
									<select class="select" id="type" name="ruleNo">
										<option value="1" <%= 1==(user.getRuleNo()) ? "selected" : "" %>>일반회원</option>
										<option value="2" <%= 2==(user.getRuleNo()) ? "selected" : "" %>>광고주</option>
										<option value="3" <%= 3==(user.getRuleNo()) ? "selected" : "" %>>관리자</option>
									</select>
								</div>
							</div>
							<div class="content-foot">
								<input class="updatebtn" type="submit" value="수정">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>