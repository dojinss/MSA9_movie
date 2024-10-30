package movie.Service;

import java.util.List;

import java.util.Map;


import com.alohaclass.jdbc.dto.Page;
import com.alohaclass.jdbc.dto.PageInfo;

import movie.DTO.Users;

public interface UserService {
	
	// 회원 가입
	public int signup(Users user);
	
	// 회원 조회
	public Users select(String userId);
	public Users select(int userNo);
	// 회원 정보 수정
	public int update(String userId);
	public int update(Users user);
  
	// 회원 삭제
	public int delete(int userNo);
	
	// 로그인
	public Users login(Users user);	
	public PageInfo<Users> page(Page page); 
	

	
	public PageInfo<Users> page(PageInfo<Users> pageInfo, int searchCode); 
	public PageInfo<Users> page(); 
	public PageInfo<Users> page(Page page); 
	public PageInfo<Users> page(Page page, String keyword, List<String> searchOptions); 
	public PageInfo<Users> page(Page page, String keyword, List<String> searchOptions, Map<String, String> filterOptions);

}
