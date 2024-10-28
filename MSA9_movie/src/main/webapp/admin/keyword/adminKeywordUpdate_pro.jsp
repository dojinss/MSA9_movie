<%@page import="java.util.Date"%>
<%@page import="movie.DTO.Keywords"%>
<%@page import="movie.Service.KeywordServiceImpl"%>
<%@page import="movie.Service.KeywordService"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.UUID"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@ include file="/admin/layout/login.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	KeywordService keywordService = new KeywordServiceImpl();

	String path = uploadPath;

	DiskFileUpload upload = new DiskFileUpload();
	
	upload.setSizeMax(10*1000*1000*1000); 		// 100MB - 파일 최대 크기
	upload.setSizeThreshold( 4 * 1024 );	// 4MB	- 메모리상의 최대 크기
	upload.setRepositoryPath(path);			// 임시 저장 경로
	Keywords keyword = new Keywords();
	int movieNo=0;
	int keywordNo=0;
	String title ="";
	String type="";
	String content="";
	String imgUrl="";
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
				keywordNo = Integer.parseInt(value);
				break;
			case "movieNo":
				movieNo = Integer.parseInt(value);
				break;
			case "title":
				title = value;
				break;
			case "type":
				type = value;
				break;
			case "content":
				content = value;
				break;
			case "imgUrl":
				imgUrl = value;
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
				item.write(file);
				keyword.setImageUrl(file.getPath());
			}
		}
	}
	
	if(keyword.getImageUrl()==null){
		keyword.setImageUrl(imgUrl);
	}else{
		File file = new File(imgUrl);
		file.delete();
	}
	
	keyword.setKeywordNo(keywordNo);
	keyword.setMovieNo(movieNo);
	keyword.setTitle(title);
	keyword.setType(type);
	keyword.setContent(content);
	keyword.setUpdDate(new Date());
	
	int result = keywordService.update(keyword);
	if(result > 0){
		response.sendRedirect(root+"/admin/keyword/adminKeywordList.jsp?movieNo="+keyword.getMovieNo());
	}else{
		response.sendRedirect(root+"/admin/keyword/adminKeywordUpdate.jsp?keywordNo="+keyword.getKeywordNo());
	}
%>