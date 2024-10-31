<%@page import="java.util.ArrayList"%>
<%@page import="movie.DTO.Movies"%>
<%@page import="com.alohaclass.jdbc.dto.PageInfo"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.alohaclass.jdbc.dto.Page"%>
<%@page import="movie.Service.MovieServiceImpl"%>
<%@page import="movie.Service.MovieService"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	

	MovieService movieService = new MovieServiceImpl();
	Page pageSet = new Page();
	
	// 5장씩 보여주기
	pageSet.setSize(5);
	
	// 공지사항부터 검색
	Map<String, String> filterOptions = new HashMap<String, String>() {{
	    put("notice", "desc");
	    put("rand()", "");
	}};
	
	String keyword = "";
	List<String> searchOptions = null;
	PageInfo<Movies> pageInfo = movieService.page(pageSet, keyword, searchOptions, filterOptions);
	List<Movies> movieList = new ArrayList<Movies>();
	movieList = pageInfo.getList();
	for( Movies movie : movieList ){ 
		// 출연진
		String[] cast = movie.getCast().split("/");	//  '/' 로 구분
		String director = cast[0];
		String mainActor = cast[1];
		
		pageContext.setAttribute("backURL", root + movie.getImageUrl());	// 영화 배경 이미지
		pageContext.setAttribute("movieNo", movie.getMovieNo());			// 영화 번호
		pageContext.setAttribute("title", movie.getTitle());				// 영화 제목
		pageContext.setAttribute("content", movie.getContent());			// 영화 줄거리
		pageContext.setAttribute("cate", movie.getCate());					// 영화 장르
		pageContext.setAttribute("director", director);						// 출연진 - 감독
		pageContext.setAttribute("mainActor", mainActor);					// 출연진 - 주연
		
		%>
		<section class="movie" style="background-image:url(${ backURL });">
			<div class="left-box">
				<div class="nav-box">
				<div class="title-box">
					<p class="title">${title}</p>
				</div>
				<div class="icon-box">
					<div class="keyword-view-btn btn" data="${ movieNo }">
						<span class="material-symbols-outlined chat">chat</span>
					</div>
					<div class="post-view-btn btn" data="${ movieNo }">
						<span class="material-symbols-outlined dashboard">dashboard</span>
					</div>
					<div class="info-view-btn btn" data="${ movieNo }">
						<span class="material-symbols-outlined info">info</span>
					</div>
				</div>
				</div>
			</div>
			<div class="right-box">
				<div class="info-box">
					<div class="item-box">
						<p class="title">줄거리</p>
						<p class="content">${ content }</p>
					</div>
					<div class="item-box">
						<p class="title">장르</p>
						<p class="content">${ cate }
					</div>
					<div class="item-box">
						<p class="title">출연진</p>
						<p class="content">감독 : ${ director }</p>
						<p class="content">주연 : ${ mainActor }</p>
					</div>
				</div>
			</div>					
		</section>
	<% 
	} 
%>