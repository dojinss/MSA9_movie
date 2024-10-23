package movie.DTO;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Users {

	private int userNo;
	private int ruleNo;					// 1: 일반, 2: 광고주, 3: 관리자
	private String userId;
	private String userPwd;
	private String email;
	private String profileUrl;
	private boolean enabled;
	private Date regDate;
	private Date updDate;
	
}	
