<%@page import="movie.DTO.Primes"%>
<%@page import="movie.Service.PrimeServiceImpl"%>
<%@page import="movie.Service.PrimeService"%>
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
<title>광고주 수정 화면</title>
<jsp:include page="/admin/layout/link.jsp"/>
<link rel="stylesheet" href="<%= root %>/admin/css/adminPrimeForm.css">
<jsp:include page="/admin/layout/movie.jsp"/>
<%
	int primeNo = Integer.parseInt(request.getParameter("primeNo"));
	PrimeService primeService = new PrimeServiceImpl();
	Primes prime = primeService.selectByPrimeNo(primeNo);
	
	int index = prime.getImageUrl().indexOf("_",10);
	String imageName = prime.getImageUrl().substring(index+1);
%>
<c:set var="prime" value="<%=prime%>" />
<c:set var="imageName" value="<%=imageName%>" />
</head>
<body>
	<div class="container">
		<jsp:include page="/admin/layout/sidebar.jsp" />
		<div class="main">
			<div class="mainhead">
				<h1>광고주 수정</h1>
			</div>
			<div class="mainbody">
				<div class="contentbox">
					<form action="adminPrimeUpdate_pro.jsp" method="post" enctype="multipart/form-data">
						<div class="content">
							<div class="content-head">
								<input type="hidden" name="primeNo" value="${prime.primeNo}">
								<p>이름</p>
								<input class="normal-input" type="text" name="name" value="${prime.name}" maxlength="20"/>
							</div>
							<div class="content-body">
								<div class="bodyform">
									<p>사업자등록번호</p>
									<input class="number-input" type="text" name="number" value="${prime.number}" maxlength="30">
								</div>
								<div class="bodyform">
									<p>사업자 소재지</p>
									<input class="normal-input" type="text" name="addr" value="${prime.addr}" maxlength="40">
								</div>
								<div class="bodyform">
									<p>광고 시작기간</p>
									<input type="date" class="date" name="startTime" value="${prime.startTime}">
								</div>
								<div class="bodyform">
									<p>광고 종료기간</p>
									<input type="date" class="date" name="endTime" value="${prime.endTime}">
								</div>
							</div>
							<div class="content-foot">
								<p>이미지</p>
								<input type="hidden" name="imageUrl" value="${prime.imageUrl}">
								<input type="text" id="imagename" value="${imageName}" readonly> 
								<label class="btn-upload" for="file">
									첨부
								</label> 
								<input class="file" type="file" name="imgae" id="file" onchange="fileChange()">
							</div>
						</div>
						<input class="updatebtn" type="submit" value="수정">
					</form>
					<button class="deletebtn" id="delconfirm" data="<%=prime.getPrimeNo()%>" path="adminPrimeDelete_pro.jsp?primeNo=">삭제</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>