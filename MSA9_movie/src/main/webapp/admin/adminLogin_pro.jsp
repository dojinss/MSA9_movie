<%@page import="movie.DTO.Users"%>
<%@page import="java.net.http.HttpRequest"%>
<%@page import="movie.Service.UserServiceImpl"%>
<%@page import="movie.Service.UserService"%>

<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//인코딩 세팅
	request.setCharacterEncoding("UTF-8");
	// 아이디 비밀번호 가져오기
	String userID = request.getParameter("id");
	String userPWD = request.getParameter("password");
	
	// 로그인 요청
	Users user = Users.builder()
					  .userId(userID)
					  .userPwd(userPWD)
					  .build()
					  ;
	UserService userService = new UserServiceImpl();
	Users loginUser = userService.login(user);
	
	// 로그인 실패
	if( loginUser == null ) {
		// 에러코드를 들고 다시 로그인 페이지로
		response.sendRedirect(root+"/admin/adminLogin.jsp?error=400");
		return;
	}
	else{
		// 세션에 사용자 정보 등록
		session.setAttribute("loginId", loginUser.getUserId());
		session.setAttribute("loginUser", loginUser);
		// 메인 화면으로 리다이렉트
		response.sendRedirect(root+"/admin/movie/adminMovieList.jsp");
	}
%>