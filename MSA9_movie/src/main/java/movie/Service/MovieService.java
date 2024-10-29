package movie.Service;

import java.util.List;
import java.util.Map;

import com.alohaclass.jdbc.dto.Page;
import com.alohaclass.jdbc.dto.PageInfo;

import movie.DTO.Movies;

public interface MovieService {
	
	// 영화정보 작성
	public int insert(Movies movie);
	// 영화정보 조회
	public Movies select(int movieNo);
	// 영화정보 수정
	public int update(Movies movie);
	// 영화정보 삭제
	public int delete(int movieNo);
	// 영화정보 전체 조회
	public List<Movies> select();
	
	public PageInfo<Movies> page(PageInfo<Movies> pageInfo, int searchCode); 
	public PageInfo<Movies> page(); 
	public PageInfo<Movies> page(Page page); 
	public PageInfo<Movies> page(Page page, String keyword, List<String> searchOptions); 
	public PageInfo<Movies> page(Page page, String keyword, List<String> searchOptions, Map<String, String> filterOptions); 
}




