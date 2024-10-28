<%@page import="movie.DTO.Users"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="movie.Service.UserServiceImpl"%>
<%@page import="movie.Service.UserService"%>
<%@page import="movie.DTO.Primes"%>
<%@page import="movie.Service.PrimeServiceImpl"%>
<%@page import="com.fasterxml.jackson.databind.util.internal.PrivateMaxEntriesMap"%>
<%@page import="movie.Service.PrimeService"%>
<%@page import="movie.Service.AdServiceImpl"%>
<%@page import="movie.Service.AdService"%>
<%@page import="movie.DTO.Ads"%>
<%@page import="movie.Service.MovieServiceImpl"%>
<%@page import="movie.Service.MovieService"%>
<%@page import="movie.DTO.Movies"%>
<%@page import="movie.DTO.Files"%>
<%@page import="movie.Service.FileServiceImpl"%>
<%@page import="movie.Service.FileService"%>
<%@page import="movie.DTO.Posts"%>
<%@page import="movie.Service.PostServiceImpl"%>
<%@page import="movie.Service.PostService"%>
<%@page import="movie.DTO.Keywords"%>
<%@page import="java.util.ArrayList"%>
<%@page import="movie.DTO.Keywords"%>
<%@page import="com.alohaclass.jdbc.dto.PageInfo"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.alohaclass.jdbc.dto.Page"%>
<%@page import="movie.Service.KeywordServiceImpl"%>
<%@page import="movie.Service.KeywordService"%>
<%@ include file="/layout/jstl.jsp" %>
<%@ include file="/layout/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	// UTF-8 인코딩설정
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	response.setHeader("Content-Type","text/html;charset=UTF-8");
	
	int fileResult = 0;
	
	// 로그인한 유저 정보 가져오기
	Users user = (Users) session.getAttribute("loginUser");
	
	// Posts 객체 생성
	Posts post = new Posts();
	
	post.setUserNo(user.getUserNo()); // userNo 세팅
	
	// 파일 업로드 경로
	String path 					= uploadPath;
	
	// 넘어온 파라미터값 변수에 저장
	String content					= "";
	
	// 서비스 설정
	PostService postService 		= new PostServiceImpl();
	FileService fileService			= new FileServiceImpl();
	
	DiskFileUpload upload = new DiskFileUpload();
	
	upload.setSizeMax(10*1000*1000); 		// 10MB - 파일 최대 크기
	upload.setSizeThreshold( 4 * 1024 );	// 4MB	- 메모리상의 최대 크기
	upload.setRepositoryPath(path);			// 임시 저장 경로
	
	List<FileItem> items = upload.parseRequest(request);
	List<String> filePaths = new ArrayList<String>();
	Iterator params = items.iterator();
	while( params.hasNext() ) {
		FileItem item = (FileItem) params.next();
		
		// 일반 데이터
		if( item.isFormField() ) {
			String name = item.getFieldName();
			String value = item.getString("utf-8");
// 			out.println(name + " : " + value + "<br>");
			if(name.equals("content"))
				post.setContent(value);							// content 내용 post객체에 세팅
			if(name.equals("keywordNo") && !value.isEmpty())
				post.setKeywordNo(Integer.parseInt(value));		// keywordNo 키워드번호 post객체에 세팅
			if(name.equals("movieNo") && !value.isEmpty())
				post.setMovieNo(Integer.parseInt(value));		// keywordNo 키워드번호 post객체에 세팅
		}
		// 파일 데이터
		else {
			String fileFieldName = item.getFieldName();
			String fileName = item.getName();
			String contentType = item.getContentType();
			
			fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
			long fileSize = item.getSize();
// 			out.println(path+ "/" + fileName);
			File file = new File(path+ "/" + fileName);
			item.write(file);
			
			filePaths.add(path+ "/" + fileName);
			
// 			out.println("--------------------------------------------------");
// 			out.println("요청 파라미터 이름 : " + fileFieldName + "<br>");
// 			out.println("저장 파일 이름: " + fileName + "<br>");
// 			out.println("파일 컨텐츠 타입 : " + contentType + "<br>");
// 			out.println("파일 크기 : " + fileSize + "<br>");
		}
	}
	int postNo = postService.insertKey(post);
	out.println(postNo);
	if(postNo > 0){
		for(String str : filePaths){
			Files file = new Files();
			file.setFileUrl(str);
			file.setPostNo(postNo);
			fileResult = fileResult + fileService.insert(file);
		}
	}
	out.println(fileResult);
%>