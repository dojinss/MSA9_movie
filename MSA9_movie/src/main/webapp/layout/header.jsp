<%@ include file="/layout/jstl.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<%@page import="movie.DTO.Users"%>
<%
	Users user = (Users) session.getAttribute("loginUser");
	
	if( user != null ){
		pageContext.setAttribute("user", user);
		pageContext.setAttribute("userid", user.getUserId());
	}
%>
<header>
	<img src="<%= root %>/static/img/logo.png" width="48" >
	<nav>
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
	</nav>
</header>