package movie.Service;

import java.util.HashMap;
import java.util.Map;

import movie.DAO.PopupDAO;
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
	
}
