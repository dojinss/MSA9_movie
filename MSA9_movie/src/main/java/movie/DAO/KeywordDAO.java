package movie.DAO;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.alohaclass.jdbc.dao.BaseDAOImpl;

import movie.DTO.Keywords;
import movie.DTO.Movies;

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
	
	public List<Keywords> list(int movieNo) {
		// 게시글 목록을 담을 컬렉션 객체 생성
		List<Keywords> keywordList = new ArrayList<Keywords>();

		// SQL 작성
		String sql = " SELECT * " + " FROM keywords where movie_no=?";

		try {

			// 1. SQL 실행 객체 생성 - Statement (stmt)
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, movieNo);
			// 2. SQL 실행 요청 -> 결과 ResultSet (rs)
			rs = psmt.executeQuery();

			// 3. 조회된 결과를 리스트(movieList)에 추가
			while (rs.next()) { // next() : 조회 결과의 다음 데이터로 이동
				try {
					keywordList.add(map(rs));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		} catch (SQLException e) {
			System.err.println("영화 목록 조회 시, 예외 발생");
			e.printStackTrace();
		}
		// 4. 게시글 목록 반환
		return keywordList;
	}
	
}
