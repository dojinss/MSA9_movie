package movie.Service;

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
	public PageInfo<Ads> page(Page page); 
}
