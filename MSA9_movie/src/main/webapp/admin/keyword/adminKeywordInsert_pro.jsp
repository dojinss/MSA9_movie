<%@page import="movie.DTO.Keywords"%>
<%@page import="movie.Service.KeywordServiceImpl"%>
<%@page import="movie.Service.KeywordService"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="jakarta.servlet.http.Part"%>
<%@ include file="/admin/layout/login.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    KeywordService keywordService = new KeywordServiceImpl();
    int movieNo = 0;
    String title = "";
    String type = "";
    String content = "";
    String imageUrl = "";

    String path = uploadPath; // 파일 업로드 경로 설정
    File uploadDir = new File(path);
    if (!uploadDir.exists()) {
        uploadDir.mkdir();
    }

    try {
        // Multipart form 데이터에서 텍스트 필드 처리
        movieNo = Integer.parseInt(request.getParameter("movieNo"));
        title = request.getParameter("title");
        type = request.getParameter("type");
        content = request.getParameter("content");

        // 파일 업로드 처리
        Part filePart = request.getPart("file"); // "file"은 form에서 지정한 파일 input의 name 속성
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = UUID.randomUUID() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            File file = new File(path, fileName);
            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, file.toPath());
            }
            imageUrl = file.getPath();
        }

        // DTO 객체 생성 및 데이터베이스 저장
        Keywords keyword = Keywords.builder()
                .movieNo(movieNo)
                .title(title)
                .type(type)
                .content(content)
                .imageUrl(imageUrl)
                .build();

        int result = keywordService.insert(keyword);
        if (result == 1) {
            response.sendRedirect(root + "/admin/keyword/adminKeywordList.jsp?movieNo=" + movieNo);
        } else {
            response.sendRedirect(root + "/admin/keyword/adminKeywordInsert.jsp?movieNo=" + movieNo + "&error=insert_failed");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect(root + "/admin/keyword/adminKeywordInsert.jsp?movieNo=" + movieNo + "&error=exception");
    }
%>
