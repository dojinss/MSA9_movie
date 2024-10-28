package movie.Service;

import java.util.HashMap;
import java.util.Map;

import com.alohaclass.jdbc.dto.Page;
import com.alohaclass.jdbc.dto.PageInfo;

import movie.DAO.AdDAO;
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
	public PageInfo<Ads> page(Page page) {
		PageInfo<Ads> selectedPageInfo = null;
		try {
			selectedPageInfo = adDAO.page(page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	
}
