<%@page import="movie.Service.MovieServiceImpl"%>
<%@page import="movie.Service.MovieService"%>
<%@page import="movie.DTO.Movies"%>
<%@page import="movie.DTO.Users"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ include file="/admin/layout/login.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>영화 추가 화면</title>
	<link rel="stylesheet" href="<%= root %>/admin/css/reset.css">
	<link rel="stylesheet" href="<%= root %>/admin/css/style.css">
	<link rel="stylesheet" href="<%= root %>/admin/css/adminMovieInsert.css">
</head>
<body>
	<div class="container">
		<jsp:include page="/admin/layout/sidebar.jsp" />
		<div class="main">
			<div class="mainhead">
				<h1>영화 추가</h1>
			</div>
			<div class="mainbody">
				<div class="contentbox">
					<div class="content">
					</div>
					<a href="adminMovieList.jsp" class="insertbtn">완료</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>