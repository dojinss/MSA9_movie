package movie.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alohaclass.jdbc.dto.Page;
import com.alohaclass.jdbc.dto.PageInfo;

import movie.DAO.PopupDAO;
import movie.DTO.Popups;
import movie.DTO.Popups;

public class PopupServiceImpl implements PopupService {

	PopupDAO popupDAO = new PopupDAO();
	
	@Override
	public int insert(Popups popup) {
		int result = 0;
		try {
			result = popupDAO.insert(popup);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(result > 0) 	System.out.println("팝업 작성 성공.");
		else			System.out.println("팝업 작성 실패.");
		return result;
	}
	@Override
	public Popups select(int popupNo) {
		Map<Object, Object> map = new HashMap<Object, Object>() {{
            put("popup_no", popupNo);
        }};
        Popups popup = null;
        try {
        	popupDAO.select(1);
        	popup = popupDAO.selectBy(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return popup;
	}
	
	@Override
	public int update(Popups popup) {
		int result = 0;
		try {
			result = popupDAO.update(popup);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public int delete(int popupNo) {
		int result = 0;
		try {
			result = popupDAO.delete(popupNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@Override
	public PageInfo<Popups> page(PageInfo<Popups> pageInfo, int searchCode) {
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
		PageInfo<Popups> selectedPageInfo = null;
		try {
			selectedPageInfo = popupDAO.page(pageInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Popups> page() {
		PageInfo<Popups> selectedPageInfo = null;
		try {
			selectedPageInfo = popupDAO.page();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Popups> page(Page page) {
		PageInfo<Popups> selectedPageInfo = null;
		try {
			selectedPageInfo = popupDAO.page(page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Popups> page(Page page, String keyword, List<String> searchOptions) {
		PageInfo<Popups> selectedPageInfo = null;
		try {
			selectedPageInfo = popupDAO.page(page, keyword, searchOptions);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Popups> page(Page page, String keyword, List<String> searchOptions,
			Map<String, String> filterOptions) {
		PageInfo<Popups> selectedPageInfo = null;
		try {
			selectedPageInfo = popupDAO.page(page, keyword, searchOptions,filterOptions);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
}
