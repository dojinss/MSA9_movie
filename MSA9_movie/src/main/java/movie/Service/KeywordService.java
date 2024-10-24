package movie.Service;

import java.util.List;

import movie.DTO.Keywords;

public interface KeywordService {
	
	// 키워드 리스트
	public List<Keywords> list(int page, int count, int size, String keyword, String type);
	// 키워드 작성
	public int insert(Keywords keyword);
	// 키워드 조회
	public Keywords select(int keywordNo);
	// 키워드 수정
	public int update(Keywords keyword);
	// 키워드 삭제
	public int delete(int keywordNo);
}
