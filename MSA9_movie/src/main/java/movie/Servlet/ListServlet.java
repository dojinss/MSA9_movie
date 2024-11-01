package movie.Servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.alohaclass.jdbc.dto.Page;
import com.alohaclass.jdbc.dto.PageInfo;

import movie.Service.KeywordService;
import movie.Service.KeywordServiceImpl;
import movie.Service.MovieService;
import movie.Service.MovieServiceImpl;
import movie.Service.PostService;
import movie.Service.PostServiceImpl;
import movie.Service.ReplyService;
import movie.Service.ReplyServiceImpl;


/**
 * Servlet implementation class ListServlet
 */
@WebServlet("/List")
public class ListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String listType 		= request.getParameter("listType");
		String tableName 		= request.getParameter("tableName");
		String nowPage			= request.getParameter("nowPage");
		String serachOption		= request.getParameter("option");
		
		Page page = new Page();
		PageInfo<?> pageInfo = null;
		MovieService movieService 		= new MovieServiceImpl();
		PostService postService 		= new PostServiceImpl();
		ReplyService replyService 		= new ReplyServiceImpl();
		KeywordService keywordService 	= new KeywordServiceImpl();
		
		switch(tableName) {
			case "movies" 	: movieService.page(page, serachOption, null, null); break;
			case "posts" 	: break;
			case "replies" 	: break;
			case "keywords" : break;
		}
	}

}
