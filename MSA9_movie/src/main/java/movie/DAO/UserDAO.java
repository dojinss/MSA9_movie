package movie.DAO;

import java.sql.ResultSet;

import com.alohaclass.jdbc.dao.BaseDAOImpl;

import movie.DTO.Users;

public class UserDAO extends BaseDAOImpl<Users>{

	@Override
	public Users map(ResultSet rs) throws Exception {
		Users user = new Users();
		user.setUserNo(rs.getInt("user_no"));
		user.setRuleNo(rs.getInt("rule_no"));
		user.setUserId(rs.getString("user_id"));
		user.setUserPwd(rs.getString("user_pwd"));
		user.setEmail(rs.getString("email"));
		user.setProfileUrl(rs.getString("profile_url"));
		user.setEnabled(rs.getBoolean("enabled"));
		user.setRegDate(rs.getDate("reg_date"));
		user.setUpdDate(rs.getDate("upd_date"));
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
