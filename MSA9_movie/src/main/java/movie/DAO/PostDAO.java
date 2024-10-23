package movie.DAO;

import java.sql.ResultSet;

import com.alohaclass.jdbc.dao.BaseDAOImpl;

import movie.DTO.Posts;

public class PostDAO extends BaseDAOImpl<Posts>{

	@Override
	public Posts map(ResultSet rs) throws Exception {
		Posts post = new Posts();
		post.setPostNo(rs.getInt("post_no"));
		post.setUserNo(rs.getInt("user_no"));
		post.setKeywordNo(rs.getInt("keyword_no"));
		post.setContent(rs.getString("content"));
		post.setLike(rs.getInt("like"));
		post.setRegDate(rs.getDate("reg_date"));
		post.setUpdDate(rs.getDate("upd_date"));
		return post;
	}

	@Override
	public String pk() {
		return "post_no";
	}

	@Override
	public String table() {
		return "posts";
	}
	
}
