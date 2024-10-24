<%@page import="movie.Service.MovieServiceImpl"%>
<%@page import="movie.Service.MovieService"%>
<%@page import="movie.DTO.Movies"%>
<%@page import="java.util.List"%>
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
	<title>영화 목록 화면</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<link rel="stylesheet" href="<%= root %>/admin/css/reset.css">
	<link rel="stylesheet" href="<%= root %>/admin/css/style.css">
	<link rel="stylesheet" href="<%= root %>/admin/css/adminMovieList.css">
</head>
<body>
	<%
		MovieService movieService = new MovieServiceImpl();
		List<Movies> movieList = movieService.select();
	%>
	<div class="container">
		<jsp:include page="/admin/layout/sidebar.jsp" />
		<div class="main">
			<div class="mainhead">
				<h1>영화 목록</h1>
			</div>
			<div class="mainbody">
				<div class="contentbox">
					<div class="content">
						<table class="movie-list">
							<colgroup>
								<col style="width: 20%;">
								<col style="width: 10%;">
								<col style="width: 40%;">
								<col style="width: 10%;">
								<col style="width: 10%;">
								<col style="width: 10%;">
							</colgroup>
							<thead>
								<tr>
									<th>제목</th>
									<th>장르</th>
									<th>출연</th>
									<th>등록일자</th>
									<th>수정일자</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:set var="movieList" value="<%=movieList%>" />
								<c:forEach var="movie" items="${movieList}">
									<tr>
										<td><c:out value="${movie.title}" /></td>
										<td><c:out value="${movie.cate}" /></td>
										<td><c:out value="${movie.cast}" /></td>
										<td><fmt:formatDate value="${movie.regDate}"
												pattern="yyyy-MM-dd" /></td>
										<td><fmt:formatDate value="${movie.updDate}"
												pattern="yyyy-MM-dd" /></td>
										<td><a href="adminMovieInfoList.jsp?no=${movie.movieNo}">소개목록</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="pagenation">
							<a href="" class="page-link">＜ 이전</a> <a href=""
								class="page-link selected">1</a> <a href="" class="page-link">2</a>
							<a href="" class="page-link">3</a> <a href="" class="page-link">4</a>
							<a href="" class="page-link">5</a> <a href="" class="page-link">다음
								＞</a>
						</div>
					</div>
					<a href="adminMovieInsert.jsp" class="insertbtn">추가</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>