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
		File file = new File(movie.getImageUrl());
		file.delete();
		response.sendRedirect(root+"/admin/movie/adminMovieList.jsp");
	}else{
		response.sendRedirect(root+"/admin/movie/adminMovieUpdate.jsp?movieNo="+movieNo);
	}
%>