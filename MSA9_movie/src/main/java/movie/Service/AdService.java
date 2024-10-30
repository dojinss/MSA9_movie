package movie.Service;


import java.util.List;
import java.util.Map;


import com.alohaclass.jdbc.dto.Page;
import com.alohaclass.jdbc.dto.PageInfo;

import movie.DTO.Ads;
import movie.DTO.Posts;

public interface AdService {
	
	// 광고 작성
	public int insert(Ads ad);
	// 광고 조회
	public Ads select(int adNo);
	// 광고 수정
	public int update(Ads ad);
	// 광고 삭제
	public int delete(int adNo);

  public PageInfo<Ads> page(PageInfo<Ads> pageInfo, int searchCode); 
	public PageInfo<Ads> page(); 
	public PageInfo<Ads> page(Page page); 
	public PageInfo<Ads> page(Page page, String keyword, List<String> searchOptions); 
	public PageInfo<Ads> page(Page page, String keyword, List<String> searchOptions, Map<String, String> filterOptions);

}
