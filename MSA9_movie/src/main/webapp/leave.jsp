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
	<%-- CSS 링크 파일 --%>
	<link rel="stylesheet" href="static/css/user.css">
	
</head>
<body>
	<jsp:include page="/layout/header.jsp" />
	<%-- [Contents] ######################################################### --%>
		
  		<div class="user-category">
  		<input id="tab-1" type="radio" name="tab" class="edit-in tab-radio" OnClick="window.location.href='action.php?value=1'"; >
  		<label for="tab-1" class="tab">회원 정보 수정</label>
  		<input id="tab-2" type="radio" name="tab" class="user-out tab-radio" checked >
  		<label for="tab-2" class="tab">회원 탈퇴</label>
		</div>
		
		
		
		<div class="user-leave">
 		 <div class="info-leave">
 		 <label for="leave" id="leave">회원 탈퇴</label>
		
		
	      <div class="info">
        <div class="group">
          <label for="user" class="label">이름</label>
          <input id="user" type="text" class="input">
        </div>
        <div class="group">
          <label for="pass" class="label">비밀번호</label>
          <input id="pass" type="password" class="input" data-type="password">
        </div>
        <div class="group">
          <label for="userbirth" class="label">생년월일</label>
          <input id="userbirth" type="date" class="input">
        </div>
        <div class="group">
          <label for="pass" class="label">이메일</label>
          <input id="pass" type="text" class="input">
        </div>
        
        
      </div>
              
        <div id="leave-btn">
          <button class="leave-btn" onclick="">탈퇴하기</button>
        </div>
        </div> <!-- 회원 탈퇴 끝 -->
    </div>
    

	
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	<%-- JS 링크 파일 --%>
	
</body>
</html>