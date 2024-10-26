<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="movie.DTO.Keywords"%>
<%@page import="java.util.List"%>
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
	int movieNo = Integer.parseInt(request.getParameter("movieNo"));
	
	MovieService movieService = new MovieServiceImpl();
	Movies movie = movieService.select(movieNo);
	int result = movieService.delete(movieNo);
	if(result==1){
		KeywordService keywordService = new KeywordServiceImpl();
		List<Keywords> keywordList = keywordService.list(movieNo);
		for(Keywords keyword:keywordList){
			File kFile = new File(keyword.getImageUrl());
			kFile.delete();
		}
		keywordService.allDelete(movieNo);
		File file = new File(movie.getImageUrl());
		file.delete();
		response.sendRedirect(root+"/admin/movie/adminMovieList.jsp");
	}else{
		response.sendRedirect(root+"/admin/movie/adminMovieUpdate.jsp?movieNo="+movieNo);
	}
%>