package movie.DAO;

import java.sql.ResultSet;

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
	
}
