package movie.DAO;

import java.sql.ResultSet;

import com.alohaclass.jdbc.dao.BaseDAOImpl;

import movie.DTO.User;

public class UserDAO extends BaseDAOImpl<User>{

	@Override
	public User map(ResultSet rs) throws Exception {
		User user = new User();
		user.setUserNo(rs.getInt("user_no"));
		user.setRuleNo(rs.getInt("rule_no"));
		user.setUserId(rs.getString("user_id"));
		user.setUserPwd(rs.getString("user_pwd"));
		user.setUserEmail(rs.getString("user_email"));
		user.setUserProfileUrl(rs.getString("user_profile_url"));
		user.setUserEnabled(rs.getBoolean("user_enabled"));
		user.setUserEnabled(rs.getBoolean("user_enabled"));
		user.setUserRegDate(rs.getDate("user_reg_date"));
		user.setUserUpdDate(rs.getDate("user_upd_date"));
		return user;
	}

	@Override
	public String pk() {
		return "user_no";
	}

	@Override
	public String table() {
		return "users";
	}
	
}
