<%@page import="java.util.UUID"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="movie.Service.MovieServiceImpl"%>
<%@page import="movie.Service.MovieService"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="movie.DTO.Movies"%>
<%@ include file="/admin/layout/login.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MovieService movieService = new MovieServiceImpl();
	String title = "";
	boolean notice = false;
	String cate = "";
	String cast = "";
	String content = "";
	String imageUrl = "";

	String path = moviePath;

	DiskFileUpload upload = new DiskFileUpload();
	
	upload.setSizeMax(10*1000*1000*1000); 		// 100MB - 파일 최대 크기
	upload.setSizeThreshold( 4 * 1024 );	// 4MB	- 메모리상의 최대 크기
	upload.setRepositoryPath(path);			// 임시 저장 경로
	
	List<FileItem> items = upload.parseRequest(request);
	Iterator params = items.iterator();
	while( params.hasNext() ) {
		FileItem item = (FileItem) params.next();
		
		// 일반 데이터
		if( item.isFormField() ) {
			String name = item.getFieldName();
			String value = item.getString("utf-8");
			switch(name){
			case "title":
				title=value;
				break;
			case "notice":
				if(value.equals("1")){
					notice=true;
				}
				break;
			case "cate":
				cate=value;
				break;
			case "cast":
				cast=value;
				break;
			case "content":
				content=value;
				break;
			}
		}
		// 파일 데이터
		else {
			String fileName = UUID.randomUUID() + "_" + item.getName();
			String contentType = item.getContentType();
			fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
			long fileSize = item.getSize();
			
			File file = new File(path+ "/" + fileName);
			item.write(file);
			
			imageUrl = file.getPath();
		}
	}
	Movies movie = Movies.builder()
			  .title(title)
			  .notice(notice)
			  .cate(cate)
			  .cast(cast)
			  .content(content)
			  .imageUrl(imageUrl)
			  .build()
			  ;
	int result = movieService.insert(movie);
	if(result==1){
		response.sendRedirect(root+"/admin/movie/adminMovieList.jsp");
	}else{
		response.sendRedirect(root+"/admin/movie/adminMovieInsert.jsp");
	}
%>