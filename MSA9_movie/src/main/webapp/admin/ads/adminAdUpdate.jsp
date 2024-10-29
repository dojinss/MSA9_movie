<%@page import="movie.DTO.Primes"%>
<%@page import="movie.Service.PrimeServiceImpl"%>
<%@page import="movie.Service.PrimeService"%>
<%@page import="movie.DTO.Ads"%>
<%@page import="movie.Service.AdServiceImpl"%>
<%@page import="movie.Service.AdService"%>
<%@page import="movie.Service.MovieServiceImpl"%>
<%@page import="movie.Service.MovieService"%>
<%@page import="movie.DTO.Movies"%>
<%@page import="movie.DTO.Users"%>
<%@ include file="/layout/jstl.jsp"%>
<%@ include file="/admin/layout/login.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>광고게시글 수정 화면</title>
<jsp:include page="/admin/layout/link.jsp"/>
<link rel="stylesheet" href="<%= root %>/admin/css/adminAdForm.css">
<jsp:include page="/admin/layout/script.jsp"/>
<%
	int adNo = Integer.parseInt(request.getParameter("adNo"));
	AdService adService = new AdServiceImpl();
	PrimeService primeService = new PrimeServiceImpl();
	Ads ad = adService.select(adNo);
	Primes prime = primeService.selectByPrimeNo(ad.getPrimeNo());
	int index = ad.getContent().indexOf("_",10);
	String imageName = ad.getContent().substring(index+1);
%>
<c:set var="ad" value="<%=ad%>" />
<c:set var="imageName" value="<%=imageName%>" />
</head>
<body>
	<div class="container">
		<jsp:include page="/admin/layout/sidebar.jsp" />
		<div class="main">
			<div class="mainhead">
				<h1>광고게시글 수정</h1>
			</div>
			<div class="mainbody">
				<div class="contentbox">
					<div class="content">
						<form action="adminAdUpdate_pro.jsp" id="update" method="post" enctype="multipart/form-data">
							<div class="content-head">
								<input type="hidden" name="adNo" value="${ad.adNo}">
								<p><%=prime.getName()%></p>
							</div>
							<div class="content-body">
								<div class="bodyform">
									<p>이미지</p>
									<input type="hidden" name="content" value="${ad.content}">
									<input class="normal-input "type="text" id="imagename" value="${imageName}" readonly> 
									<label class="btn-upload" for="file">첨부</label> 
									<input class="file" type="file" name="imgae" id="file" onchange="fileChange()">
								</div>
							</div>
						</form>
						<div class="content-foot">
							<input class="updatebtn" type="submit" value="수정" form="update">
							<button class="deletebtn" id="delconfirm" data="<%=ad.getAdNo()%>" path="adminAdDelete_pro.jsp?adNo=">삭제</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>