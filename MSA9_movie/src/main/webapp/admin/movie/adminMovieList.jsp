<%@page import="java.util.ArrayList"%>
<%@page import="com.alohaclass.jdbc.dto.Page"%>
<%@page import="com.alohaclass.jdbc.dto.PageInfo"%>
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
	<title>영화 목록 화면</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<jsp:include page="/admin/layout/link.jsp"/>
	<link rel="stylesheet" href="<%= root %>/admin/css/adminList.css?after">
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	    // 페이지 번호
	    String searchCode = request.getParameter("searchCode");
		String keyword = request.getParameter("keyword");
		List<String> searchCodes = new ArrayList<>();
		searchCodes.add(searchCode);
	    String pageStr = request.getParameter("page");
	    int pageNo = 1;
	    if( pageStr != null )
	        pageNo = Integer.parseInt( pageStr );
	    MovieService movieService = new MovieServiceImpl();
	    Page newPage = new Page();
	    newPage.setPage(pageNo);
	    PageInfo<Movies> pageInfo = null;
		if(searchCode!=null && !searchCode.equals("null") && keyword!=null && !keyword.equals("null")){
			pageInfo = movieService.page(newPage,keyword,searchCodes);
		}
		else{
		    pageInfo = movieService.page(newPage);			
		}
	    List<Movies> movieList = pageInfo.getList();
	    int no = (pageNo-1)*10+1;
	%>
	<c:set var="pageInfo" value="<%= pageInfo %>" />
	<div class="container">
		<jsp:include page="/admin/layout/sidebar.jsp" />
		<div class="main">
			<div class="mainhead">
				<h1>영화 목록</h1>
			</div>
			<div class="mainbody">
				<div class="contentbox">
					<form class="searchForm" action="adminMovieList.jsp" method="post">
						<select class="searchCode" name="searchCode">
							<option value="title" selected>제목</option>
							<option value="cate">장르</option>
						</select> 
						<input class="searchInput" type="text" name="keyword">
						<input type="submit" value="검색">
					</form>
					<div class="content">
						<table class="list">
							<colgroup>
								<col style="width: 10%;">
								<col style="width: 70%;">
								<col style="width: 10%;">
								<col style="width: 10%;">
							</colgroup>
							<thead>
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>등록일자</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:set var="movieList" value="<%=movieList%>" />
								<c:forEach var="movie" items="${movieList}">
									<tr>
										<td><%=no++%></td>
										<td><a href="adminMovieUpdate.jsp?movieNo=${movie.movieNo}"><c:out value="${movie.title}" /></a></td>
										<td><fmt:formatDate value="${movie.regDate}"
												pattern="yyyy-MM-dd" /></td>
										<td><a class="keyword-info" href="<%=root%>/admin/keyword/adminKeywordList.jsp?movieNo=${movie.movieNo}">소개목록</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
				        <!-- 페이지네이션 -->
				        <div class="pagenation">
				            <a href="?page=${pageInfo.page.prev}&keyword=<%=keyword%>&searchCode=<%=searchCode%>">&lt;이전</a>
				            <c:forEach var="page" begin="${pageInfo.page.start}" end="${pageInfo.page.end}">
				                <a href="?page=${page}&keyword=<%=keyword%>&searchCode=<%=searchCode%>" class="page-link">${page}</a>
				            </c:forEach>
				            <a href="?page=${pageInfo.page.next}&keyword=<%=keyword%>&searchCode=<%=searchCode%>">이후&gt;</a>
				        </div>
					</div>
					<a href="adminMovieInsert.jsp" class="insertbtn">추가</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>