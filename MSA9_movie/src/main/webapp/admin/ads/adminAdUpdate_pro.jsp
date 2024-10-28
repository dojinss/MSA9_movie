<%@page import="movie.DTO.Ads"%>
<%@page import="movie.Service.AdServiceImpl"%>
<%@page import="movie.Service.AdService"%>
<%@page import="java.sql.Date"%>
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
	AdService adService = new AdServiceImpl();

	String path = uploadPath;

	DiskFileUpload upload = new DiskFileUpload();
	
	upload.setSizeMax(10*1000*1000*1000); 		// 100MB - 파일 최대 크기
	upload.setSizeThreshold( 4 * 1024 );		// 4MB	- 메모리상의 최대 크기
	upload.setRepositoryPath(path);				// 임시 저장 경로
	Ads ad = new Ads();
	List<FileItem> items = upload.parseRequest(request);
	Iterator params = items.iterator();
	String oldImageUrl = "";
	String newImageUrl = "";
	int adNo = 0;
	boolean notice = false;
	while( params.hasNext() ) {
		FileItem item = (FileItem) params.next();
		// 일반 데이터
		if( item.isFormField() ) {
			String name = item.getFieldName();
			String value = item.getString("utf-8");
			out.println(name + " : " + value + "<br>");
			switch(name){
			case "adNo":
				adNo = Integer.parseInt(value);
				ad = adService.select(adNo);
				break;
			case "content":
				oldImageUrl = value;
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
				File newfile = new File(path+ "/" + fileName);
				item.write(newfile);
				newImageUrl = newfile.getPath();
			}
		}
	}
	
	if(newImageUrl.equals("")){
		ad.setContent(oldImageUrl);
	}else{
		File oldfile = new File(oldImageUrl);
		oldfile.delete();
		ad.setContent(newImageUrl);
	}
	int result = adService.update(ad);
	out.println(result);
	if(result > 0){
		response.sendRedirect(root+"/admin/ads/adminAdList.jsp");
	}else{
		response.sendRedirect(root+"/admin/ads/adminAdUpdate.jsp?adNo="+ad.getAdNo());
	}
%>