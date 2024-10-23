package movie.Service;

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
	
}
