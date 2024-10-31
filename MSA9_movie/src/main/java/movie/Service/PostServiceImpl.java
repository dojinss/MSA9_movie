package movie.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alohaclass.jdbc.dto.Page;
import com.alohaclass.jdbc.dto.PageInfo;

import movie.DAO.PostDAO;
import movie.DAO.ReplyDAO;
import movie.DAO.UserDAO;
import movie.DTO.Movies;
import movie.DTO.Posts;

import movie.DTO.Posts;
import movie.DTO.Users;


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
	public int insertKey(Posts post) {
		int result = 0;
		try {
			result = postDAO.insert(post);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(result > 0) 	System.out.println("게시글 작성 성공.");
		else			System.out.println("게시글 작성 실패.");
		return postDAO.lastPK();
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
			result = postDAO.deleteBy(map);
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

	public PageInfo<Posts> page(PageInfo<Posts> pageInfo, int searchCode) {
		List<String> searchOptions = new ArrayList<String>();
		switch (searchCode) {
			case 1:	
				searchOptions.add("content");
				break;
		}
		pageInfo.setSearchOptions(searchOptions);
		PageInfo<Posts> selectedPageInfo = null;
		try {
			selectedPageInfo = postDAO.page(pageInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Posts> page() {
		PageInfo<Posts> selectedPageInfo = null;
		try {
			selectedPageInfo = postDAO.page();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Posts> page(Page page) {
		PageInfo<Posts> selectedPageInfo = null;
		try {
			selectedPageInfo = postDAO.page(page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Posts> page(Page page, String keyword, List<String> searchOptions) {
		PageInfo<Posts> selectedPageInfo = null;
		try {
			selectedPageInfo = postDAO.page(page, keyword, searchOptions);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}

	@Override
	public PageInfo<Posts> page(Page page, String keyword, List<String> searchOptions,
			Map<String, String> filterOptions) {
		PageInfo<Posts> selectedPageInfo = null;
		try {
			selectedPageInfo = postDAO.page(page, keyword, searchOptions,filterOptions);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public List<Posts> infiniteList(int nowPage, int size, int movieNo) {
		List<Posts> postList = null;
		try {
			postList = postDAO.infiniteList(nowPage, size, movieNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return postList;
	}
	@Override
	public List<Posts> infiniteListByKeywordNo(int nowPage, int size, int keywordNo) {
		List<Posts> postList = null;
		try {
			postList = postDAO.infiniteListByKeywordNo(nowPage, size, keywordNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return postList;
	}

}
