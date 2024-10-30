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
	// UTF-8 인코딩설정
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	response.setHeader("text/html", "charset=UTF-8");
	
	// 넘어온 파라미터값 변수에 저장
	String movieNo 		= request.getParameter("movieNo");
	String keywordType 	= request.getParameter("type");
	
	// 검색 키워드 설정
	String keyword = movieNo;
	
	// 키워드서비스 설정
	KeywordService keywordService = new KeywordServiceImpl();
	
	// 페이지 객체생성
	Page pageSet = new Page();
	
	// 5장씩 보여주기
	pageSet.setSize(5);
	
	// 랜덤으로 뿌려주기
	Map<String, String> filterOptions = new HashMap<String, String>() {{
	    put("keywordNo", "desc");
	}};
	
	// 검색할 컬럼명 지정
	List<String> searchOptions = new ArrayList<String>();
	searchOptions.add("movieNo");		// 영화번호와 일치하는 값만 검색 -> 해당영화의 키워드만 검색
	// 키워드 타입 WHERE 절 추가해야하는데 메소드에 옵션이없음....
	
	PageInfo<Keywords> pageInfo = keywordService.page(pageSet, keyword, searchOptions, filterOptions);
	List<Keywords> keywordList 	= new ArrayList<Keywords>();
	keywordList = pageInfo.getList();
	for( Keywords word : keywordList ){ 
		
		pageContext.setAttribute("content", 	word.getContent());				// 소개글
		pageContext.setAttribute("imgURL", 		root + word.getImageUrl());		// 이미지경로
		pageContext.setAttribute("title", 		word.getTitle());				// 제목
		pageContext.setAttribute("type", 		word.getType());				// 종류 (음식,음악,장소)
		pageContext.setAttribute("root", 		root);							// 최상경로
		%>
		
		<li class="keyword-item">
			<div class="img-box">
				<img src="${ root + imgURL }"/>
			</div>
			<div class="text-box">
				<p class="title">${title}</p>
				<p class="content">${content}</p>
			</div>
		</li>
	<% 
	} 
%>