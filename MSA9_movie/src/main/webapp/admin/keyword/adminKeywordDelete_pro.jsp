<%@page import="movie.DTO.Keywords"%>
<%@page import="movie.Service.KeywordServiceImpl"%>
<%@page import="movie.Service.KeywordService"%>
<%@page import="movie.DTO.Movies"%>
<%@page import="java.io.File"%>
<%@page import="movie.Service.MovieServiceImpl"%>
<%@page import="movie.Service.MovieService"%>
<%@ include file="/admin/layout/login.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%
	int keywordNo = Integer.parseInt(request.getParameter("keywordNo"));
	
	KeywordService keywordService = new KeywordServiceImpl();
	MovieService movieService = new MovieServiceImpl();
	
	Keywords keyword = keywordService.select(keywordNo);
	int result = keywordService.delete(keywordNo);
	if(result==1){
		File file = new File(keyword.getImageUrl());
		file.delete();
		response.sendRedirect(root+"/admin/keyword/adminKeywordList.jsp?movieNo="+keyword.getMovieNo());
	}else{
		response.sendRedirect(root+"/admin/keyword/adminKeywordUpdate.jsp?keywordNo="+keyword.getKeywordNo());
	}
%>