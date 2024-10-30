package movie.Service;

import java.util.List;
import java.util.Map;

import com.alohaclass.jdbc.dto.Page;
import com.alohaclass.jdbc.dto.PageInfo;

import movie.DTO.Popups;

public interface PopupService {
	
	// 팝업 작성
	public int insert(Popups popup);
	// 팝업 조회
	public Popups select(int popupNo);
	// 팝업 수정
	public int update(Popups popup);
	// 팝업 삭제
	public int delete(int popupNo);
	
	public PageInfo<Popups> page(PageInfo<Popups> pageInfo, int searchCode); 
	public PageInfo<Popups> page(); 
	public PageInfo<Popups> page(Page page); 
	public PageInfo<Popups> page(Page page, String keyword, List<String> searchOptions); 
	public PageInfo<Popups> page(Page page, String keyword, List<String> searchOptions, Map<String, String> filterOptions);
}
