package movie.utils;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtils {
	
	// Bcryp 암호화 알고리즘으로 암호화
	public static String encoded(String pwd) {
		return BCrypt.hashpw(pwd, BCrypt.gensalt());
	}
	
	// 비밀번호 검증
	public static boolean check(String pwd, String epwd) {
		return BCrypt.checkpw(pwd, epwd);
	}
}
