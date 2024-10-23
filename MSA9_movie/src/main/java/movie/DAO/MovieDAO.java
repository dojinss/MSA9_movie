package movie.DAO;

import java.sql.ResultSet;

import com.alohaclass.jdbc.dao.BaseDAOImpl;

import movie.DTO.Movies;

public class MovieDAO extends BaseDAOImpl<Movies>{

	@Override
	public Movies map(ResultSet rs) throws Exception {
		Movies movie = new Movies();
		movie.setMovieNo(rs.getInt("movie_no"));
		movie.setNotice(rs.getBoolean("notice"));
		movie.setTitle(rs.getString("title"));
		movie.setCate(rs.getString("cate"));
		movie.setCast(rs.getString("cast"));
		movie.setContent(rs.getString("content"));
		movie.setImageUrl(rs.getString("image_url"));
		movie.setRegDate(rs.getDate("reg_date"));
		movie.setUpdDate(rs.getDate("upd_date"));
		return movie;
	}

	@Override
	public String pk() {
		return "movie_no";
	}

	@Override
	public String table() {
		return "movies";
	}
	
}
