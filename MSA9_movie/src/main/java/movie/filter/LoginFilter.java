package movie.filter;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import movie.DTO.Tokens;
import movie.DTO.Users;
import movie.Service.TokenService;
import movie.Service.TokenServiceImpl;
import movie.Service.UserService;
import movie.Service.UserServiceImpl;

@WebFilter(description = "자동 로그인 등, 인증 처리 필터", urlPatterns = { "/*" })
public class LoginFilter extends HttpFilter implements Filter {
    
	TokenService loginService;
	UserService userService;
	public void init(FilterConfig fConfig) throws ServletException {
		loginService = new TokenServiceImpl();
		userService = new UserServiceImpl();
	}
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// 쿠키 확인
		// 1. 자동로그인 여부
		// 2. 인증 토큰
		
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		Cookie[] cookies = httpRequest.getCookies();
		
		String rememberMe = null;
		String token = null;
		
		if( cookies != null) {
			for (Cookie cookie : cookies) {
				String cookieName = cookie.getName();
				String cookieValue = URLDecoder.decode( cookie.getValue(), "UTF-8");
				switch (cookieName) {
					case "rememberMe"	: rememberMe = cookieValue;  break;
					case "token"		: token = cookieValue;  break;
				}
			}
		}
		
		
		
		// 로그인 여부 확인
		HttpSession session = httpRequest.getSession();
		String loginID = (String) session.getAttribute("loginID");
		Users loginUser = (Users) session.getAttribute("loginUser");
		System.out.println("LoginFilter...");
		System.out.println("rememberMe : " + rememberMe);
		System.out.println("token : " + token);
		
		// 이미 로그인 됨
		if( loginID != null && loginUser != null ) {
			chain.doFilter(request, response);
			System.out.println("로그인된 사용자 : " + loginID);
			return;
		}
		// 자동 로그인 & 토큰 ok
		if( rememberMe != null && token != null ) {
			Tokens plogin = loginService.selectByToken(token);
			
			// 토큰이 존재하고 유효(만료시간)한지 확인
			if( plogin != null && loginService.isValid(token) ) {
				int userNo= plogin.getUserNo();
				loginUser = userService.select(userNo); 
				// 로그인 처리
				session.setAttribute( "loginID" ,  loginUser.getUserId() );
				session.setAttribute( "loginUser" , loginUser );
			}
		}
		chain.doFilter(request, response);
	}

	
	
	
	public LoginFilter() {
		super();
    }
    public void destroy() {
    }
}
