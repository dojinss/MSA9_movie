<%@page import="movie.DTO.Files"%>
<%@page import="java.io.File"%>
<%@page import="jakarta.servlet.annotation.MultipartConfig"%>
<%@page import="jakarta.servlet.annotation.WebServlet"%>
<%@page import="jakarta.servlet.http.HttpServlet"%>
<%@page import="jakarta.servlet.http.HttpServletRequest"%>
<%@page import="jakarta.servlet.http.HttpServletResponse"%>
<%@page import="jakarta.servlet.http.Part"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="movie.Service.FileServiceImpl"%>
<%@page import="movie.Service.FileService"%>
<%@page import="movie.Service.PostServiceImpl"%>
<%@page import="movie.Service.PostService"%>
<%@page import="movie.DTO.Posts"%>
<%@page import="movie.DTO.Users"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    int fileResult = 0;
    String mode = "insert";
    int postNo = 0;

    // 로그인한 유저 정보 가져오기
    Users user = (Users) session.getAttribute("loginUser");

    // Posts 객체 생성
    Posts post = new Posts();
    post.setUserNo(user.getUserNo()); // userNo 세팅

    // 파일 업로드 경로
    String path = uploadPath;

    // 넘어온 파라미터값 변수에 저장
    String content = "";

    // 서비스 설정
    PostService postService = new PostServiceImpl();
    FileService fileService = new FileServiceImpl();

    // 파일 업로드 처리
    List<String> filePaths = new ArrayList<>();
    
    // 파일 파트 가져오기
    for (Part part : request.getParts()) {
        String fieldName = part.getName();

        // 일반 데이터 처리
        if (part.getContentType() == null) {
            String value = request.getParameter(fieldName);
            if (fieldName.equals("content")) {
                post.setContent(value); // content 내용 post객체에 세팅
            } else if (fieldName.equals("keywordNo") && !value.isEmpty()) {
                post.setKeywordNo(Integer.parseInt(value)); // keywordNo 세팅
            } else if (fieldName.equals("movieNo") && !value.isEmpty()) {
                post.setMovieNo(Integer.parseInt(value)); // movieNo 세팅
            } else if (fieldName.equals("postNo") && !value.isEmpty()) {
                postNo = Integer.parseInt(value); // update 모드일경우 postNo 담겨옴
            } else if (fieldName.equals("mode") && !value.isEmpty()) {
                mode = value; // update인지 insert인지 체크
            }
        } 
        // 파일 데이터 처리
        else {
            String fileName = part.getSubmittedFileName();
            long fileSize = part.getSize();

            File file = new File(path + "/" + fileName);
            part.write(file.getAbsolutePath());
            filePaths.add(file.getAbsolutePath());
        }
    }

    if (postNo == 0) {
        int lastPK = postService.insertKey(post);
        if (lastPK > 0) {
            for (String str : filePaths) {
                Files file = new Files();
                file.setFileUrl(str);
                file.setPostNo(lastPK);
                fileResult += fileService.insert(file);
            }
        }
    } else {
        post.setPostNo(postNo);
        postService.update(post);
        // 기존 파일 정보 불러오기
        List<Files> oldList = fileService.list(postNo);
        // 기존 파일들 삭제
        for (Files file : oldList) {
            File oldFile = new File(file.getFileUrl());
            if (oldFile.exists()) {
                oldFile.delete();
            }
        }
        // 기존 파일 DB 정보 삭제
        fileService.deleteByPostNo(postNo);
        // 파일 정보 DB에 입력
        for (String str : filePaths) {
            Files file = new Files();
            file.setFileUrl(str);
            file.setPostNo(postNo);
            fileResult += fileService.insert(file);
        }
    }

    out.println(fileResult);
%>
