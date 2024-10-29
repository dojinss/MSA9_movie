package movie.DAO;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.alohaclass.jdbc.dao.BaseDAOImpl;

import movie.DTO.Posts;
import movie.DTO.Users;

public class PostDAO extends BaseDAOImpl<Posts>{

	@Override
	public Posts map(ResultSet rs) throws Exception {
		Posts post = new Posts();
		post.setPostNo(rs.getInt("post_no"));
		post.setUserNo(rs.getInt("user_no"));
		post.setKeywordNo(rs.getInt("keyword_no"));
		post.setContent(rs.getString("content"));
		post.setLikes(rs.getInt("likes"));
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
	
	
	public List<Posts> infiniteList(int nowPage,int size,int movieNo){
		int count = 0;
		try {
			count = count();
		} catch (Exception e) {
			System.err.println("게시판 총 개수 구하는중에 에러 발생...");
			e.printStackTrace();
		}
		String sql 	= " SELECT * FROM " + table()
					+ " WHERE keyword_no in ( SELECT keyword_no FROM keywords WHERE movie_no = ? ) "
					+ " OR movie_no = ? "
					+ " ORDER BY post_no desc "
					+ " LIMIT ? , ? "
					;
		if( nowPage > count )
			return null;
		List<Posts> list = new ArrayList<Posts>();
		try {
			psmt = con.prepareStatement(sql);
			log(sql);
			psmt.setInt(1, movieNo);
			psmt.setInt(2, movieNo);
			psmt.setInt(3, nowPage);
			psmt.setInt(4, size);
			rs = psmt.executeQuery();
			while( rs.next() ) {
				Posts entity = map(rs);
				list.add(entity);
			}
		} catch (Exception e) {
			System.err.println(table() + " - list() 조회 중 에러");
			e.printStackTrace();
		}
		return list;
	}
	
	public int lastPK() {
		int result = 0;
		String sql 	= " SELECT max(" + pk() + ") as last_pk FROM " + table();
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
			if( rs.next() ) result = rs.getInt("last_pk");
			else		    result = 0;
		} catch (Exception e) {
			System.err.println(table() + " - lastPK() 조회 중 에러");
			e.printStackTrace();
		}
		return result;
	}
}
