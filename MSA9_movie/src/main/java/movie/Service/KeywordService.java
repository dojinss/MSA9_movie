package movie.Service;

import java.util.List;
import java.util.Map;

import com.alohaclass.jdbc.dto.Page;
import com.alohaclass.jdbc.dto.PageInfo;

import movie.DTO.Keywords;

public interface KeywordService {
	
	// 키워드 작성
	public int insert(Keywords keyword);
	// 키워드 조회
	public Keywords select(int keywordNo);
	public Keywords selectByMovieNo(int keywordNo);
	// 키워드 수정
	public int update(Keywords keyword);
	// 키워드 삭제
	public int delete(int keywordNo);
	
	public PageInfo<Keywords> page(PageInfo<Keywords> pageInfo, int searchCode); 
	public PageInfo<Keywords> page(); 
	public PageInfo<Keywords> page(Page page); 
	public PageInfo<Keywords> page(Page page, String keyword, List<String> searchOptions); 
	public PageInfo<Keywords> page(Page page, String keyword, List<String> searchOptions, Map<String, String> filterOptions);
}
