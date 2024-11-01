package movie.filter;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.annotation.WebInitParam;
import jakarta.servlet.http.HttpFilter;


/**
 * Servlet Filter implementation class EncodingFilter
 */
@WebFilter(
		urlPatterns = { "/*" }, 	// 모든 경로 URL 매핑
		initParams = { 
				@WebInitParam(name = "encoding", value = "UTF-8", description = "인코딩 설정값")
		})
public class EncodingFilter extends HttpFilter implements Filter {
    
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private FilterConfig filterConfig = null;
	private String encoding;
	
    public EncodingFilter() {
        super();
    }

    public void init(FilterConfig filterConfig) throws ServletException {
    	this.filterConfig = filterConfig;
    	encoding = filterConfig.getInitParameter("encoding");
    }

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		System.out.println("인코딩 필터 : " + encoding);
		
		request.setCharacterEncoding(encoding);
		response.setCharacterEncoding(encoding);
		
		chain.doFilter(request, response);
	}


	public void destroy() {
	
	}
}
