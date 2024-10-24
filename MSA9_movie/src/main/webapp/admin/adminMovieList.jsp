<%@page import="movie.Service.MovieServiceImpl"%>
<%@page import="movie.Service.MovieService"%>
<%@page import="movie.DTO.Movies"%>
<%@page import="java.util.List"%>
<%@page import="movie.DTO.Users"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>관리자 메인 페이지</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<link rel="stylesheet" href="css/adminMain.css">
</head>
<body>
	<%
		Users user = (Users) session.getAttribute("loginUser");
	
		if( user == null ){
			response.sendRedirect("adminLogin.jsp");
		}
		MovieService movieService = new MovieServiceImpl();
		List<Movies> movieList = movieService.select();
	%>
	<div class="container">
		<div class="menu">
			<h1>관리자 페이지</h1>
			<hr style="margin-bottom: 30px;">
			<h2>관리자<a href="adminLogin.jsp"><i class="fa fa-sign-out" aria-hidden="true"></i></a></h2>
			<hr>
			<div class="item">
				<h3><a href="">팝업 관리</a></h3>
			</div>
			<div class="item">
				<h3><a href="">영화 게시글</a></h3>
			</div>
			<div class="item">
				<h3><a href="">회원 관리</a></h3>
			</div>
			<div class="item">
				<h3><a href="">회원 게시글</a></h3>
			</div>
			<div class="item">
				<h3><a href="">광고 설정</a></h3>
			</div>
			<div class="item">
				<h3><a href="">광고주 관리</a></h3>
			</div>
			<div class="item">
				<h3><a href="">광고글 관리</a></h3>
			</div>
		</div>
		<div class="main">
			<div class="mainhead">
				<h1>영화 목록</h1>
			</div>
			<div class="mainbody">
				<div class="contentbox">
					<div class="content">
						<table class="movie-list">
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
										<td><a href="adminMovieInsert.jsp?no=${movie.movieNo}">소개목록</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="pagenation">
							<a href="" class="page-link">＜ 이전</a>
							<a href="" class="page-link selected">1</a>
							<a href="" class="page-link">2</a>
							<a href="" class="page-link">3</a>
							<a href="" class="page-link">4</a>
							<a href="" class="page-link">5</a>
							<a href="" class="page-link">다음 ＞</a>
						 </div>
					</div>
					<a href="" class="insertbtn">추가</a>
				</div>
			</div>

		</div>
	</div>
</body>
</html>