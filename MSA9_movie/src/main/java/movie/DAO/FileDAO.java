package movie.DAO;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.alohaclass.jdbc.dao.BaseDAOImpl;

import movie.DTO.Files;

public class FileDAO extends BaseDAOImpl<Files>{

	@Override
	public Files map(ResultSet rs) throws Exception {
		Files file = new Files();
		file.setFileNo(rs.getInt("file_no"));
		file.setPostNo(rs.getInt("post_no"));
		file.setFileUrl(rs.getString("file_url"));
		file.setRegDate(rs.getDate("reg_date"));
		file.setUpdDate(rs.getDate("upd_date"));
		return file;
	}

	@Override
	public String pk() {
		return "file_no";
	}

	@Override
	public String table() {
		return "files";
	}
	
	public List<Files> list(int postNo){
		List<Files> fileList = new ArrayList<Files>();
		
		String sql = " SELECT * FROM " + table()
				   + " WHERE post_no = ? "
				   ;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, postNo);
			log(sql);
			rs = psmt.executeQuery();
			while( rs.next() ) {
				Files file = map(rs);
				fileList.add(file);
			}
		} catch (Exception e) {
			System.err.println("게시글 이미지파일 리스트 DB 조회중 에러...");
			e.printStackTrace();
		}
		return fileList;
	}
	
}
