<%@page import="movie.DTO.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/layout/common.jsp" %>
<%
	
	if( loginId == null ){
		response.sendRedirect(root+"/admin/adminLogin.jsp");
	}
%>