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
		<a href="/"><img src="<%= root %>/static/img/logo.png" /></a>
		<div></div>
		<nav>
			<ul>
				<c:if test="${ userid == null }">
					<li><a href="<%= root %>/index.jsp">로그인</a></li>
					<li><a href="<%= root %>/user.jsp">회원가입</a></li>
				</c:if>
				<c:if test="${ userid != null }">
					<li><a href="<%= root %>/infoUpdate.jsp"><span class="text-bold">${ user.userId }</span></a><span>님 환영합니다.</span></li>
					<li><a href="<%= root %>/logout.jsp">로그아웃</a></li>
				</c:if>
			</ul>
		</nav>
</header>