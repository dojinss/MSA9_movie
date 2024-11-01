<%@page import="movie.DTO.Ads"%>
<%@page import="movie.Service.AdServiceImpl"%>
<%@page import="movie.Service.AdService"%>
<%@page import="movie.Service.PrimeServiceImpl"%>
<%@page import="movie.Service.PrimeService"%>
<%@page import="movie.DTO.Files"%>
<%@page import="movie.Service.FileServiceImpl"%>
<%@page import="movie.Service.FileService"%>
<%@page import="movie.DTO.Primes"%>
<%@page import="java.util.ArrayList"%>
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
	String keywordNo	= request.getParameter("keywordNo");
	String keywordType 	= request.getParameter("type");
	int index 			= Integer.parseInt( request.getParameter("nowPage") );
	
	// 검색 키워드 설정
	String keyword = "";
	
	// 서비스 설정
	AdService adService = new AdServiceImpl();
	PrimeService primeService = new PrimeServiceImpl(); 
	
	// 페이지 객체생성
	Page pageSet = new Page();
	
	// 페이징 세팅
	pageSet.setSize(10);
	pageSet.setIndex(index);
	
	// 필터 옵션
	Map<String, String> filterOptions = new HashMap<String, String>();
		
	
	// 검색할 컬럼명 지정
	List<String> searchOptions = new ArrayList<String>();
	if( !keywordNo.equals("") || keywordNo != null){
		searchOptions.add("keywordNo");
		keyword = keywordNo;
	}
	
	PageInfo<Ads> pageInfo 	= adService.page(pageSet, keyword, searchOptions, filterOptions);
	List<Ads> adList 		= new ArrayList<Ads>();
	adList 					= pageInfo.getList();
	for( Ads ad : adList ){ 
		
		// 광고주 정보 불러오기
		Primes primeInfo 	= primeService.selectByPrimeNo(ad.getPrimeNo());
		
		pageContext.setAttribute("imgURL",	primeInfo.getImageUrl());		// 대표 이미지
		pageContext.setAttribute("name", 	primeInfo.getName());			// 사업자명
		pageContext.setAttribute("root", 	root);
		%>
		
		<li class="post-item">
			<div class="img-box">
				<img src="${ root + imgURL }"/>
			</div>
			<div class="title-box">
				<p class="title">${name}</p>
			</div>
		</li>
	<% 
	} 
%>