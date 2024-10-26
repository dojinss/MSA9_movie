<%@page import="movie.DTO.Keywords"%>
<%@page import="movie.Service.KeywordServiceImpl"%>
<%@page import="movie.Service.KeywordService"%>
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
	KeywordService keywordService = new KeywordServiceImpl();
	int movieNo = 0;
	String title = "";
	String type = "";
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
			case "movieNo":
				System.out.println("결과는 : " +value);
				movieNo=Integer.parseInt(value);
				break;
			case "title":
				title=value;
				break;
			case "type":
				type=value;
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
	Keywords keyword = Keywords.builder()
			  .movieNo(movieNo)
			  .title(title)
			  .type(type)
			  .content(content)
			  .imageUrl(imageUrl)
			  .build()
			  ;
	int result = keywordService.insert(keyword);
	if(result==1){
		response.sendRedirect(root+"/admin/keyword/adminKeywordList.jsp?movieNo="+movieNo);
	}else{
		response.sendRedirect(root+"/admin/keyword/adminKeywordInsert.jsp?movieNo="+movieNo);
	}
%>