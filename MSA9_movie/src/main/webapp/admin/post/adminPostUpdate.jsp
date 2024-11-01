<%@page import="movie.Service.UserServiceImpl"%>
<%@page import="movie.Service.UserService"%>
<%@page import="movie.Service.FileServiceImpl"%>
<%@page import="movie.Service.FileService"%>
<%@page import="movie.DTO.Files"%>
<%@page import="movie.DTO.Posts"%>
<%@page import="movie.Service.PostServiceImpl"%>
<%@page import="movie.Service.PostService"%>
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
<title>게시글 수정 화면</title>
<jsp:include page="/admin/layout/link.jsp"/>
<link rel="stylesheet" href="<%= root %>/admin/css/adminPostForm.css">
<jsp:include page="/admin/layout/script.jsp"/>
<%
	int postNo = Integer.parseInt(request.getParameter("postNo"));
	PostService postService = new PostServiceImpl();
	Posts post = postService.selectByPostNo(postNo);
	FileService fileService = new FileServiceImpl();
	Files file = fileService.selectByPostNo(postNo);
	UserService userService = new UserServiceImpl();
	Users user = userService.select(post.getUserNo());
	int index = file.getFileUrl().indexOf("_",10);
	String imageName = file.getFileUrl().substring(index+1);
%>
<c:set var="post" value="<%=post%>" />
<c:set var="file" value="<%=file%>" />
<c:set var="user" value="<%=user%>" />
<c:set var="imageName" value="<%=imageName%>" />
</head>
<body>
	<div class="container">
		<jsp:include page="/admin/layout/sidebar.jsp" />
		<div class="main">
			<div class="mainhead">
				<h1>게시글 수정</h1>
			</div>
			<div class="mainbody">
				<div class="contentbox">
					<form id="post-update" action="adminPostUpdate_pro.jsp" method="post" enctype="multipart/form-data" onsubmit="return false;">
						<div class="content">
							<div class="content-head">
								<input type="hidden" name="postNo" value="<%=post.getPostNo() %>">
								<p>${user.userId}</p>
							</div>
							<div class="content-body">
								<div class="bodyform">
									<p>내용</p>
									<textarea class="large-input" name="content" maxlength="250">${post.content}</textarea>
								</div>
							</div>
							<div class="content-foot">
								<p>이미지</p>
								<input type="hidden" name="fileUrl" value="${file.fileUrl}">
								<input type="text" id="imagename" value="${imageName}" readonly> 
								<label class="btn-upload" for="file">
									첨부
								</label> 
								<input class="file" type="file" name="imgae" id="file" onchange="fileChange()">
							</div>
						</div>
						<button class="updatebtn" onClick="update()">수정</button>
					</form>
					<button class="deletebtn" id="delconfirm" data="<%=post.getPostNo()%>" path="adminPostDelete_pro.jsp?postNo=">삭제</button>
				</div>
			</div>
		</div>
	</div>
	<script src="<%= root %>/admin/js/post.js"></script>
</body>
</html>