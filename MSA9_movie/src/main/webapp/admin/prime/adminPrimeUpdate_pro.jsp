<%@page import="java.sql.Date"%>
<%@page import="movie.DTO.Primes"%>
<%@page import="movie.Service.PrimeServiceImpl"%>
<%@page import="movie.Service.PrimeService"%>
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
	PrimeService primeService = new PrimeServiceImpl();

	String path = uploadPath;

	DiskFileUpload upload = new DiskFileUpload();
	
	upload.setSizeMax(10*1000*1000*1000); 		// 100MB - 파일 최대 크기
	upload.setSizeThreshold( 4 * 1024 );		// 4MB	- 메모리상의 최대 크기
	upload.setRepositoryPath(path);				// 임시 저장 경로
	Primes prime = new Primes();
	List<FileItem> items = upload.parseRequest(request);
	Iterator params = items.iterator();
	String primeName = "";
	String oldImageUrl = "";
	String newImageUrl = "";
	String number = "";
	Date startTime = null;
	Date endTime = null;
	String addr = "";
	int primeNo = 0;
	boolean notice = false;
	while( params.hasNext() ) {
		FileItem item = (FileItem) params.next();
		// 일반 데이터
		if( item.isFormField() ) {
			String name = item.getFieldName();
			String value = item.getString("utf-8");
			out.println(name + " : " + value + "<br>");
			switch(name){
			case "primeNo":
				primeNo = Integer.parseInt(value);
				prime = primeService.selectByPrimeNo(primeNo);
				break;
			case "name":
				primeName = value;
				break;
			case "imageUrl":
				oldImageUrl = value;
				break;
			case "number":
				number = value;
				break;
			case "addr":
				addr = value;
				break;
			case "startTime":
				startTime = Date.valueOf(value);
				break;
			case "endTime":
				endTime = Date.valueOf(value);
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
	prime.setName(primeName);
	prime.setNumber(number);
	prime.setAddr(addr);
	prime.setStartTime(startTime);
	prime.setEndTime(endTime);
	
	if(newImageUrl.equals("")){
		prime.setImageUrl(oldImageUrl);
	}else{
		File oldfile = new File(oldImageUrl);
		oldfile.delete();
		prime.setImageUrl(newImageUrl);
	}
	int result = primeService.update(prime);
	out.println(result);
	if(result > 0){
		response.sendRedirect(root+"/admin/prime/adminPrimeList.jsp");
	}else{
		response.sendRedirect(root+"/admin/prime/adminPrimeUpdate.jsp?primeNo="+prime.getPrimeNo());
	}
%>