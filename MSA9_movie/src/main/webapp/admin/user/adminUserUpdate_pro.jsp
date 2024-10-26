<%@ include file="/admin/layout/login.jsp" %>
<%@page import="movie.DTO.Users"%>
<%@page import="movie.Service.UserServiceImpl"%>
<%@page import="movie.Service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int userNo = Integer.parseInt(request.getParameter("userNo"));
	Boolean enabled = false;
	if(request.getParameter("enabled").equals("1"))
		enabled = true;
	int ruleNo = Integer.parseInt(request.getParameter("ruleNo"));
	UserService userService = new UserServiceImpl();
	Users user = userService.select(userNo);
	user.setEnabled(enabled);
	user.setRuleNo(ruleNo);
	
	int result = userService.update(user);
	
	if(result > 0){
		response.sendRedirect(root+"/admin/user/adminUserList.jsp");
	}else{
		response.sendRedirect(root+"/admin/user/adminUserUpdate.jsp?userNo="+user.getUserNo());
	}

%>