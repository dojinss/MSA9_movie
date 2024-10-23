package movie.Service;

import java.util.HashMap;
import java.util.Map;


import movie.DAO.PostDAO;
import movie.DAO.ReplyDAO;
import movie.DAO.UserDAO;
import movie.DTO.Posts;

public class PostServiceImpl implements PostService {

	PostDAO postDAO = new PostDAO();
	UserDAO userDAO = new UserDAO();
	ReplyDAO replyDAO = new ReplyDAO();
	
	@Override
	public int insert(Posts post) {
		int result = 0;
		try {
			result = postDAO.insert(post);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(result > 0) 	System.out.println("게시글 작성 성공.");
		else			System.out.println("게시글 작성 실패.");
		return result;
	}
	@Override
	public Posts selectByUserNo(int userNo) {
		Map<Object, Object> map = new HashMap<Object, Object>() {{
            put("user_no", userNo);
        }};
        Posts post = null;
        try {
        	postDAO.select(1);
			post = postDAO.selectBy(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return post;
	}
	@Override
	public Posts selectByPostNo(int postNo) {
		Map<Object, Object> map = new HashMap<Object, Object>() {{
            put("post_no", postNo);
        }};
        Posts post = null;
        try {
        	postDAO.select(1);
			post = postDAO.selectBy(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return post;
	}
	@Override
	public int update(Posts post) {
		int result = 0;
		try {
			result = postDAO.update(post);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * Delete ~ No (int ~No)
	 * - 각 테이블의 번호로 조회하여 실행
	 * - UserNo 	: 유저가 작성한 모든 게시글 삭제
	 * - PostNo 	: 해당 게시물만 삭제
	 */
	@Override
	public int deleteByUserNo(int userNo) {
		Map<Object, Object> map = new HashMap<Object, Object>() {{
            put("user_no", userNo);
        }};
		int result = 0;
		try {
			result = postDAO.deleteBy(map);
			replyDAO.deleteBy(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@Override
	public int deleteByPostNo(int postNo) {
		Map<Object, Object> map = new HashMap<Object, Object>() {{
            put("post_no", postNo);
        }};
		int result = 0;
		try {
			result = postDAO.delete(map);
			replyDAO.deleteBy(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public boolean idCheck(int postNo, int userNo) {
		Posts post = selectByPostNo(postNo);		
        boolean result = false;
        if( post.getUserNo() == userNo)
        	result = true;
		return result;
	}
	
}
