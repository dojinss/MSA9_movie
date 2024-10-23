package movie.Service;

import java.util.HashMap;
import java.util.Map;

import movie.DAO.FileDAO;
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
	
}
