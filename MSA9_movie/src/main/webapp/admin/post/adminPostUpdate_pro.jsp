<%@page import="java.nio.file.Paths"%>
<%@page import="movie.Service.FileServiceImpl"%>
<%@page import="movie.Service.FileService"%>
<%@page import="movie.DTO.Files"%>
<%@page import="movie.DTO.Posts"%>
<%@page import="movie.Service.PostServiceImpl"%>
<%@page import="movie.Service.PostService"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@ include file="/admin/layout/login.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    PostService postService = new PostServiceImpl();
    FileService fileService = new FileServiceImpl();

    // 업로드 경로 설정
    String path = uploadPath;
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdir();
    }

    // 초기화
    Posts post = new Posts();
    Files file = new Files();
    String oldFileUrl = "";
    String newFileUrl = "";
    String content = "";
    int postNo = 0;

    // 텍스트 데이터 처리
    postNo = Integer.parseInt(request.getParameter("postNo"));
    post = postService.selectByPostNo(postNo);
    content = request.getParameter("content");
    oldFileUrl = request.getParameter("fileUrl"); // 기존 파일 URL

    // 파일 데이터 처리
    Part filePart = request.getPart("file"); // "file"은 HTML form에서 파일 input의 name 속성
    if (filePart != null && filePart.getSize() > 0) {
        String fileName = UUID.randomUUID() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        File newFile = new File(uploadPath, fileName);
        try (InputStream input = filePart.getInputStream(); FileOutputStream output = new FileOutputStream(newFile)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = input.read(buffer)) != -1) {
                output.write(buffer, 0, bytesRead);
            }
        }
        newFileUrl = newFile.getPath();
    }

    // Post 업데이트
    post.setContent(content);
    post.setUpdDate(new Date());

    // 파일 업데이트 처리
    file = fileService.selectByPostNo(post.getPostNo());
    if (newFileUrl.isEmpty()) {
        file.setFileUrl(oldFileUrl); // 새 파일이 없으면 기존 파일 유지
    } else {
        // 새 파일이 업로드되면 기존 파일 삭제
        File oldFile = new File(oldFileUrl);
        if (oldFile.exists()) {
            oldFile.delete();
        }
        file.setFileUrl(newFileUrl);
        fileService.update(file); // 파일 정보 업데이트
    }

    // 포스트 업데이트 및 결과 처리
    int result = postService.update(post);
    if (result > 0) {
        response.sendRedirect(root + "/admin/post/adminPostList.jsp");
    } else {
        response.sendRedirect(root + "/admin/post/adminPostUpdate.jsp?postNo=" + post.getPostNo());
    }
%>
