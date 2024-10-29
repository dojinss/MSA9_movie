<%@page import="movie.DTO.Files"%>
<%@page import="movie.DTO.Posts"%>
<%@page import="movie.Service.FileServiceImpl"%>
<%@page import="movie.Service.FileService"%>
<%@page import="movie.Service.PostServiceImpl"%>
<%@page import="movie.Service.PostService"%>
<%@page import="java.io.File"%>
<%@ include file="/admin/layout/login.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%
	int postNo = Integer.parseInt(request.getParameter("postNo"));
	
	PostService postService = new PostServiceImpl();
	FileService fileService = new FileServiceImpl();
	Files oldFile = fileService.selectByPostNo(postNo);
	int result = postService.deleteByPostNo(postNo);
	if(result==1){
		fileService.delete(oldFile.getFileNo());
		File file = new File(oldFile.getFileUrl());
		file.delete();
		response.sendRedirect(root+"/admin/post/adminPostList.jsp");
	}else{
		response.sendRedirect(root+"/admin/post/adminPostUpdate.jsp?postNo="+postNo);
	}
%>