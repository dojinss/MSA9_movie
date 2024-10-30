<%@page import="java.net.URLDecoder"%>
<%@page import="movie.Service.UserServiceImpl"%>
<%@page import="movie.Service.UserService"%>
<%@page import="movie.DTO.Users"%>
<%@page import="movie.utils.PasswordUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");

// 요청 파라미터 처리
String userId = request.getParameter("id");
String userPwd = request.getParameter("userpwd");

// UserService 인스턴스 생성
UserService userService = new UserServiceImpl();
Users user = Users.builder()
                   .userId(userId)
                   .userPwd(userPwd)
                   .build();

// 로그인 시도
Users selectedUser = userService.login(user);

if (selectedUser != null) {
	//일치하지 않으면~
    int result = userService.delete(selectedUser.getUserNo());
    if (result > 0) {
        out.print("탈퇴가 완료되었습니다.");  // 탈퇴 성공 메시지
    } else {
        out.print("탈퇴 실패");  // 탈퇴 실패 메시지
    }
} else {
    out.print("아이디 또는 비밀번호가 일치하지 않습니다.");  // 인증 실패 메시지
}
%>
