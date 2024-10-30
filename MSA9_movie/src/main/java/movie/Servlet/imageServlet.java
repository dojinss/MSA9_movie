package movie.Servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class imageServlet
 */
@WebServlet("/images")
public class imageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public imageServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("이미지 로딩...");
		// 파일명을 준비
		String fileName = request.getParameter("fileName");
		// 파일명 유효성 검사
		if ( fileName == null || fileName.isEmpty() ) {
			System.out.println("파일명이 지정되지 않았습니다.");
			return;
		}
		
		// 파일 경로
		String imgDir = "C:\\upload";
		String imgFilepath = imgDir + File.separator + fileName;
		
		// 이미지 확장자	: (jpeg, jpg, png, gif, webp)
		String ext = imgFilepath.substring( imgFilepath.lastIndexOf(".")+1 ).toLowerCase();
		// 이미지 컨텐츠 타입 image/jpeg, image/png
		String contentType;
		switch (ext) {
			case "jpg": 
			case "jpeg": 
				contentType = "image/jpeg";
				break;
			case "png": 
				contentType = "image/png";
				break;
			case "gif": 
				contentType = "image/gif";
				break;
			case "webp": 
				contentType = "image/webp";
				break;
			default:
				System.out.println("이미지 형식이 아닙니다.");
				return;
		}
		// 응답 헤더 컨텐츠 타입 지정
		response.setContentType(contentType);
		
		File file = new File(imgFilepath);
		
		// 파일 존재 여부
		if (!file.exists()) {
			System.out.println("파일이 존재하지 않습니다.");
			return;
		}
		
		// try-with-resource (Auto Close)
		try (
			FileInputStream fis = new FileInputStream(file);
			ServletOutputStream sos = response.getOutputStream();){
			
			byte[] buffer = new byte[4096];
			int data = -1;
			while( (data = fis.read(buffer)) != -1  ) {
				sos.write(buffer, 0, data);
			}
			System.out.println("이미지 전송 완료.");
		} catch(Exception e) {
			System.err.println("이미지 파일 전송 중 에러 발생");
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
