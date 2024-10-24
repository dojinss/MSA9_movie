package movie.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import movie.DAO.KeywordDAO;
import movie.DTO.Keywords;

public class KeywordServiceImpl implements KeywordService {

	KeywordDAO keywordDAO = new KeywordDAO();
	
	@Override
	public List<Keywords> list(int page, int count, int size, String keyword, String type) {
		
        List<Keywords> keywordList = null;
//        try {
//        	keywordList = keywordDAO.listBy(data);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		return keywordList;
	}
	
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
	
	
}
