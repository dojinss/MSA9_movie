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

if (user != null) {
    user.setUserPwd(userPwd);
    user.setEmail(email);
    if (profileUrl != null && !profileUrl.isEmpty()) {
        user.setProfileUrl(profileUrl);
    }
    
    int result = userService.update(user);
    
    if (result > 0) {
        String script = "<script>"
                + "alert('수정 완료되었습니다.');"
                + "window.location.href='main.jsp';"
                + "</script>";
        out.println(script);
    } else {
        String script = "<script>"
                + "alert('수정에 실패했습니다. 다시 시도해주세요.');"
                + "window.location.href='infoUpdate.jsp';"
                + "</script>";
        out.println(script);
    }
} else {
    String script = "<script>"
            + "alert('회원 정보를 찾을 수 없습니다.');"
            + "window.location.href='infoUpdate.jsp';"
            + "</script>";
    out.println(script);
}
%>
