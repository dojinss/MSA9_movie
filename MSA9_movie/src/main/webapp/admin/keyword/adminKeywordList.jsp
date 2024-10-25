<%@page import="movie.DTO.Keywords"%>
<%@page import="movie.Service.KeywordServiceImpl"%>
<%@page import="movie.Service.KeywordService"%>
<%@page import="movie.Service.MovieServiceImpl"%>
<%@page import="movie.Service.MovieService"%>
<%@page import="movie.DTO.Movies"%>
<%@page import="java.util.List"%>
<%@page import="movie.DTO.Users"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/admin/layout/login.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>소개글 목록 화면</title>
	<jsp:include page="/admin/layout/link.jsp"/>
	<link rel="stylesheet" href="<%= root %>/admin/css/adminMovieList.css">
</head>
<body>
	<%
		int movieNo = Integer.parseInt(request.getParameter("movieNo"));
		KeywordService keywordService = new KeywordServiceImpl();
		List<Keywords> keywordList = keywordService.list(movieNo);
	%>
	<div class="container">
		<jsp:include page="/admin/layout/sidebar.jsp" />
		<div class="main">
			<div class="mainhead">
				<h1>소개 목록</h1>
			</div>
			<div class="mainbody">
				<div class="contentbox">
					<div class="content">
						<table class="movie-list">
							<colgroup>
								<col style="width: 10%;">
								<col style="width: 70%;">
								<col style="width: 20%;">
							</colgroup>
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>등록일자</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="keywordList" value="<%=keywordList%>" />
								<c:forEach var="keyword" items="${keywordList}">
									<c:set var="no" value="${no+1}" />
									<tr>
										<td>${no}</td>
										<td><a href="<%=root%>/admin/keyword/adminKeywordUpdate.jsp?keywordNo=${keyword.keywordNo}&movieNo=${keyword.movieNo}"><c:out value="${keyword.title}" /></a></td>
										<td><fmt:formatDate value="${keyword.regDate}"
												pattern="yyyy-MM-dd" /></td>
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
							<a href="" class="page-link">다음 ></a>
						</div>
					</div>
					<a href="<%=root%>/admin/keyword/adminKeywordInsert.jsp?movieNo=<%=movieNo%>" class="insertbtn">추가</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>