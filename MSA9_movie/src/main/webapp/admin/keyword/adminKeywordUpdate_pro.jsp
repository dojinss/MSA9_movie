<%@page import="java.util.Date"%>
<%@page import="movie.DTO.Keywords"%>
<%@page import="movie.Service.KeywordServiceImpl"%>
<%@page import="movie.Service.KeywordService"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="jakarta.servlet.http.Part"%>
<%@ include file="/admin/layout/login.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    KeywordService keywordService = new KeywordServiceImpl();

    String path = uploadPath; // 파일 업로드 경로 설정
    File uploadDir = new File(path);
    if (!uploadDir.exists()) {
        uploadDir.mkdir();
    }

    Keywords keyword = new Keywords();
    int movieNo = 0;
    int keywordNo = 0;
    String title = "";
    String type = "";
    String content = "";
    String imgUrl = "";
    String imageUrl = null;

    // 텍스트 파라미터 처리
    movieNo = Integer.parseInt(request.getParameter("movieNo"));
    keywordNo = Integer.parseInt(request.getParameter("keywordNo"));
    title = request.getParameter("title");
    type = request.getParameter("type");
    content = request.getParameter("content");
    imgUrl = request.getParameter("imgUrl");

    // 파일 업로드 처리
    Part filePart = request.getPart("file"); // "file"은 HTML form의 파일 입력 필드 name 속성
    if (filePart != null && filePart.getSize() > 0) {
        String fileName = UUID.randomUUID() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        File file = new File(path, fileName);
        try (InputStream input = filePart.getInputStream()) {
            Files.copy(input, file.toPath());
        }
        imageUrl = file.getPath();
    }

    // 새로운 파일이 업로드되지 않았다면 기존 URL 사용
    if (imageUrl == null) {
        imageUrl = imgUrl;
    } else {
        // 기존 파일 삭제
        File oldFile = new File(imgUrl);
        if (oldFile.exists()) {
            oldFile.delete();
        }
    }

    // DTO 객체에 값 설정
    keyword.setKeywordNo(keywordNo);
    keyword.setMovieNo(movieNo);
    keyword.setTitle(title);
    keyword.setType(type);
    keyword.setContent(content);
    keyword.setImageUrl(imageUrl);
    keyword.setUpdDate(new Date());

    // 데이터베이스 업데이트
    int result = keywordService.update(keyword);
    if (result > 0) {
        response.sendRedirect(root + "/admin/keyword/adminKeywordList.jsp?movieNo=" + keyword.getMovieNo());
    } else {
        response.sendRedirect(root + "/admin/keyword/adminKeywordUpdate.jsp?keywordNo=" + keyword.getKeywordNo());
    }
%>
