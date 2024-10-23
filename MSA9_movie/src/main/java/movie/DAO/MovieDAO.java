package movie.DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
	
	public List<Movies> select() {
		// 게시글 목록을 담을 컬렉션 객체 생성
		List<Movies> movieList = new ArrayList<Movies>();

		// SQL 작성
		String sql = " SELECT * " + " FROM movies ";

		try {

			// 1. SQL 실행 객체 생성 - Statement (stmt)
			stmt = con.createStatement();

			// 2. SQL 실행 요청 -> 결과 ResultSet (rs)
			rs = stmt.executeQuery(sql);

			// 3. 조회된 결과를 리스트(movieList)에 추가
			while (rs.next()) { // next() : 조회 결과의 다음 데이터로 이동
				try {
					movieList.add(map(rs));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		} catch (SQLException e) {
			System.err.println("영화 목록 조회 시, 예외 발생");
			e.printStackTrace();
		}
		// 4. 게시글 목록 반환
		return movieList;
	}
}
