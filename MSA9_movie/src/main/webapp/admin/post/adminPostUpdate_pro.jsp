<%@page import="movie.Service.FileServiceImpl"%>
<%@page import="movie.Service.FileService"%>
<%@page import="movie.DTO.Files"%>
<%@page import="movie.DTO.Posts"%>
<%@page import="movie.Service.PostServiceImpl"%>
<%@page import="movie.Service.PostService"%>
<%@page import="java.util.Date"%>
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
	PostService postService = new PostServiceImpl();
	FileService fileService = new FileServiceImpl();	

	String path = uploadPath;

	DiskFileUpload upload = new DiskFileUpload();
	
	upload.setSizeMax(10*1000*1000*1000); 		// 100MB - 파일 최대 크기
	upload.setSizeThreshold( 4 * 1024 );		// 4MB	- 메모리상의 최대 크기
	upload.setRepositoryPath(path);				// 임시 저장 경로
	Posts post = new Posts();
	Files file = new Files();
	List<FileItem> items = upload.parseRequest(request);
	Iterator params = items.iterator();
	String oldFileUrl = "";
	String newFileUrl = "";
	String content = "";
	int postNo = 0;
	boolean notice = false;
	while( params.hasNext() ) {
		FileItem item = (FileItem) params.next();
		// 일반 데이터
		if( item.isFormField() ) {
			String name = item.getFieldName();
			String value = item.getString("utf-8");
			out.println(name + " : " + value + "<br>");
			switch(name){
			case "postNo":
				postNo = Integer.parseInt(value);
				post = postService.selectByPostNo(postNo);
				break;
			case "content":
				content = value;
				break;
			case "fileUrl":
				oldFileUrl = value;
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
				newFileUrl = newfile.getPath();
			}
		}
	}
	post.setContent(content);
	post.setUpdDate( new Date() );
	
	file = fileService.selectByPostNo(post.getPostNo());
	if(newFileUrl.equals("")){
		file.setFileUrl(oldFileUrl);
	}else{
		File oldfile = new File(oldFileUrl);
		oldfile.delete();
		file.setFileUrl(newFileUrl);
		fileService.update(file);
	}
	int result = postService.update(post);
	out.println(result);
	if(result > 0){
		response.sendRedirect(root+"/admin/post/adminPostList.jsp");
	}else{
		response.sendRedirect(root+"/admin/post/adminPostUpdate.jsp?postNo="+post.getPostNo());
	}
%>