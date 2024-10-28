<%@page import="movie.DTO.Posts"%>
<%@page import="movie.Service.PostServiceImpl"%>
<%@page import="movie.Service.PostService"%>
<%@page import="com.alohaclass.jdbc.dto.PageInfo"%>
<%@page import="com.alohaclass.jdbc.dto.Page"%>
<%@page import="movie.Service.UserServiceImpl"%>
<%@page import="movie.Service.UserService"%>
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
	<title>게시물 목록 화면</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<jsp:include page="/admin/layout/link.jsp"/>
	<link rel="stylesheet" href="<%= root %>/admin/css/adminList.css?after">
</head>
<body>
	<%
	    // 페이지 번호
	    String pageStr = request.getParameter("page");
	    int pageNo = 1;
	    if( pageStr != null )
	        pageNo = Integer.parseInt( pageStr );
		PostService postService = new PostServiceImpl();
	    Page newPage = new Page();
	    newPage.setPage(pageNo);
	    PageInfo<Posts> pageInfo = postService.page(newPage);
	    List<Posts> postList = pageInfo.getList();
	    int no = (pageNo-1)*10+1;
	    Users user = null;
	    UserService userService = new UserServiceImpl();
	%>
	<c:set var="pageInfo" value="<%= pageInfo %>" />
	<div class="container">
		<jsp:include page="/admin/layout/sidebar.jsp" />
		<div class="main">
			<div class="mainhead">
				<h1>게시물 목록</h1>
			</div>
			<div class="mainbody">
				<div class="contentbox">
					<div class="content">
						<table class="list">
							<colgroup>
								<col style="width: 10%;">
								<col style="width: 50%;">
								<col style="width: 20%;">
								<col style="width: 20%;">
							</colgroup>
							<thead>
								<tr>
									<th>번호</th>
									<th>내용</th>
									<th>작성자</th>
									<th>등록일자</th>
								</tr>
							</thead>
							<tbody>
								<%
									for(Posts post:postList){
										user = userService.select(post.getUserNo());
								%>
										<tr>
											<td><%=no++%></td>
											<td style="text-align: left;">
												<a href="adminPostUpdate.jsp?postNo=<%=post.getPostNo()%>"><c:out value="<%=post.getContent()%>"/></a>
											</td>
											<td><c:out value="<%=user.getUserId()%>"/></td>
											<td><fmt:formatDate value="<%=post.getRegDate()%>"
													pattern="yyyy-MM-dd" /></td>
										</tr>
								<%
									}
								%>
							</tbody>
						</table>
				        <!-- 페이지네이션 -->
				        <div class="pagenation">
				            <a href="?page=${pageInfo.page.prev}">&lt;이전</a>
				            <c:forEach var="page" begin="${pageInfo.page.start}" end="${pageInfo.page.end}">
				                <a href="?page=${page}" class="page-link">${page}</a>
				            </c:forEach>
				            <a href="?page=${pageInfo.page.next}">이후&gt;</a>
				        </div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>