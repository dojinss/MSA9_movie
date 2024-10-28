<%@page import="movie.DTO.Primes"%>
<%@page import="movie.Service.PrimeServiceImpl"%>
<%@page import="movie.Service.PrimeService"%>
<%@page import="java.io.File"%>
<%@ include file="/admin/layout/login.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%
	int primeNo = Integer.parseInt(request.getParameter("primeNo"));  
	System.out.println("결과는 : " + primeNo);
	PrimeService primeService = new PrimeServiceImpl();
	Primes prime = primeService.selectByPrimeNo(primeNo);
	int result = primeService.delete(primeNo);
	if(result==1){
		File file = new File(prime.getImageUrl());
		file.delete();
		response.sendRedirect(root+"/admin/prime/adminPrimeList.jsp");
	}else{
		response.sendRedirect(root+"/admin/prime/adminPrimeUpdate.jsp?primeNo="+primeNo);
	}
%>