<%@page import="movie.Service.UserServiceImpl"%>
<%@page import="movie.Service.UserService"%>
<%@page import="movie.DTO.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
// 인코딩 세팅
request.setCharacterEncoding("UTF-8");

// 요청 파라미터 처리
String action = request.getParameter("action");

if ("checkId".equals(action)) {
    // 아이디 중복 확인 로직
    String userId = request.getParameter("userid");
    UserService userService = new UserServiceImpl();
    Users user = userService.select(userId);
    
    if (user == null) {
        out.println("1"); // 아이디 없음
    } else {
        out.println("0"); // 아이디 있음
    }
} else {
    // 회원가입 처리
    String userId = request.getParameter("id");
    String userPwd = request.getParameter("userpwd");
    String email = request.getParameter("email");
    String profileUrl = request.getParameter("profile");

    Users user = Users.builder()
        .userId(userId)
        .userPwd(userPwd)
        .email(email)
        .profileUrl(profileUrl)
        .enabled(true)
        .build();

    UserService userService = new UserServiceImpl();
    int result = userService.signup(user);

    if (result > 0) {
        response.sendRedirect("signup.jsp"); // 회원가입 성공 시 이동
    } else {
        out.println("회원가입 실패");
    }
}
%>
