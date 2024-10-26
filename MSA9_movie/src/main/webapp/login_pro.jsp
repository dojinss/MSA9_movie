<%@page import="java.net.URLEncoder"%>
<%@page import="movie.Service.PersistenceLoginsServiceImpl"%>
<%@page import="movie.Service.PersistenceLoginsService"%>
<%@page import="movie.DTO.PersistenceLogins"%>
<%@page import="javax.servlet.http.Cookie"%>
<%@page import="movie.Service.UserServiceImpl"%>
<%@page import="movie.Service.UserService"%>
<%@page import="movie.DTO.Users"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 인코딩 세팅
	request.setCharacterEncoding("UTF-8");
	// 아이디 비밀번호 가져오기
	String userID = request.getParameter("userid");
	String userPWD = request.getParameter("password");
	
	// 로그인 요청
	Users user = Users.builder()
					  .userId(userID)
					  .userPwd(userPWD)
					  .build()
					  ;
	UserService userService = new UserServiceImpl();
	Users loginUser = userService.login(user);
	
	// 로그인 실패
	if( loginUser == null ) {
		// 에러코드를 들고 다시 로그인 페이지로
		response.sendRedirect( root + "/index.jsp?error=0");
		return;
	}
	
	// 로그인 성공
	String rememberID 		= request.getParameter("remember-id");
	Cookie cookieRememberID = new Cookie("rememberID","");
	Cookie cookieUserid		= new Cookie("userID","");
	
	// 아이디 저장 체크 시 - 값 : on
	if( rememberID != null && rememberID.equals("on")) {
		// 쿠키 생성
		cookieRememberID.setValue( URLEncoder.encode(rememberID, "UTF-8") );
		cookieUserid.setValue( URLEncoder.encode(userID, "UTF-8") );
	}
	// [end] 로그인 성공
	
	// 자동 로그인
	String rememberMe = request.getParameter("remember-me");
	Cookie cookieRememberMe	= new Cookie("rememberMe","");
	Cookie cookieToken = new Cookie("token", "");
	// 쿠키 설정
	cookieRememberMe.setPath("/");
	cookieToken.setPath("/");
	// 쿠키 만료시간 설정 - 7일 (/초)
	cookieRememberMe.setMaxAge(60*60*24*7); 
	cookieToken.setMaxAge(60*60*24*7);
	
	// 자동 로그인 체크 여부
	if( rememberMe != null && rememberMe.equals("on") ) {
		// 자동 로그인 체크 시
		// - 토큰 발행
		PersistenceLoginsService loginsService = new PersistenceLoginsServiceImpl(); 
		PersistenceLogins plogin = loginsService.refresh(loginUser.getUserNo());
		String token = null;
		if( plogin != null )
			token = plogin.getToken();
		// - 쿠키 생성
		cookieRememberMe.setValue( URLEncoder.encode( rememberMe, "UTF-8" ) );
		cookieToken.setValue( URLEncoder.encode( token, "UTF-8" ) );
	}
	
	// [end]자동 로그인
	
	// 응답에 쿠키 등록
	response.addCookie(cookieRememberID);
	response.addCookie(cookieUserid);
	response.addCookie(cookieRememberMe);
	response.addCookie(cookieToken);
	
	if( loginUser != null ) {
		// 세션에 사용자 정보 등록
		session.setAttribute("loginID", loginUser.getUserId());
		session.setAttribute("loginUser", loginUser);
		// 메인 화면으로 리다이렉트
		response.sendRedirect( root + "/");
	}
	
%>