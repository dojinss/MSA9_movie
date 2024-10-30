<%@page import="movie.DTO.Users"%>
<%@page import="movie.DTO.Posts"%>
<%@page import="movie.Service.UserServiceImpl"%>
<%@page import="movie.Service.UserService"%>
<%@page import="movie.Service.PostServiceImpl"%>
<%@page import="movie.Service.PostService"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	// UTF-8 인코딩설정
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	response.setHeader("text/html", "charset=UTF-8");
	
	// 넘어온 파라미터값 변수에 저장
	int postNo	= Integer.parseInt( request.getParameter("postNo") );
	
	// 서비스 설정
	PostService postService = new PostServiceImpl();
	UserService userService = new UserServiceImpl();
	
	// 게시글 정보 조회
	Posts post = postService.selectByPostNo(postNo);
	
	
	// 게시글 작성자 정보 가져오기
	Users user = userService.select(post.getUserNo());
	
	// 로그인 유저 정보 가져오기
	Users loginUser = (Users) session.getAttribute("loginUser");
	
	// 로그인 유저와 작성자가 일치하는지 판별
	boolean userCheck = (user.getUserNo() == loginUser.getUserNo());
	int result = 0;
	
	// JSTL 변수 지정
	if(userCheck){
		result = postService.deleteByPostNo(postNo);
	}
	out.println(result);
%>










