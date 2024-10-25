<%@page import="movie.Service.MovieServiceImpl"%>
<%@page import="movie.Service.MovieService"%>
<%@page import="movie.DTO.Movies"%>
<%@page import="movie.DTO.Users"%>
<%@ include file="/layout/jstl.jsp"%>
<%@ include file="/admin/layout/login.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>영화 수정 화면</title>
<jsp:include page="/admin/layout/link.jsp"/>
<link rel="stylesheet" href="<%= root %>/admin/css/adminMovieUpdate.css">
<jsp:include page="/admin/layout/movie.jsp"/>
<%
	int movieNo = Integer.parseInt(request.getParameter("movieNo"));
	MovieService movieService = new MovieServiceImpl();
	Movies movie = movieService.select(movieNo);
	int index = movie.getImageUrl().indexOf("_");
	String imageName = movie.getImageUrl().substring(index+1);
%>
<c:set var="movie" value="<%=movie%>" />
<c:set var="imageName" value="<%=imageName%>" />
</head>
<body>
	<div class="container">
		<jsp:include page="/admin/layout/sidebar.jsp" />
		<div class="main">
			<div class="mainhead">
				<h1>영화 수정</h1>
			</div>
			<div class="mainbody">
				<div class="contentbox">
					<form action="adminMovieUpdate_pro.jsp" method="post" enctype="multipart/form-data">
						<div class="content">
							<div class="content-head">
								<input type="hidden" name="movieNo" value="${movie.movieNo}">
								<p>제목</p>
								<input class="normal-input" type="text" name="title" value="${movie.title}" maxlength="30"/>
							</div>
							<div class="content-body">
								<div class="bodyform">
									<p>공지</p>
									<c:choose>
										<c:when test="${movie.notice}"> 
											<input class="check" type="checkbox" value="1" name="notice" checked>
										</c:when> 
										<c:otherwise>
											<input class="check" type="checkbox" value="1" name="notice">
										</c:otherwise> 
									</c:choose> 
								</div>
								<div class="bodyform">
									<p>장르</p>
									<input class="normal-input" type="text" name="cate" value="${movie.cate}" maxlength="30">
								</div>
								<div class="bodyform">
									<p>출연</p>
									<input class="normal-input" type="text" name="cast" value="${movie.cast}" maxlength="30">
								</div>
								<div class="bodyform">
									<p>줄거리</p>
									<textarea class="large-input" name="content" maxlength="250">${movie.content}</textarea>
								</div>
							</div>
							<div class="content-foot">
								<p>이미지</p>
								<input type="text" id="imagename" value="${imageName}" readonly> 
								<label class="btn-upload" for="file">
									첨부
								</label> 
								<input class="file" type="file" name="imgae" id="file" onchange="fileChange()">
							</div>
						</div>
						<input class="updatebtn" type="submit" value="수정">
					</form>
					<button class="deletebtn" id="delconfirm" data="<%=movie.getMovieNo()%>" path="adminMovieDelete_pro.jsp?movieNo=">삭제</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>