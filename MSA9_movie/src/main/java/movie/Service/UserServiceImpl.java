package movie.Service;

import java.util.HashMap;
import java.util.Map;

import movie.DAO.UserDAO;
import movie.DTO.User;

public class UserServiceImpl implements UserService {

	UserDAO userDAO = new UserDAO();

	@Override
	public int signup(User user) {
		int result = 0;
		
		try {
			result = userDAO.insert(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if ( result == 0) {
			return 0;
		}
		return result;
	}

	@Override
	public User select(String userId) {
		Map<Object, Object> map = new HashMap<Object, Object>() {{
            put("user_id", userId);
        }};
        User user = null;
		try {
			userDAO.select(1);
			user = userDAO.selectBy(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

//	@Override
//	public int update(User user) {
//		int result = 0;
//		
//		result = userDAO.update(user);
//		return result;
//	}
//
//	@Override
//	public int delete(String userId) {
//		
//		return 0;
//	}
}
