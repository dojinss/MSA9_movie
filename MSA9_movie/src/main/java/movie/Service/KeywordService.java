package movie.Service;

import java.util.List;

import movie.DTO.Keywords;

public interface KeywordService {
	
	// 키워드 작성
	public int insert(Keywords keyword);
	// 키워드 조회
	public Keywords select(int keywordNo);
	// 키워드 수정
	public int update(Keywords keyword);
	// 키워드 삭제
	public int delete(int keywordNo);
	// 영화에 종속된 테이블 삭제
	public int allDelete(int movieNo);
	// 영화 당 키워드 전체 조회
	public List<Keywords> list(int movieNo);
}
