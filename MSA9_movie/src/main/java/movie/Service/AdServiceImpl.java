package movie.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alohaclass.jdbc.dto.Page;
import com.alohaclass.jdbc.dto.PageInfo;

import movie.DAO.AdDAO;
import movie.DTO.Ads;
import movie.DTO.Ads;

public class AdServiceImpl implements AdService {

	AdDAO adDAO = new AdDAO();
	
	@Override
	public int insert(Ads ad) {
		int result = 0;
		try {
			result = adDAO.insert(ad);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(result > 0) 	System.out.println("광고 작성 성공.");
		else			System.out.println("광고 작성 실패.");
		return result;
	}
	@Override
	public Ads select(int adNo) {
		Map<Object, Object> map = new HashMap<Object, Object>() {{
            put("ad_no", adNo);
        }};
        Ads ad = null;
        try {
        	adDAO.select(1);
        	ad = adDAO.selectBy(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ad;
	}
	
	@Override
	public int update(Ads ad) {
		int result = 0;
		try {
			result = adDAO.update(ad);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public int delete(int adNo) {
		int result = 0;
		try {
			result = adDAO.delete(adNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@Override
	public PageInfo<Ads> page(PageInfo<Ads> pageInfo, int searchCode) {
		List<String> searchOptions = new ArrayList<String>();
		//TODO : 서치 옵션 테이블 컬럼명 수정
		switch (searchCode) {
			case 1:	
				searchOptions.add("title");
				searchOptions.add("cast");
				searchOptions.add("cate");
				break;
			case 2:	
				searchOptions.add("title");
				break;
			case 3:	
				searchOptions.add("cate");
				break;
			case 4:	
				searchOptions.add("cast");
				break;
		}
		pageInfo.setSearchOptions(searchOptions);
		PageInfo<Ads> selectedPageInfo = null;
		try {
			selectedPageInfo = adDAO.page(pageInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Ads> page() {
		PageInfo<Ads> selectedPageInfo = null;
		try {
			selectedPageInfo = adDAO.page();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Ads> page(Page page) {
		PageInfo<Ads> selectedPageInfo = null;
		try {
			selectedPageInfo = adDAO.page(page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Ads> page(Page page, String keyword, List<String> searchOptions) {
		PageInfo<Ads> selectedPageInfo = null;
		try {
			selectedPageInfo = adDAO.page(page, keyword, searchOptions);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Ads> page(Page page, String keyword, List<String> searchOptions,
			Map<String, String> filterOptions) {
		PageInfo<Ads> selectedPageInfo = null;
		try {
			selectedPageInfo = adDAO.page(page, keyword, searchOptions,filterOptions);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
}
