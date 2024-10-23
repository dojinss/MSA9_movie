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
					<li class="active">
						<a href="<%= root %>/ads/main.jsp">광고메인</a>
					</li>
					<li>
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
				<div class="ads-card">
					<div>
						<p>스탠다드 비즈니스</p>
						<p>#부담없는 가격</p>
						<p>#효과적인 광고</p>
						<ul>
							<li>매월 쿠폰 발행 1회</li>
							<li>해당 키워드게시판 상단노출</li>
							<li>매일 한번 광고효과가있는 게시물 작성가능</li>
						</ul>
					</div>
					<div>
						<p>20,000원/1개월</p>
					</div>
					<a href="<%= root %>/ads/join.jsp">가입하기</a>
				</div>
				<div class="ads-card">
					<div class="comment-box">
						<p class="title">스탠다드 비즈니스</p>
						<p class="hash">#부담없는 가격</p>
						<p class="hash">#효과적인 광고</p>
						<ul class="list">
							<li>매월 쿠폰 발행 1회</li>
							<li>해당 키워드게시판 상단노출</li>
							<li>매일 한번 광고효과가있는 게시물 작성가능</li>
						</ul>
					</div>
					<div class="price-box">
						<p class="price">180,000원/1년</p>
					</div>
					<a href="<%= root %>/ads/join.jsp" class="button">가입하기</a>
				</div>
			</div>
		</div>
	</div>
	
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
</body>
</html>
	

