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
  		<input id="tab-1" type="radio" name="tab" class="edit-in tab-radio" onclick="location.href='infoUpdate.jsp'" >
  		<label for="tab-1" class="tab">회원 정보 수정</label>
  		<input id="tab-2" type="radio" name="tab" class="user-out tab-radio" checked >
  		<label for="tab-2" class="tab">회원 탈퇴</label>
		</div>
		
		 
		
	<form class="user-leave" onsubmit="return confirmLeave()">
 		<div class="info-leave">
 		 <label for="leave" id="leave">회원 탈퇴</label>
		
		
	      <div class="info">
        <div class="group">
          <label for="userid" class="label">아이디</label>
          <input id="userid"  type="text" class="input" name="id" autofocus >
          <!-- 입력창 오류 경고문 -->      
           <div id="wrongId"></div>
           <div id="idSuccess"></div>
           <div id="idFalse"></div>
        </div>
        
        <div class="group">
          <label for="userpwd" class="label">비밀번호</label>
          <input id="userpwd" type="password" class="input">
          <div id="pwdError"></div>
        </div>
        
        <div class="group">
          <label for="name" class="label">이름</label>
          <input id="name" type="text" class="input" >
          <div id="nameError"></div>
        </div>
        
        <div class="group">
          <label for="mail"  class="label">이메일</label>
          <input id="mail" type="email" class="input" name="email" placeholder="'@' 포함하여 입력해 주세요">
          <div id="emailError"></div>
        </div>
      </div>
              
        <div id="leave-btn">
          <button type="submit" class="leave-btn" >탈퇴하기</button>
        </div>
        </div> <!-- 회원 탈퇴 끝 -->
    </form>
    

	
	<%-- [Contents] ######################################################### --%>
	<jsp:include page="/layout/footer.jsp" />
	<jsp:include page="/layout/script.jsp" />
	<%-- JS 링크 파일 --%>
	<script src="static/js/user.js"></script>
	<script>
	
// 	function confirmLeave() {
// 	    const confirmed = confirm("탈퇴하시겠습니까?");
// 	    if (confirmed) {
// 	      alert("탈퇴가 완료되었습니다.");
// 	      return true;
// 	    } else {
// 	      alert("탈퇴가 취소되었습니다.");
// 	      return false; 
// 	    }
// 	  } 

	
	/* 마우스 올렸을때 이벤트 */
		 $('.leave-btn').on('mouseover', function() {
	       $(this).css('color', 'white')
	       $(this).css('background-color', '#cba50fad')
			})
		 .on('mouseout', function() {    
	        $(this).css('color', 'white')
	        $(this).css('background-color', 'var(--sub-color)')
	    })
	
	
		
	</script>
</body>
</html>