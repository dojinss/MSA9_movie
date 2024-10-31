<%@page import="movie.Service.UserServiceImpl"%>
<%@page import="movie.Service.UserService"%>
<%@page import="movie.DTO.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//인코딩 세팅
	request.setCharacterEncoding("UTF-8");
	// 회원 정보 수정 처리
	String userPwd = request.getParameter("userpwd");
	String email = request.getParameter("email");
	String profileUrl = request.getParameter("profile");
	
	
	// 로그인 유저 정보 가져오기
	Users loginUser = (Users) session.getAttribute("loginUser");
	
	UserService userService = new UserServiceImpl();
	Users editUser = Users.builder()
					.userNo(loginUser.getUserNo())
					.userPwd(userPwd)
					.email(email)
					.profileUrl(profileUrl)
					.enabled(true)
					.build();
	
	int result = userService.update(editUser);
	out.println(result);
%>
