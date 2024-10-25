<%@page import="movie.Service.MovieServiceImpl"%>
<%@page import="movie.Service.MovieService"%>
<%@page import="movie.DTO.Movies"%>
<%@page import="movie.DTO.Users"%>
<%@ include file="/layout/jstl.jsp"%>
<%@ include file="/layout/common.jsp"%>
<%@ include file="/admin/layout/login.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>영화 추가 화면</title>
<jsp:include page="/admin/layout/link.jsp"/>
<link rel="stylesheet" href="<%= root %>/admin/css/adminMovieUpdate.css">
<%
	int movieNo = Integer.parseInt(request.getParameter("movieNo"));
	MovieService movieService = new MovieServiceImpl();
	Movies movie = movieService.select(movieNo);
%>
<c:set var="movie" value="<%=movie%>" />
</head>
<body>
	<div class="container">
		<jsp:include page="/admin/layout/sidebar.jsp" />
		<div class="main">
			<div class="mainhead">
				<h1>영화 수정</h1>
			</div>
			<div class="mainbody">
				<div class="contentbox">
					<form action="adminMovieInsert_pro.jsp" method="post" enctype="multipart/form-data">
						<div class="content">
							<div class="content-head">
								<p>제목</p>
								<input class="normal-input" type="text" name="title" value="${movie.title}" />
							</div>
							<div class="content-body">
								<div class="bodyform">
									<p>공지</p>
									<c:choose>
										<c:when test="${movie.notice}"> 
											<input class="check" type="checkbox" value="1" name="notice" checked>
										</c:when> 
										<c:otherwise>
											<input class="check" type="checkbox" value="1" name="notice">
										</c:otherwise> 
									</c:choose> 
								</div>
								<div class="bodyform">
									<p>장르</p>
									<input class="normal-input" type="text" name="cate" value="${movie.cate}">
								</div>
								<div class="bodyform">
									<p>출연</p>
									<input class="normal-input" type="text" name="cast" value="${movie.cast}">
								</div>
								<div class="bodyform">
									<p>줄거리</p>
									<textarea class="large-input" name="content">${movie.content}</textarea>
								</div>
							</div>
							<div class="content-foot">
								<p>이미지</p>
								<input type="text" id="imagename" value="${movie.imageUrl}" readonly> 
								<label for="file">
									<div class="btn-upload">첨부</div>
								</label> 
								<input class="file" type="file" name="imgae" id="file">
							</div>
						</div>
						<input class="updatebtn" type="submit" value="수정">
						<input class="deletebtn" type="submit" value="삭제">
					</form>
				</div>
			</div>
		</div>
	</div>
	<script>
		window.onload=function(){
			target=document.getElementById('file'); // file 아이디 선언
			target.addEventListener('change',function(){ // change 함수
		
				if(target.value.length){ // 파일 첨부인 상태일경우 파일명 출력
					document.getElementById("imagename").value = target.files[0].name;
				}else{ //버튼 클릭후 취소(파일 첨부 없을 경우)할때 파일명값 안보이게
					document.getElementById("imagename").value = "";
				}
			});
		}
	</script>
</body>
</html>