package movie.DAO;

import java.sql.ResultSet;

import com.alohaclass.jdbc.dao.BaseDAOImpl;

import movie.DTO.Ads;

public class AdDAO extends BaseDAOImpl<Ads>{

	@Override
	public Ads map(ResultSet rs) throws Exception {
		Ads ad = new Ads();
		ad.setAdNo(rs.getInt("ad_no"));
		ad.setPrimeNo(rs.getInt("prime_no"));
		ad.setContent(rs.getString("content"));
		ad.setRegDate(rs.getDate("reg_date"));
		ad.setUpdDate(rs.getDate("upd_date"));
		return ad;
	}

	@Override
	public String pk() {
		return "ad_no";
	}

	@Override
	public String table() {
		return "ads";
	}
	
}
