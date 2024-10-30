<%@page import="movie.Service.UserServiceImpl"%>
<%@page import="movie.Service.UserService"%>
<%@page import="movie.DTO.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");

String userId = request.getParameter("id");
String userPwd = request.getParameter("userpwd");
String email = request.getParameter("email");
String profileUrl = request.getParameter("profile");

UserService userService = new UserServiceImpl();
Users user = userService.select(userId);

// 사용자 존재 여부 확인
if (user == null) {
    String script = "<script>"
            + "alert('사용자가 존재하지 않습니다.');"
            + "window.location.href='infoUpdate.jsp';"
            + "</script>";
    out.println(script);
    return; // 이후 코드 실행 중지
}

// 입력값 유효성 검사
if (userPwd == null || userPwd.trim().isEmpty()) {
    String script = "<script>"
            + "alert('비밀번호를 입력하세요.');"
            + "window.location.href='infoUpdate.jsp';"
            + "</script>";
    out.println(script);
    return; // 이후 코드 실행 중지
}

if (email == null || !email.matches("^[0-9a-zA-Z](-_\\.)?[0-9a-zA-Z]*@[0-9a-zA-Z](-_\\.)?[0-9a-zA-Z]*\\.[a-zA-Z]{2,3}$")) {
    String script = "<script>"
            + "alert('유효한 이메일을 입력하세요.');"
            + "window.location.href='infoUpdate.jsp';"
            + "</script>";
    out.println(script);
    return; // 이후 코드 실행 중지
}

// 비밀번호 및 이메일 업데이트
user.setUserPwd(userPwd); // 비밀번호 암호화 처리 필요
user.setEmail(email);
if (profileUrl != null && !profileUrl.isEmpty()) {
    user.setProfileUrl(profileUrl);
}

int result = userService.update(user);

if (result > 0) {
    String script = "<script>"
            + "alert('수정 완료되었습니다.');"
            + "window.location.href='index.jsp';"
            + "</script>";
    out.println(script);
} else {
    String script = "<script>"
            + "alert('수정에 실패했습니다. 다시 시도해주세요.');"
            + "window.location.href='infoUpdate.jsp';"
            + "</script>";
    out.println(script);
}
%>
