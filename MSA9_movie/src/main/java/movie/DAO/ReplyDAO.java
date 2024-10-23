package movie.DAO;

import java.sql.ResultSet;

import com.alohaclass.jdbc.dao.BaseDAOImpl;

import movie.DTO.Replies;

public class ReplyDAO extends BaseDAOImpl<Replies>{

	@Override
	public Replies map(ResultSet rs) throws Exception {
		Replies reply = new Replies();
		reply.setReplyNo(rs.getInt("reply_no"));
		reply.setUserNo(rs.getInt("user_no"));
		reply.setPostNo(rs.getInt("post_no"));
		reply.setContent(rs.getString("content"));
		reply.setRegDate(rs.getDate("reg_date"));
		reply.setUpdDate(rs.getDate("upd_date"));
		return reply;
	}

	@Override
	public String pk() {
		return "reply_no";
	}

	@Override
	public String table() {
		return "replies";
	}
	
}
