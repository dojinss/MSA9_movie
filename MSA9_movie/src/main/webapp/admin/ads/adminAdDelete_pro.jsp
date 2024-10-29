<%@page import="movie.DTO.Ads"%>
<%@page import="movie.Service.AdServiceImpl"%>
<%@page import="movie.Service.AdService"%>
<%@page import="java.io.File"%>
<%@ include file="/admin/layout/login.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%
	int adNo = Integer.parseInt(request.getParameter("adNo"));
	AdService adService = new AdServiceImpl();
	Ads ad = adService.select(adNo);
	int result = adService.delete(adNo);
	if(result==1){
		File file = new File(ad.getContent());
		file.delete();
		response.sendRedirect(root+"/admin/ads/adminAdList.jsp");
	}else{
		response.sendRedirect(root+"/admin/ads/adminAdUpdate.jsp?adNo="+adNo);
	}
%>