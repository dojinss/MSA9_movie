<%@page import="java.util.UUID"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="movie.Service.MovieServiceImpl"%>
<%@page import="movie.Service.MovieService"%>
<%@page import="movie.DTO.Movies"%>
<%@ include file="/admin/layout/login.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    MovieService movieService = new MovieServiceImpl();
    String title = "";
    boolean notice = false;
    String cate = "";
    String cast = "";
    String content = "";
    String imageUrl = "";

    String path = uploadPath; // 파일 업로드 경로 설정
    File uploadDir = new File(path);
    if (!uploadDir.exists()) {
        uploadDir.mkdir();
    }

    // 폼 데이터 처리
    title = request.getParameter("title");
    notice = "1".equals(request.getParameter("notice"));
    cate = request.getParameter("cate");
    cast = request.getParameter("cast");
    content = request.getParameter("content");

    // 파일 업로드 처리
    Part filePart = request.getPart("file"); // "file"은 HTML form에서 파일 input의 name 속성
    if (filePart != null && filePart.getSize() > 0) {
        String fileName = UUID.randomUUID() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        File file = new File(path, fileName);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, file.toPath());
        }
        imageUrl = file.getPath();
    }

    // DTO 객체 생성
    Movies movie = Movies.builder()
            .title(title)
            .notice(notice)
            .cate(cate)
            .cast(cast)
            .content(content)
            .imageUrl(imageUrl)
            .build();

    // 데이터베이스에 삽입
    int result = movieService.insert(movie);
    if (result == 1) {
        response.sendRedirect(root + "/admin/movie/adminMovieList.jsp");
    } else {
        response.sendRedirect(root + "/admin/movie/adminMovieInsert.jsp");
    }
%>
