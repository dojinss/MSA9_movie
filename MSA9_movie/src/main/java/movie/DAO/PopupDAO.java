package movie.DAO;

import java.sql.ResultSet;

import com.alohaclass.jdbc.dao.BaseDAOImpl;

import movie.DTO.Popups;

public class PopupDAO extends BaseDAOImpl<Popups>{

	@Override
	public Popups map(ResultSet rs) throws Exception {
		Popups popup = new Popups();
		popup.setPopupNo(rs.getInt("popup_no"));
		popup.setImageUrl(rs.getString("image_url"));
		popup.setContent(rs.getString("content"));
		popup.setStartTime(rs.getDate("start_time"));
		popup.setEndTime(rs.getDate("end_time"));
		popup.setRegDate(rs.getDate("reg_date"));
		popup.setUpdDate(rs.getDate("upd_date"));
		return popup;
	}

	@Override
	public String pk() {
		return "popup_no";
	}

	@Override
	public String table() {
		return "popups";
	}
	
}
