<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//UTF-8 인코딩설정
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	response.setHeader("Content-Type","text/html;charset=UTF-8");
	
	
	// 넘어온 파라미터값 변수에 저장
	int movieNo 		= Integer.parseInt( request.getParameter("movieNo") );
	String keywordNo	= request.getParameter("keywordNo");
	String type		 	= request.getParameter("type");

%>
<%-- 작성탭 --%>
<div class="post-container">
<form method="post" enctype="multipart/form-data" id="post-form" onsubmit="return false;">
<div class="post-write-wrap">
	<div id="drop">
	    <div class="comment">
	    	<p>이미지 파일을 드래그 앤 드롭 해주세요.</p>
	    </div>    
	    <div id="thumbnails"></div>
	</div>
	<div class="textarea-box">
		<textarea name="content" placeholder="내용작성(200글자 제한)" maxlength="200"></textarea>
		<button type="submit" id="post-form-submit">등록하기</button>
	</div>
</div>
<%
switch(type){
	case "movie" 	:
%>
	<input type="hidden" name="keywordNo" value="<%= keywordNo%>"/>
	<%break;
	case "keyword"	:
	%>
	<input type="hidden" name="movieNo" value="<%= movieNo%>"/>
<%	break;
}
%>
</form>
<div id="success-modal">
	<div id="success-post">등록 완료</div>
</div>
</div>