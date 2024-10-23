package movie.Service;

import java.util.HashMap;
import java.util.Map;

import movie.DAO.MovieDAO;
import movie.DTO.Movies;

public class MovieServiceImpl implements MovieService {

	MovieDAO movieDAO = new MovieDAO();
	
	@Override
	public int insert(Movies movie) {
		int result = 0;
		try {
			result = movieDAO.insert(movie);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(result > 0) 	System.out.println("영화정보 작성 성공.");
		else			System.out.println("영화정보 작성 실패.");
		return result;
	}
	@Override
	public Movies select(int movieNo) {
		Map<Object, Object> map = new HashMap<Object, Object>() {{
            put("movie_no", movieNo);
        }};
        Movies movie = null;
        try {
        	movieDAO.select(1);
			movie = movieDAO.selectBy(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return movie;
	}
	
	@Override
	public int update(Movies movie) {
		int result = 0;
		try {
			result = movieDAO.update(movie);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public int delete(int movieNo) {
		int result = 0;
		try {
			result = movieDAO.delete(movieNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
