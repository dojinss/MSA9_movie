package movie.Service;

import movie.DTO.User;

public interface UserService {
	
	// 회원 가입
	public int signup(User user);
	
	// 회원 조회
	public User select(String userId);
	
	// 회원 정보 수정
//	public int update(String userId);
	
	// 회원 삭제
//	public int delete(String userId);
	
}
