package movie.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alohaclass.jdbc.dto.Page;
import com.alohaclass.jdbc.dto.PageInfo;

import movie.DAO.KeywordDAO;
import movie.DTO.Keywords;
import movie.DTO.Keywords;

public class KeywordServiceImpl implements KeywordService {

	KeywordDAO keywordDAO = new KeywordDAO();
	
	@Override
	public int insert(Keywords keyword) {
		int result = 0;
		try {
			result = keywordDAO.insert(keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(result > 0) 	System.out.println("키워드 작성 성공.");
		else			System.out.println("키워드 작성 실패.");
		return result;
	}
	@Override
	public Keywords select(int keywordNo) {
		Map<Object, Object> map = new HashMap<Object, Object>() {{
            put("keyword_no", keywordNo);
        }};
        Keywords keyword = null;
        try {
        	keyword = keywordDAO.selectBy(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return keyword;
	}
	public Keywords selectByMovieNo(int movieNo) {
		Map<Object, Object> map = new HashMap<Object, Object>() {{
            put("movie_no", movieNo);
        }};
        Keywords keyword = null;
        try {
        	keyword = keywordDAO.selectBy(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return keyword;
	}
	
	@Override
	public int update(Keywords keyword) {
		int result = 0;
		try {
			result = keywordDAO.update(keyword);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public int delete(int keywordNo) {
		int result = 0;
		try {
			result = keywordDAO.delete(keywordNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public PageInfo<Keywords> page(PageInfo<Keywords> pageInfo, int searchCode) {
		List<String> searchOptions = new ArrayList<String>();
		switch (searchCode) {
			case 1:	
				searchOptions.add("title");
				searchOptions.add("type");
				break;
			case 2:	
				searchOptions.add("title");
				break;
			case 3:	
				searchOptions.add("type");
				break;
		}
		pageInfo.setSearchOptions(searchOptions);
		PageInfo<Keywords> selectedPageInfo = null;
		try {
			selectedPageInfo = keywordDAO.page(pageInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Keywords> page() {
		PageInfo<Keywords> selectedPageInfo = null;
		try {
			selectedPageInfo = keywordDAO.page();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Keywords> page(Page page) {
		PageInfo<Keywords> selectedPageInfo = null;
		try {
			selectedPageInfo = keywordDAO.page(page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Keywords> page(Page page, String keyword, List<String> searchOptions) {
		PageInfo<Keywords> selectedPageInfo = null;
		try {
			selectedPageInfo = keywordDAO.page(page, keyword, searchOptions);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Keywords> page(Page page, String keyword, List<String> searchOptions,
			Map<String, String> filterOptions) {
		PageInfo<Keywords> selectedPageInfo = null;
		try {
			selectedPageInfo = keywordDAO.page(page, keyword, searchOptions,filterOptions);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}

	public List<Keywords> list(int movieNo) {
		List<Keywords> keywordList = keywordDAO.list(movieNo);
		return keywordList;
	}
	@Override
	public int allDelete(int movieNo) {
		Map<Object, Object> map = new HashMap<Object, Object>() {{
            put("movie_no", movieNo);
        }};
        try {
			keywordDAO.deleteBy(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

}
