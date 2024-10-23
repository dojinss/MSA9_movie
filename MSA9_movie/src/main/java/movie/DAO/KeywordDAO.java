package movie.DAO;

import java.sql.ResultSet;

import com.alohaclass.jdbc.dao.BaseDAOImpl;

import movie.DTO.Keywords;

public class KeywordDAO extends BaseDAOImpl<Keywords>{

	@Override
	public Keywords map(ResultSet rs) throws Exception {
		Keywords keyword = new Keywords();
		keyword.setKeywordNo(rs.getInt("keyword_no"));
		keyword.setMovieNo(rs.getInt("movie_no"));
		keyword.setTitle(rs.getString("title"));
		keyword.setContent(rs.getString("content"));
		keyword.setImageUrl(rs.getString("image_url"));
		keyword.setRegDate(rs.getDate("reg_date"));
		keyword.setUpdDate(rs.getDate("upd_date"));
		return keyword;
	}

	@Override
	public String pk() {
		return "keyword_no";
	}

	@Override
	public String table() {
		return "keywords";
	}
	
}
