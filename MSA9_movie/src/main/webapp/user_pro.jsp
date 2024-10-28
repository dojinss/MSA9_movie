<%@page import="movie.Service.UserServiceImpl"%>
<%@page import="movie.Service.UserService"%>
<%@page import="movie.DTO.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
// 인코딩 세팅
request.setCharacterEncoding("UTF-8");
// 아이디 가져오기
String userId = request.getParameter("userid");

UserService userService = new UserServiceImpl();
Users user = userService.select(userId);
if(user == null)
	out.println("1");
else
	out.println("0");

%>