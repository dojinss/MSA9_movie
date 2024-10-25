<%@page import="movie.DTO.Keywords"%>
<%@page import="movie.Service.KeywordServiceImpl"%>
<%@page import="movie.Service.KeywordService"%>
<%@page import="java.sql.Date"%>
<%@page import="java.time.LocalDate"%>
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
	KeywordService keywordService = new KeywordServiceImpl();

	String path = moviePath;

	DiskFileUpload upload = new DiskFileUpload();
	
	upload.setSizeMax(10*1000*1000*1000); 		// 100MB - 파일 최대 크기
	upload.setSizeThreshold( 4 * 1024 );	// 4MB	- 메모리상의 최대 크기
	upload.setRepositoryPath(path);			// 임시 저장 경로
	Keywords keyword = null;
	List<FileItem> items = upload.parseRequest(request);
	Iterator params = items.iterator();
	while( params.hasNext() ) {
		FileItem item = (FileItem) params.next();
		
		// 일반 데이터
		if( item.isFormField() ) {
			String name = item.getFieldName();
			String value = item.getString("utf-8");
			switch(name){
			case "keywordNo":
				keyword = keywordService.select(Integer.parseInt(value));
				break;
			case "title":
				keyword.setTitle(value);
				break;
			case "type":
				keyword.setType(value);
				break;
			case "content":
				keyword.setContent(value);
				break;
			}
		}
		// 파일 데이터
		else {
			if(item.getName().length()>0){
				String fileName = UUID.randomUUID() + "_" + item.getName();
				String contentType = item.getContentType();
				fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);
				long fileSize = item.getSize();
				
				File file = new File(path+ "/" + fileName);
				File oldfile = new File(keyword.getImageUrl());
				oldfile.delete();
				item.write(file);
				keyword.setImageUrl(file.getPath());
			}
		}
	}
	keyword.setUpdDate(Date.valueOf(LocalDate.now()));
	
	int result = keywordService.update(keyword);
	if(result > 0){
		response.sendRedirect(root+"/admin/keyword/adminKeywordList.jsp");
	}else{
		response.sendRedirect(root+"/admin/keyword/adminKeywordUpdate.jsp?keywordNo="+keyword.getMovieNo());
	}
%>