<%@page import="movie.Service.UserServiceImpl"%>
<%@page import="movie.Service.UserService"%>
<%@page import="movie.DTO.Users"%>
<%@page import="java.util.List"%>
<%@page import="movie.DTO.Files"%>
<%@page import="com.alohaclass.jdbc.dto.PageInfo"%>
<%@page import="movie.DTO.Posts"%>
<%@page import="movie.Service.FileServiceImpl"%>
<%@page import="movie.Service.FileService"%>
<%@page import="movie.Service.PostServiceImpl"%>
<%@page import="movie.Service.PostService"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	// UTF-8 인코딩설정
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	response.setHeader("text/html", "charset=UTF-8");
	
	// 넘어온 파라미터값 변수에 저장
	int postNo	= Integer.parseInt( request.getParameter("postNo") );
	
	// 서비스 설정
	PostService postService = new PostServiceImpl();
	FileService fileService = new FileServiceImpl();
	UserService userService = new UserServiceImpl();
	
	// 게시글 정보 조회
	Posts post = postService.selectByPostNo(postNo);
	
	// 게시글 이미지 목록 불러오기
	List<Files> fileList = fileService.list(postNo);
	
	Users user = userService.select(post.getUserNo());
	pageContext.setAttribute("user", user);
	pageContext.setAttribute("content", post.getContent());
%>

<div class="post-view-container">
	<div class="img-box">
		<div class="slide">
			<ul class="img-list">
				<% for( Files file : fileList ){ 
					String filePath = file.getFileUrl();
					String fileName = filePath.substring(filePath.lastIndexOf("/"));
					pageContext.setAttribute("url", root + "/images?fileName=" + fileName);
				%>
					<li class="slide-images">
						<img src="${url}" />
					</li>
				<% } %>
			</ul>
		</div>
	</div>
	<div class="post-icon-box">
		<!-- icons : font Awsome -->
	</div>
	<p class="user-id">${user.getUserId()}</p>
	<div class="post-content">${content}</div>
</div>










