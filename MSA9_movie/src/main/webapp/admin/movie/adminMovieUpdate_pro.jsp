<%@page import="java.util.Date"%>
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
<%@ include file="/admin/layout/login.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MovieService movieService = new MovieServiceImpl();

	String path = uploadPath;

	DiskFileUpload upload = new DiskFileUpload();
	
	upload.setSizeMax(10*1000*1000*1000); 		// 100MB - 파일 최대 크기
	upload.setSizeThreshold( 4 * 1024 );		// 4MB	- 메모리상의 최대 크기
	upload.setRepositoryPath(path);				// 임시 저장 경로
	Movies movie = new Movies();
	List<FileItem> items = upload.parseRequest(request);
	Iterator params = items.iterator();
	String imgUrl = "";
	String title = "";
	String cate = "";
	String cast = "";
	String content = "";
	int movieNo = 0;
	boolean notice = false;
	while( params.hasNext() ) {
		FileItem item = (FileItem) params.next();
		// 일반 데이터
		if( item.isFormField() ) {
			String name = item.getFieldName();
			String value = item.getString("utf-8");
			out.println(name + " : " + value + "<br>");
			switch(name){
			case "movieNo":
				movieNo = Integer.parseInt(value);
				break;
			case "title":
				title = value;
				break;
			case "notice":
				if(value.equals("1"))
					notice = true;
				break;
			case "cate":
				cate = value;
				break;
			case "cast":
				cast = value;
				break;
			case "content":
				content = value;
				break;
			case "imageUrl":
				imgUrl = value;
				break;
			}
		}
		// 파일 데이터
		else {
			if(item.getName().length()>0){
				String fileName = item.getName();
				String contentType = item.getContentType();
				fileName = UUID.randomUUID() + "_" + fileName.substring(fileName.lastIndexOf("\\") + 1);
				long fileSize = item.getSize();
				File file = new File(path+ "/" + fileName);
				item.write(file);
				movie.setImageUrl(file.getPath());
			}
		}
	}
	if(movie.getImageUrl()==null){
		movie.setImageUrl(imgUrl);
	}else{
		File file = new File(imgUrl);
		file.delete();
	}
	movie.setMovieNo(movieNo);
	movie.setNotice(notice);
	movie.setTitle(title);
	movie.setCate(cate);
	movie.setCast(cast);
	movie.setContent(content);
	movie.setUpdDate( new Date() );
	out.println(movie);
	int result = movieService.update(movie);
	out.println(result);
	if(result > 0){
		response.sendRedirect(root+"/admin/movie/adminMovieList.jsp");
	}else{
		response.sendRedirect(root+"/admin/movie/adminMovieUpdate.jsp?movieNo="+movie.getMovieNo());
	}
%>