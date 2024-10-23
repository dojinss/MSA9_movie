package movie.Service;

import movie.DTO.Replies;

public interface ReplyService {
	
	// 게시글 작성
	public int insert(Replies post);
	
	// 게시글 조회
	public Replies selectByUserNo(int userNo);
	public Replies selectByPostNo(int postNo);
	public Replies selectByReplyNo(int replyNo);
	// 게시글 수정
	public int update(Replies post);
	// 게시글 삭제
	public int deleteByUserNo(int userNo);
	public int deleteByPostNo(int postNo);
	public int deleteByReplyNo(int replyNo);
	// 아이디 체크
	public boolean idCheck(int replyNo, int userNo);
}
