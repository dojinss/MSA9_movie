package movie.Service;

import java.util.List;
import java.util.Map;

import com.alohaclass.jdbc.dto.Page;
import com.alohaclass.jdbc.dto.PageInfo;

import movie.DTO.Files;

public interface FileService {
	
	// 파일정보 DB 작성
	public int insert(Files file);
	
	// 파일정보 조회
	public Files selectByFileNo(int fileNo);
	// 게시글에 연결된 파일정보 조회
	public Files selectByPostNo(int postNo);
	
	// 파일정보 수정 
	public int update(Files file);
	
	// 파일정보 DB 삭제
	public int delete(int fileNo);
	public int deleteByPostNo(int postNo);
	
	// 페이징처리
	public PageInfo<Files> page(PageInfo<Files> pageInfo, int searchCode); 
	public PageInfo<Files> page(); 
	public PageInfo<Files> page(Page page); 
	public PageInfo<Files> page(Page page, String keyword, List<String> searchOptions); 
	public PageInfo<Files> page(Page page, String keyword, List<String> searchOptions, Map<String, String> filterOptions);
	
	// 게시글 이미지파일 목록 불러오기
	public List<Files> list(int postNo);
}
