<%@page import="movie.DTO.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Users user = (Users) session.getAttribute("loginUser");
	
	if( user == null ){
		response.sendRedirect("adminLogin.jsp");
	}
%>