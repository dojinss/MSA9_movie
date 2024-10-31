<%@page import="movie.DTO.Keywords"%>
<%@page import="java.util.ArrayList"%>
<%@page import="movie.DTO.Keywords"%>
<%@page import="com.alohaclass.jdbc.dto.PageInfo"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.alohaclass.jdbc.dto.Page"%>
<%@page import="movie.Service.KeywordServiceImpl"%>
<%@page import="movie.Service.KeywordService"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	
	// 넘어온 파라미터값 변수에 저장
	int movieNo 		= Integer.parseInt( request.getParameter("movieNo"));
	String keywordType 	= request.getParameter("type");
	
	// 키워드서비스 설정
	KeywordService keywordService = new KeywordServiceImpl();
	
	List<Keywords> keywordList 	= keywordService.list(movieNo);
	%>
	
	<ul class="keyword-list">
	<%
	for( Keywords word : keywordList ){ 
		
		pageContext.setAttribute("content", 	word.getContent());				// 소개글
		pageContext.setAttribute("keywordNo", 	word.getKeywordNo());			// 소개글
		if(!word.getImageUrl().isEmpty() && word.getImageUrl() != null)
 			pageContext.setAttribute("imgURL", 		word.getImageUrl().substring( word.getImageUrl().lastIndexOf("/")));		// 이미지경로
		pageContext.setAttribute("title", 		word.getTitle());				// 제목
		pageContext.setAttribute("type", 		word.getType());				// 종류 (음식,음악,장소)
		pageContext.setAttribute("root", 		root);							// 최상경로
		%>
		
		<li class="keyword-item" data="${keywordNo}">
			<div class="img-box">
				<img src="${root}/images?fileName=${imgURL}"/>
			</div>
			<div class="text-box">
				<p class="title">${title}</p>
				<p class="content">${content}</p>
			</div>
		</li>
	<% 
	} 
	%>
	</ul>