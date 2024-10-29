package movie.Service;

import java.util.List;

import com.alohaclass.jdbc.dto.Page;
import com.alohaclass.jdbc.dto.PageInfo;

import movie.DTO.Movies;
import movie.DTO.Posts;
import movie.DTO.Users;

public interface PostService {
	
	// 게시글 작성
	public int insert(Posts post);
	
	// 게시글 조회
	public Posts selectByUserNo(int userNo);
	public Posts selectByPostNo(int postNo);
	// 게시글 수정
	public int update(Posts post);
	// 게시글 삭제
	public int deleteByPostNo(int postNo);
	public int deleteByUserNo(int userNo);
	// 아이디 체크
	public boolean idCheck(int postNo, int userNo);
	public PageInfo<Posts> page(Page page); 
	
	public PageInfo<Posts> page(Page page, String keyword, List<String> searchOptions); 
}
