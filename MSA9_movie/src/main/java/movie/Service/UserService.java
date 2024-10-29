package movie.Service;

import movie.DTO.Users;

public interface UserService {
	
	// 회원 가입
	public int signup(Users user);
	
	// 회원 조회
	public Users select(String userId);
	public Users select(int userNo);
	// 회원 정보 수정
	public int update(Users user);
	
	// 회원 삭제
	public int delete(int userNo);
	
	// 로그인
	public Users login(Users user);	
	
}
