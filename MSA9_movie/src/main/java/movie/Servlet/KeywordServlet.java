package movie.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import movie.DTO.Files;
import movie.DTO.Keywords;
import movie.DTO.Movies;
import movie.DTO.Posts;
import movie.DTO.Users;
import movie.Service.FileService;
import movie.Service.FileServiceImpl;
import movie.Service.KeywordService;
import movie.Service.KeywordServiceImpl;
import movie.Service.MovieService;
import movie.Service.MovieServiceImpl;
import movie.Service.PostService;
import movie.Service.PostServiceImpl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.fileupload.DiskFileUpload;

@WebServlet("/keyword")
@MultipartConfig
public class KeywordServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
		KeywordService keywordService = new KeywordServiceImpl();
		int movieNo = 0;
		String title = "";
		String type = "";
		String content = "";
		String imageUrl = "";

		String root = request.getContextPath();
		String path = "C:/upload";


		List<String> filePaths = new ArrayList<>();
		
		for (Part part : request.getParts()) {
            String fieldName = part.getName();
            String value = request.getParameter(fieldName);
			// 일반 데이터
            if (part.getContentType() == null) {
				switch(fieldName){
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
                String fileName = part.getSubmittedFileName();
                File file = new File(path + "/" + fileName);
                part.write(file.getPath());
                filePaths.add(path + "/" + fileName);
				
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
		
    }
	@Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
		KeywordService keywordService = new KeywordServiceImpl();
		Keywords keyword = new Keywords();
		int movieNo=0;
		int keywordNo=0;
		String title ="";
		String type="";
		String content="";
		String imgUrl="";
		String path = "C:/upload";
		
		List<String> filePaths = new ArrayList<>();
		
		for (Part part : request.getParts()) {
            String fieldName = part.getName();
            String value = request.getParameter(fieldName);
			// 일반 데이터
            if (part.getContentType() == null) {
				switch(fieldName){
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
	                String fileName = part.getSubmittedFileName();
	                File file = new File(path + "/" + fileName);
	                part.write(file.getPath());
	                filePaths.add(path + "/" + fileName);
					keyword.setImageUrl(file.getPath());
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
		if(result > 0) {
			response.getWriter().println(movieNo);
		}
	}
	
}
