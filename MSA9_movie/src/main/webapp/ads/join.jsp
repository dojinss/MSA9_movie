<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>Netstar - 영화 커뮤니티</title>
	<jsp:include page="/layout/meta.jsp" />
	<jsp:include page="/layout/link.jsp" />
	<link href="<%= root %>/static/css/ads.css" rel="stylesheet" />
</head>
<body>
	<jsp:include page="/layout/header.jsp" />
	<%-- [Contents] ######################################################### --%>
		
	<div class="background">
		<div class="container">
			<div class="sidemenu-box">
				<ul class="sidemenu">
					<li>
						<a href="<%= root %>/ads/main.jsp">광고메인</a>
					</li>
					<li class="active">
						<a href="<%= root %>/ads/insert.jsp">광고가입하기</a>
					</li>
					<li>
						<a href="<%= root %>/ads/join.jsp">광고등록하기</a>
					</li>
					<li>
						<a href="<%= root %>/ads/list.jsp">등록된 광고보기</a>
					</li>
				</ul>
			</div>
			<div class="content-box">
				<div class="form-box">
					<form action="insert_pro.jsp" method="post">
						<label for="number" >사업자등록번호</label>
						<input type="text" name="number" id="number"/>
						<label for="image" >대표이미지</label>
						<input type="file" name="image" id="image"/>
						<label for="addr" >사업자 소재지</label>
						<input type="text" name="addr" id="addr"/>
						<button type="submit">가입하기</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>
	

