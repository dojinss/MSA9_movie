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
public class User {

	private int userNo;
	private int ruleNo;					// 1: 일반, 2: 광고주, 3: 관리자
	private String userId;
	private String userPwd;
	private String userEmail;
	private String userProfileUrl;
	private boolean userEnabled;
	private Date userRegDate;
	private Date userUpdDate;
	
}	
