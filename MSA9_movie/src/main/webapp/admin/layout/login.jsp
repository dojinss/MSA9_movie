<%@page import="movie.DTO.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// Context Path (루트 경로)
	String root = request.getContextPath();
	// 로그인 아이디 (세션)
	String moviePath = "C:/MSA9/upload";
	Users user = (Users) session.getAttribute("loginUser");
	
	if( user == null ){
		response.sendRedirect("adminLogin.jsp");
	}
%>