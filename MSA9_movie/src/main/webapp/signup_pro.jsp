<%@page import="movie.Service.UserServiceImpl"%>
<%@page import="movie.Service.UserService"%>
<%@page import="movie.DTO.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String userid 	= request.getParameter("userid");
	String password = request.getParameter("password");
	String name 	= request.getParameter("name");
	String email 	= request.getParameter("email");
	
	// User 객체 생성
	Users user = Users.builder()
					  .userId(userid)
					  .userPwd(password)
					  .email(email)
					  .enabled(true)
					  .build()
					  ;
					  
	
	// 회원 가입 요청
	UserService us = new UserServiceImpl();
	int result = us.signup(user);
	
	// 회원가입 성공
	if( result > 0 ) {
		response.sendRedirect("./index.jsp");
	}
	// 회원가입 실패
	else {
		response.sendRedirect("./signup.jsp?error=400");
	}
%>