package movie.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alohaclass.jdbc.dto.Page;
import com.alohaclass.jdbc.dto.PageInfo;

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
	@Override
	public List<Movies> select() {
		List<Movies> movieList = movieDAO.select();
		return movieList;
	}
	@Override
	public PageInfo<Movies> page(PageInfo<Movies> pageInfo, int searchCode) {
		List<String> searchOptions = new ArrayList<String>();
		switch (searchCode) {
			case 1:	
				searchOptions.add("title");
				searchOptions.add("cast");
				searchOptions.add("cate");
				break;
			case 2:	
				searchOptions.add("title");
				break;
			case 3:	
				searchOptions.add("cate");
				break;
			case 4:	
				searchOptions.add("cast");
				break;
		}
		pageInfo.setSearchOptions(searchOptions);
		PageInfo<Movies> selectedPageInfo = null;
		try {
			selectedPageInfo = movieDAO.page(pageInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Movies> page() {
		PageInfo<Movies> selectedPageInfo = null;
		try {
			selectedPageInfo = movieDAO.page();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Movies> page(Page page) {
		PageInfo<Movies> selectedPageInfo = null;
		try {
			selectedPageInfo = movieDAO.page(page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Movies> page(Page page, String keyword, List<String> searchOptions) {
		PageInfo<Movies> selectedPageInfo = null;
		try {
			selectedPageInfo = movieDAO.page(page, keyword, searchOptions);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Movies> page(Page page, String keyword, List<String> searchOptions,
			Map<String, String> filterOptions) {
		PageInfo<Movies> selectedPageInfo = null;
		try {
			selectedPageInfo = movieDAO.page(page, keyword, searchOptions,filterOptions);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	
}
