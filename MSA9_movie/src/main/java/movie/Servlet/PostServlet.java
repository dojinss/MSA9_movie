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

@WebServlet("/post")
@MultipartConfig
public class PostServlet extends HttpServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
		PostService postService = new PostServiceImpl();
		FileService fileService = new FileServiceImpl();	
		String path = "C:/upload";
		Posts post = new Posts();
		Files file = new Files();
		String oldFileUrl = "";
		String newFileUrl = "";
		String content = "";
		int postNo = 0;
		boolean notice = false;
		List<String> filePaths = new ArrayList<>();
		
		for (Part part : request.getParts()) {
            String fieldName = part.getName();
            String value = request.getParameter(fieldName);
			// 일반 데이터
            if (part.getContentType() == null) {
				switch(fieldName){
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
                String fileName = part.getSubmittedFileName();
                File newfile = new File(path + "/" + fileName);
                part.write(newfile.getPath());
                filePaths.add(path + "/" + fileName);
				newFileUrl = newfile.getPath();
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
		response.getWriter().println(result);
	}
	
}
