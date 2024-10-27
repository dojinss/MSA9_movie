package movie.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alohaclass.jdbc.dto.Page;
import com.alohaclass.jdbc.dto.PageInfo;

import movie.DAO.FileDAO;
import movie.DTO.Files;
import movie.DTO.Files;

public class FileServiceImpl implements FileService {

	FileDAO fileDAO = new FileDAO();
	
	@Override
	public int insert(Files file) {
		int result = 0;
		try {
			result = fileDAO.insert(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(result > 0) 	System.out.println("팝업 작성 성공.");
		else			System.out.println("팝업 작성 실패.");
		return result;
	}
	@Override
	public Files selectByFileNo(int fileNo) {
		Map<Object, Object> map = new HashMap<Object, Object>() {{
            put("file_no", fileNo);
        }};
        Files file = null;
        try {
        	fileDAO.select(1);
        	file = fileDAO.selectBy(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return file;
	}
	@Override
	public Files selectByPostNo(int postNo) {
		Map<Object, Object> map = new HashMap<Object, Object>() {{
            put("post_no", postNo);
        }};
        Files file = null;
        try {
        	fileDAO.select(1);
        	file = fileDAO.selectBy(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return file;
	}
	
	@Override
	public int update(Files file) {
		int result = 0;
		try {
			result = fileDAO.update(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public int delete(int fileNo) {
		int result = 0;
		try {
			result = fileDAO.delete(fileNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	@Override
	public PageInfo<Files> page(PageInfo<Files> pageInfo, int searchCode) {
		List<String> searchOptions = new ArrayList<String>();
		switch (searchCode) {
			case 1:	
				searchOptions.add("title");
				searchOptions.add("type");
				break;
			case 2:	
				searchOptions.add("title");
				break;
			case 3:	
				searchOptions.add("type");
				break;
		}
		pageInfo.setSearchOptions(searchOptions);
		PageInfo<Files> selectedPageInfo = null;
		try {
			selectedPageInfo = fileDAO.page(pageInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Files> page() {
		PageInfo<Files> selectedPageInfo = null;
		try {
			selectedPageInfo = fileDAO.page();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Files> page(Page page) {
		PageInfo<Files> selectedPageInfo = null;
		try {
			selectedPageInfo = fileDAO.page(page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Files> page(Page page, String keyword, List<String> searchOptions) {
		PageInfo<Files> selectedPageInfo = null;
		try {
			selectedPageInfo = fileDAO.page(page, keyword, searchOptions);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Files> page(Page page, String keyword, List<String> searchOptions,
			Map<String, String> filterOptions) {
		PageInfo<Files> selectedPageInfo = null;
		try {
			selectedPageInfo = fileDAO.page(page, keyword, searchOptions,filterOptions);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
}
