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
String userId =  request.getParameter("id");
String userPwd =  request.getParameter("userpwd");


out.println("userId : " + userId);
out.println("userPwd : " + userPwd);

UserService userService = new UserServiceImpl();
Users user = Users.builder()
// 		   .userId(userId.trim())
// 		   .userPwd(userPwd.trim())
		   .userId(userId)
		   .userPwd(userPwd)
		   .build();
Users selectedUser = userService.login(user); // 조회

out.println("selectedUser : " + selectedUser);

	if (selectedUser != null ) {
	    // 비밀번호가 일치하면 탈퇴 처리
	    int result = userService.delete(user.getUserNo()); // 사용자 삭제
	    if (result > 0) {
	        String script = "<script>"
	                + "alert('탈퇴가 완료되었습니다.');"
	                + "window.location.href='main.jsp';" //임의주소
	                + "</script>";
	        out.println(script);
	    } else {
	        String script = "<script>"
	                + "alert('탈퇴 실패. 다시 시도해주세요.');"
	                + "window.location.href='leave.jsp';"
	                + "</script>";
	        out.println(script);
	    }
	} else {
	    String script = "<script>"
	            + "alert('아이디 또는 비밀번호가 일치하지 않습니다.');"
	            + "window.location.href='leave.jsp';"
	            + "</script>";
	    out.println(script);
	}
%>
