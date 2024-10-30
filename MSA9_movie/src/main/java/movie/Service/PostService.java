package movie.Service;

import java.util.List;

import java.util.Map;


import com.alohaclass.jdbc.dto.Page;
import com.alohaclass.jdbc.dto.PageInfo;


import movie.DTO.Posts;
import movie.DTO.Movies;
import movie.DTO.Users;

public interface PostService {
	
	// 게시글 작성
	public int insert(Posts post);
	public int insertKey(Posts post); // 게시글 입력후 PK 값 반환
	
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

	
	// 페이징 처리 목록
	public PageInfo<Posts> page(PageInfo<Posts> pageInfo, int searchCode); 
	public PageInfo<Posts> page(); 
	public PageInfo<Posts> page(Page page); 
	public PageInfo<Posts> page(Page page, String keyword, List<String> searchOptions); 
	public PageInfo<Posts> page(Page page, String keyword, List<String> searchOptions, Map<String, String> filterOptions);
	
	// 인피니티 스크롤 목록
	public List<Posts> infiniteList(int nowPage,int size,int movieNo);

