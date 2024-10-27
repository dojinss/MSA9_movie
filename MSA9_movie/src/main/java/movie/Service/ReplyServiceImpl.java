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
import movie.DTO.Replies;
import movie.DTO.Replies;

public class ReplyServiceImpl implements ReplyService {

	PostDAO postDAO = new PostDAO();
	ReplyDAO replyDAO = new ReplyDAO();
	UserDAO userDAO = new UserDAO();
	
	@Override
	public int insert(Replies reply) {
		int result = 0;
		try {
			result = replyDAO.insert(reply);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(result > 0) 	System.out.println("댓글 작성 성공.");
		else			System.out.println("댓글 작성 실패.");
		return result;
	}
	@Override
	public Replies selectByUserNo(int userNo) {
		Map<Object, Object> map = new HashMap<Object, Object>() {{
            put("user_no", userNo);
        }};
        Replies reply = null;
        try {
        	replyDAO.select(1);
			reply = replyDAO.selectBy(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reply;
	}
	@Override
	public Replies selectByPostNo(int postNo) {
		Map<Object, Object> map = new HashMap<Object, Object>() {{
            put("post_no", postNo);
        }};
        Replies reply = null;
        try {
        	replyDAO.select(1);
			reply = replyDAO.selectBy(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reply;
	}
	@Override
	public Replies selectByReplyNo(int replyNo) {
		Map<Object, Object> map = new HashMap<Object, Object>() {{
            put("reply_no", replyNo);
        }};
        Replies reply = null;
        try {
        	replyDAO.select(1);
			reply = replyDAO.selectBy(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reply;
	}
	
	@Override
	public int update(Replies reply) {
		int result = 0;
		try {
			result = replyDAO.update(reply);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * Delete ~ No (int ~No)
	 * - 각 테이블의 번호로 조회하여 실행
	 * - UserNo 	: 유저가 작성한 모든 댓글 삭제
	 * - PostNo 	: 게시글에 연동된 댓글 삭제
	 * - ReplyNo 	: 해당 댓글만 삭제
	 */
	@Override
	public int deleteByUserNo(int userNo) {
		int result = 0;
		try {
			result = replyDAO.delete(userNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@Override
	public int deleteByPostNo(int postNo) {
		int result = 0;
		try {
			result = replyDAO.delete(postNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@Override
	public int deleteByReplyNo(int replyNo) {
		int result = 0;
		try {
			result = replyDAO.delete(replyNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * idCheck()
	 * - 입력한 유저와 replies테이블의 유저가 일치하는지 체크
	 * - boolean 타입으로 반환
	 */
	@Override
	public boolean idCheck(int replyNo, int userNo) {
		Replies reply = selectByPostNo(replyNo);		
        boolean result = false;
        if( reply.getUserNo() == userNo)
        	result = true;
		return result;
	}
	@Override
	public PageInfo<Replies> page(PageInfo<Replies> pageInfo, int searchCode) {
		List<String> searchOptions = new ArrayList<String>();
		switch (searchCode) {
			case 1:	
				searchOptions.add("userId");
				break;
			case 2:	
				searchOptions.add("content");
				break;
		}
		pageInfo.setSearchOptions(searchOptions);
		PageInfo<Replies> selectedPageInfo = null;
		try {
			selectedPageInfo = replyDAO.page(pageInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Replies> page() {
		PageInfo<Replies> selectedPageInfo = null;
		try {
			selectedPageInfo = replyDAO.page();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Replies> page(Page page) {
		PageInfo<Replies> selectedPageInfo = null;
		try {
			selectedPageInfo = replyDAO.page(page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Replies> page(Page page, String keyword, List<String> searchOptions) {
		PageInfo<Replies> selectedPageInfo = null;
		try {
			selectedPageInfo = replyDAO.page(page, keyword, searchOptions);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Replies> page(Page page, String keyword, List<String> searchOptions,
			Map<String, String> filterOptions) {
		PageInfo<Replies> selectedPageInfo = null;
		try {
			selectedPageInfo = replyDAO.page(page, keyword, searchOptions,filterOptions);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
}
