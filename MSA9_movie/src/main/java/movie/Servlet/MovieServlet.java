package movie.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import movie.DTO.Files;
import movie.DTO.Movies;
import movie.DTO.Posts;
import movie.DTO.Users;
import movie.Service.FileService;
import movie.Service.FileServiceImpl;
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

@WebServlet("/movie")
@MultipartConfig
public class MovieServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
		MovieService movieService = new MovieServiceImpl();
		String title = "";
		boolean notice = false;
		String cate = "";
		String cast = "";
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
                String fileName = part.getSubmittedFileName();
                File file = new File(path + "/" + fileName);
                part.write(file.getPath());
                filePaths.add(path + "/" + fileName);
				
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
		if(result > 0){
			response.sendRedirect(root+"/admin/movie/adminMovieList.jsp");
		}else{
			response.sendRedirect(root+"/admin/movie/adminMovieInsert.jsp");
		}
    }
	@Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
		MovieService movieService = new MovieServiceImpl();

		String root = request.getContextPath();
		String path = "C:/upload";			// 임시 저장 경로
		Movies movie = new Movies();
		
		String imgUrl = "";
		String title = "";
		String cate = "";
		String cast = "";
		String content = "";
		int movieNo = 0;
		boolean notice = false;
		
		List<String> filePaths = new ArrayList<>();
		for (Part part : request.getParts()) {
            String fieldName = part.getName();
            String value = request.getParameter(fieldName);
			// 일반 데이터
            if (part.getContentType() == null) {
				switch(fieldName){
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
//				if(value != null && value.length()>0){
	                String fileName = part.getSubmittedFileName();
	                File file = new File(path + "/" + fileName);
	                part.write(file.getPath());
	                filePaths.add(path + "/" + fileName);
					movie.setImageUrl(file.getPath());
//				}
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
		int result = movieService.update(movie);
		response.getWriter().println(result);
	}
	
}
