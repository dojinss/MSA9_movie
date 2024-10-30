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
Users selectedUser = userService.login(user); // 조회

response.setContentType("text/plain; charset=UTF-8"); // 응답 타입 설정
if (selectedUser != null) {
    int result = userService.delete(selectedUser.getUserNo()); // 사용자 삭제
    if (result > 0) {
        out.print("탈퇴가 완료되었습니다."); // 성공 응답
    } else {
        out.print("탈퇴 실패하였습니다."); // 실패 응답
    }
} else {
    out.print("아이디 또는 비밀번호가 일치하지 않습니다."); // 로그인 실패 응답
}
%>

