<%@page import="movie.DTO.Movies"%>
<%@page import="movie.DTO.Files"%>
<%@page import="movie.Service.FileServiceImpl"%>
<%@page import="movie.Service.FileService"%>
<%@page import="movie.DTO.Posts"%>
<%@page import="movie.Service.PostServiceImpl"%>
<%@page import="movie.Service.PostService"%>
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
	response.setHeader("Content-Type","text/html;charset=UTF-8");
	
	
	// 넘어온 파라미터값 변수에 저장
	String movieNo 		= request.getParameter("movieNo");
	String keywordNo	= request.getParameter("keywordNo");
	String type		 	= request.getParameter("type");
	int index 			= Integer.parseInt( request.getParameter("nowPage") );
	
	
	// 검색 키워드 설정
	String keyword = "";
	
	// 서비스 설정
	PostService postService 		= new PostServiceImpl();
	KeywordService keywordService 	= new KeywordServiceImpl();
	FileService fileService 		= new FileServiceImpl(); 
	// 페이지 객체생성
	Page pageSet = new Page();
	
	// 9장씩 보여주기
	pageSet.setSize(9);
	pageSet.setIndex(index);
	
	// 랜덤으로 뿌려주기
	Map<String, String> filterOptions = new HashMap<String, String>();
	
		
	// 검색할 컬럼명 지정
	List<String> searchOptions = new ArrayList<String>();
	searchOptions.add("keywordNo");
	
	
	
	
	switch(type){
		case "movie" 	:
			Keywords keywordInfo = keywordService.selectByMovieNo(Integer.parseInt(movieNo));
			keyword = Integer.toString(keywordInfo.getKeywordNo());
			break;
		case "keyword" 	: keyword = keywordNo; break;
	}
	
	
	
	PageInfo<Posts> pageInfo = postService.page(pageSet, keyword, searchOptions, filterOptions);
	List<Posts> postList 	= new ArrayList<Posts>();
	postList = pageInfo.getList();
	
	for( Posts post : postList ){ 
		
		// 파일 정보 불러오기
		Files fileInfo = fileService.selectByPostNo(post.getPostNo());
		pageContext.setAttribute("imgURL", fileInfo.getFileUrl());
		pageContext.setAttribute("root", root);
		%>
		
		<li class="post-item">
			<div class="img-box">
				<img src="${ root + imgURL }"/>
			</div>
		</li>
	<% 
	} 
	
%>