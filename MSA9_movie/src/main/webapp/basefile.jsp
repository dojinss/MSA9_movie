<%-- jstl 파일 include --%>
<%@ include file="/layout/jstl.jsp" %>
<%-- 기본 설정 파일 include --%>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Netstar - 영화 커뮤니티</title>
	<%-- 사이트 설정 파일 include --%>
	<jsp:include page="/layout/meta.jsp" />
	<%-- css 파일 include --%>
	<jsp:include page="/layout/link.jsp" />
	<%-- 페이지 전용 css 파일 --%>
	<link href="<%= root %>/static/css/<%-- css 이름 입력 --%>.css" rel="stylesheet" />
</head>
<body>
	<%-- 헤더 파일 include --%>
	<jsp:include page="/layout/header.jsp" />
	<%-- [Contents] ######################################################### --%>
		
	<div class="container">
		<%-- 
		
				내용 입력 
				(주석 제거후 사용)				
				
		--%>
	</div>
	
	<%-- [Contents] ######################################################### --%>
	<%-- 푸터 파일 include --%>
	<jsp:include page="/layout/footer.jsp" />
	<%-- script 파일 include --%>
	<jsp:include page="/layout/script.jsp" />
</body>
</html>
	

