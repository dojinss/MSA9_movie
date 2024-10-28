<%@page import="movie.Service.UserServiceImpl"%>
<%@page import="movie.Service.UserService"%>
<%@page import="movie.DTO.Primes"%>
<%@page import="movie.Service.PrimeServiceImpl"%>
<%@page import="com.fasterxml.jackson.databind.util.internal.PrivateMaxEntriesMap"%>
<%@page import="movie.Service.PrimeService"%>
<%@page import="movie.Service.AdServiceImpl"%>
<%@page import="movie.Service.AdService"%>
<%@page import="movie.DTO.Ads"%>
<%@page import="movie.Service.MovieServiceImpl"%>
<%@page import="movie.Service.MovieService"%>
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
	int movieNo 		= Integer.parseInt( request.getParameter("movieNo") );
	String keywordNo	= request.getParameter("keywordNo");
	String type		 	= request.getParameter("type");
	int index 			= Integer.parseInt( request.getParameter("nowPage") );
	
	// 검색 키워드 설정
	String keyword = "";
	
	// 서비스 설정
	PostService postService 		= new PostServiceImpl();
	MovieService movieService		= new MovieServiceImpl();
	AdService adService				= new AdServiceImpl();
	PrimeService primeService		= new PrimeServiceImpl();
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
	
	// 검색할 게시물 타입
	// - movie 	 : 영화관련 모든주제
	// - keyword : 해당 키워드 주제
	Keywords keywordInfo = null;
	Movies movie = null;
	String title = "";
	String subTitle = "";
	String content = "";
	String imgURL = "";
	
	switch(type){
		case "movie" 	:
			keywordInfo = keywordService.selectByMovieNo(movieNo);
			movie = movieService.select(movieNo);
			keyword = Integer.toString( movieNo );
			title = movie.getTitle();
			subTitle = movie.getCast();
			content = movie.getContent();
			imgURL = movie.getImageUrl();
			break;
		case "keyword" 	: 
			keyword = keywordNo;
			keywordInfo = keywordService.selectByMovieNo(Integer.parseInt(keywordNo));
			movie = movieService.select( keywordInfo.getMovieNo() );
			title = movie.getTitle();
			subTitle = keywordInfo.getTitle();
			content = keywordInfo.getContent();
			imgURL = keywordInfo.getImageUrl();
			break;
	}
	Page adPage = new Page();
	List<String> adOption = new ArrayList<String>();
	adOption.add("keywordNO");
	PageInfo<Ads> adsPageInfo = adService.page(adPage, keyword, adOption);
	List<Ads> adList = adsPageInfo.getList();
	
	// 게시판 정보 출력
	%>
		<div class="post-info-wrap">
			<div class="img-box">
				<img src="<%= imgURL %>"/>
			</div>
			<div class="info-box">
				<p class="title"><%= title %></p>
				<p class="sub-title"><%= subTitle %></p>
				<p class="content"><%= content %></p>
			</div>
		</div>
	<%
	
	// Ads 리스트 출력
	if( adList != null ){
		%>
		
		<div class="ad-list-wrap">
			<ul class="ad-list">
				<%for(Ads ad : adList ) {
					Primes prime = primeService.selectByPrimeNo(ad.getPrimeNo());
					Keywords adKey = keywordService.select(ad.getKeywordNo());
				%>
					<li class="list-item">
						<img src="<%= root + prime.getImageUrl() %>"/>
						<p class="title"><%= prime.getName() %></p>
						<p class="cate"><%= adKey.getTitle() %></p>
					</li>
				<%} %>
			</ul>
		</div>
		
		<%
	}
	
	
	
	List<Posts> postList 	= postService.infiniteList( index, 9 , movieNo );
	%>
	<div class="tab-btn-box">
		<div class="btn active" id="view-list">
			<input type="radio" id="list-tab" name="post-tab" value="list" checked/>
			<label for="list-tab" class="post-tab-btn">
				<span class="material-symbols-outlined dashboard">dashboard</span>
			</label>
		</div>
		<div class="btn" id="write-post">
			<input type="radio" id="write-tab" name="post-tab" value="write"/>
			<label for="write-tab" class="post-tab-btn">
				<span class="material-symbols-outlined post_add">post_add</span>
			</label>
		</div>
	</div>
	<%-- 목록탭 --%>
	<div class="post-container">
		<div class="post-list-wrap">
		<%
		if(postList != null) {
			%>
			
				<ul class="post-list">
				<%
				for( Posts post : postList ){ 
					
					// 파일 정보 불러오기
					Files fileInfo = fileService.selectByPostNo(post.getPostNo());
					if(fileInfo != null)
						pageContext.setAttribute("imgURL", fileInfo.getFileUrl());
					pageContext.setAttribute("root", root);
					%>
					
					<li class="post-item">
						<img src="${ imgURL != null ? root + imgURL : '' }"/>
					</li>
				<% 
				} 
				%>
				</ul>
			<%
		}
		else{
			%>
			<p class="alert">게시물이 없습니다...</p>
			<%
		}
		%>
		</div>
	</div>
	
	<%-- 작성탭 --%>
	<div class="post-container">
	<form method="post" enctype="multipart/form-data" id="post-form" onsubmit="return false;">
	<div class="post-write-wrap">
		<div id="drop">
		    <div class="comment">
		    	<p>이미지 파일을 드래그 앤 드롭 해주세요.</p>
		    </div>    
		    <div id="thumbnails"></div>
		</div>
		<div class="textarea-box">
			<textarea name="content" placeholder="내용작성(200글자 제한)" maxlength="200"></textarea>
			<button type="submit" id="post-form-submit">등록하기</button>
		</div>
	</div>
	<%
	switch(type){
		case "movie" 	:
	%>
		<input type="hidden" name="movieNo" value="<%= movieNo%>"/>
		<%break;
		case "keyword"	:
		%>
		<input type="hidden" name="keywordNo" value="<%= keywordNo%>"/>
	<%	break;
	}
	%>
	</form>
	<div id="success-modal">
		<div id="success-post">등록 완료</div>
	</div>
	</div>
