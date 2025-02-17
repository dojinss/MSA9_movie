<%@page import="movie.DTO.Files"%>
<%@page import="movie.DTO.Posts"%>
<%@page import="movie.DTO.Primes"%>
<%@page import="movie.DTO.Ads"%>
<%@page import="com.alohaclass.jdbc.dto.PageInfo"%>
<%@page import="movie.DTO.Movies"%>
<%@page import="movie.DTO.Keywords"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.alohaclass.jdbc.dto.Page"%>
<%@page import="movie.Service.FileServiceImpl"%>
<%@page import="movie.Service.FileService"%>
<%@page import="movie.Service.KeywordServiceImpl"%>
<%@page import="movie.Service.KeywordService"%>
<%@page import="movie.Service.PrimeServiceImpl"%>
<%@page import="movie.Service.PrimeService"%>
<%@page import="movie.Service.AdServiceImpl"%>
<%@page import="movie.Service.AdService"%>
<%@page import="movie.Service.MovieServiceImpl"%>
<%@page import="movie.Service.MovieService"%>
<%@page import="movie.Service.PostServiceImpl"%>
<%@page import="movie.Service.PostService"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	
	// 넘어온 파라미터값 변수에 저장
	String movieNo 		= request.getParameter("movieNo");
	String keywordNo	= request.getParameter("keywordNo");
	String type		 	= request.getParameter("type");
	String nowPage		= request.getParameter("nowPage") ;
	int index 			= ( nowPage != "" && !nowPage.isEmpty() )? Integer.parseInt(nowPage) - 1 : 0;
	int movieNoInt		= 0;
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
	List<Posts> postList = null;
	
	
	switch(type){
		case "movie" 	:
			movieNoInt = Integer.parseInt(movieNo);
			keywordInfo = keywordService.selectByMovieNo(movieNoInt);
			movie = movieService.select(movieNoInt);
			keyword = movieNo;
			title = movie.getTitle();
			subTitle = movie.getCast();
			content = movie.getContent();
			imgURL = movie.getImageUrl();
			postList 	= postService.infiniteList( index, 9 , movieNoInt );
			break;
		case "keyword" 	: 
			keyword = keywordNo;
			int keyNo = Integer.parseInt(keywordNo);
			keywordInfo = keywordService.select(Integer.parseInt(keywordNo));
			movie = movieService.select( keywordInfo.getMovieNo() );
			movieNoInt = movie.getMovieNo();
			title = movie.getTitle();
			subTitle = keywordInfo.getTitle();
			content = keywordInfo.getContent();
			imgURL = keywordInfo.getImageUrl();
			postList 	= postService.infiniteListByKeywordNo( index, 9 , keyNo);
			break;
	}
	Page adPage = new Page();
	List<String> adOption = new ArrayList<String>();
	adOption.add("keywordNO");
	PageInfo<Ads> adsPageInfo = adService.page(adPage, keyword, adOption);
	List<Ads> adList = adsPageInfo.getList();
	int indexOfadImg = imgURL.lastIndexOf("/");
	String adFileName = imgURL.substring(indexOfadImg + 1);
	
	// 게시판 정보 출력
	%>
		<div class="post-info-wrap">
			<input type="hidden" id="movieNo" value="<%= movieNo%>"/>
			<input type="hidden" id="keywordNo" value="<%= keywordNo%>"/>
			<input type="hidden" id="postType" value="<%= type%>"/>
			<div class="img-box">
				<img src="<%=root%>/images?fileName=<%=adFileName %>" />
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
					if(fileInfo != null){
						int indexOfimg = fileInfo.getFileUrl().lastIndexOf("/");
						String fileName = fileInfo.getFileUrl().substring(indexOfimg + 1);
						pageContext.setAttribute("fileName", fileName);
					}
					pageContext.setAttribute("postNo", post.getPostNo());
				%>
					
					<li class="post-item" data="${postNo}">
						<img src="<%=root%>/images?fileName=${ fileName != null ? fileName : '' }"/>						
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
	<input type="hidden" name="movieNo" value="<%= movieNo%>"/>
	<input type="hidden" name="keywordNo" value="<%= keywordNo%>"/>
	<input type="hidden" name="postNo" value=""/>
	</form>
	<div id="success-modal">
		<div id="success-post">등록 완료</div>
	</div>
	</div>
	<div class="post-container" id="post-view-tab">
		
	</div>
