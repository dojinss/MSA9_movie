<%@page import="java.util.Date"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="movie.Service.MovieServiceImpl"%>
<%@page import="movie.Service.MovieService"%>
<%@page import="movie.DTO.Movies"%>
<%@ include file="/admin/layout/login.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    MovieService movieService = new MovieServiceImpl();

    // 폼에서 받은 데이터 초기화
    int movieNo = 0;
    String title = "";
    boolean notice = false;
    String cate = "";
    String cast = "";
    String content = "";
    String imgUrl = "";
    String imageUrl = null;

    // 파일 업로드 경로 설정
    String path = uploadPath;
    File uploadDir = new File(path);
    if (!uploadDir.exists()) {
        uploadDir.mkdir();
    }

    // 텍스트 데이터 파라미터 처리
    movieNo = Integer.parseInt(request.getParameter("movieNo"));
    title = request.getParameter("title");
    notice = "1".equals(request.getParameter("notice"));
    cate = request.getParameter("cate");
    cast = request.getParameter("cast");
    content = request.getParameter("content");
    imgUrl = request.getParameter("imageUrl"); // 기존 이미지 URL

    // 파일 데이터 처리
    Part filePart = request.getPart("file"); // "file"은 form에서 파일 input의 name 속성
    if (filePart != null && filePart.getSize() > 0) {
        String fileName = UUID.randomUUID() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        File file = new File(path, fileName);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, file.toPath());
        }
        imageUrl = file.getPath(); // 새 파일 경로 저장
    }

    // 새로운 파일이 업로드되지 않았다면 기존 imgUrl 사용
    if (imageUrl == null) {
        imageUrl = imgUrl;
    } else {
        // 기존 이미지 파일 삭제
        File oldFile = new File(imgUrl);
        if (oldFile.exists()) {
            oldFile.delete();
        }
    }

    // DTO 객체에 값 설정
    Movies movie = new Movies();
    movie.setMovieNo(movieNo);
    movie.setTitle(title);
    movie.setNotice(notice);
    movie.setCate(cate);
    movie.setCast(cast);
    movie.setContent(content);
    movie.setImageUrl(imageUrl);
    movie.setUpdDate(new Date());

    // 데이터베이스 업데이트
    int result = movieService.update(movie);
    if (result > 0) {
        response.sendRedirect(root + "/admin/movie/adminMovieList.jsp");
    } else {
        response.sendRedirect(root + "/admin/movie/adminMovieUpdate.jsp?movieNo=" + movie.getMovieNo());
    }
%>
