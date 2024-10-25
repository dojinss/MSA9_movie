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
<title>영화 추가 화면</title>
<jsp:include page="/admin/layout/link.jsp"/>
<link rel="stylesheet" href="<%= root %>/admin/css/adminMovieInsert.css">
</head>
<body>
	<div class="container">
		<jsp:include page="/admin/layout/sidebar.jsp" />
		<div class="main">
			<div class="mainhead">
				<h1>영화 추가</h1>
			</div>
			<div class="mainbody">
				<div class="contentbox">
					<form action="adminMovieInsert_pro.jsp" method="post" enctype="multipart/form-data">
						<div class="content">
							<div class="content-head">
								<p>제목</p>
								<input class="normal-input" type="text" name="title" maxlength="30"/>
							</div>
							<div class="content-body">
								<div class="bodyform">
									<p>공지</p>
									<input class="check" type="checkbox" value="1" name="notice">
								</div>
								<div class="bodyform">
									<p>장르</p>
									<input class="normal-input" type="text" name="cate" maxlength="30">
								</div>
								<div class="bodyform">
									<p>출연</p>
									<input class="normal-input" type="text" name="cast" maxlength="30">
								</div>
								<div class="bodyform">
									<p>줄거리</p>
									<textarea class="large-input" name="content" maxlength="255"></textarea>
								</div>
							</div>
							<div class="content-foot">
								<p>이미지</p>
								<input type="text" id="imagename" readonly> 
								<label class="btn-upload" for="file">
									첨부
								</label> 
								<input class="file" type="file" name="imgae" id="file">
							</div>
						</div>
						<input class="insertbtn" type="submit" value="추가">
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