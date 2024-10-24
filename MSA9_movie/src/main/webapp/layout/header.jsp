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
		<a href="./index.jsp"><img src="<%= root %>/static/img/logo.png"/></a>
		<nav>
			<ul>
				<c:if test="${ userid == null }">
					<a href="./signup.jsp">회원가입</a>
					<a href="./login.jsp">로그인</a>
				</c:if>
				<c:if test="${ userid != null }">
					${ user.userId }님 환영합니다.
					<a href="./logout.jsp">로그아웃</a>
				</c:if>
			</ul>
		</nav>
</header>