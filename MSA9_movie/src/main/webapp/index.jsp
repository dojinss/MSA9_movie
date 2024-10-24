<%@page import="java.util.ArrayList"%>
<%@page import="movie.DTO.Movies"%>
<%@page import="com.alohaclass.jdbc.dto.PageInfo"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.alohaclass.jdbc.dto.Page"%>
<%@page import="movie.Service.MovieServiceImpl"%>
<%@page import="movie.Service.MovieService"%>
<%@page import="movie.DAO.MovieDAO"%>
<%@page import="movie.DTO.Users"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Users user = (Users) session.getAttribute("loginUser");
	
	if( user != null ){
		pageContext.setAttribute("user", user);
		pageContext.setAttribute("userid", user.getUserId());
	}
%>
<!DOCTYPE html>
<html>
<head>
	<title>Netstar - 영화 커뮤니티</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
	<link href="<%= root %>/static/css/main.css" rel="stylesheet" />
</head>
<body>
	<jsp:include page="/layout/header.jsp" />
	<%-- [Contents] ######################################################### --%>
	<c:if test="${ userid == null }">
	<div class="container-full">
		<!-- 로그인 영역 -->
		<form action="<%= root %>/login_pro.jsp" method="post">
		<!--  로그인 박스 -->
		<div class="login-wrap">
			
			<!-- 타이틀 -->
			<div class="login-title">
				<p>로그인</p>
			</div>
			<!-- 아이디 -->
			<div class="login-inputbox">
			    <input type="text" name="userid" placeholder="ID" autofocus required>
			</div>
			<!-- 비밀번호 -->
			<div class="login-inputbox">
				<input type="password" name="password" placeholder="PW" required>
			</div>
			<!-- 로그인 / 회원 가입 -->
			<div class="login-inputbox">
			    <button type="submit" class="login-btn">로그인</button>
			</div>
			<div class="or">
			  <p>또는</p>
			</div>
			<div class="login-inputbox">
			    <a href="#" class="join-btn"> 회원가입</a>
			</div>
			<!-- 아이디 저장/ 로그인  -->
			<div class="remember-box">
				<label for="remember-id">
					<input type="checkbox" name="remember-id" id="remember-id">
					<span class="checkmark"></span>
					<span>아이디 저장</span>
				</label>
				<label for="remember-me">
					<input type="checkbox" name="remember-me" id="remember-me">
					<span class="checkmark"></span>
					<span>자동 로그인</span>
				</label>
			</div>
		</div>
		</form>
	</div>
	</c:if>
	<c:if test="${ userid != null }">
		<%	
		
			MovieService movieService = new MovieServiceImpl();
			Page pageSet = new Page();
			
			// 5장씩 보여주기
			pageSet.setPage(5);
			
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
				out.println("<span style=\" color:white \"" + ">" + movie.getTitle() + "</span><br>");
			} 
		%>
	</c:if>
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>
	