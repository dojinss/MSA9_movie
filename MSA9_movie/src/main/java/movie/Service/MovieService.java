package movie.Service;

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
}
