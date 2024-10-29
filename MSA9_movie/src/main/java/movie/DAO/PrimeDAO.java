package movie.DAO;

import java.sql.ResultSet;

import com.alohaclass.jdbc.dao.BaseDAOImpl;

import movie.DTO.Primes;

public class PrimeDAO extends BaseDAOImpl<Primes>{

	@Override
	public Primes map(ResultSet rs) throws Exception {
		Primes prime = new Primes();
		prime.setPrimeNo(rs.getInt("prime_no"));
		prime.setUserNo(rs.getInt("user_no"));
		prime.setAdInfoNo(rs.getInt("ad_info_no"));
		prime.setName(rs.getString("name"));
		prime.setImageUrl(rs.getString("image_url"));
		prime.setNumber(rs.getString("number"));
		prime.setAddr(rs.getString("addr"));
		prime.setStartTime(rs.getDate("start_time"));
		prime.setEndTime(rs.getDate("end_time"));
		prime.setRegDate(rs.getDate("reg_date"));
		prime.setUpdDate(rs.getDate("upd_date"));
		return prime;
	}

	@Override
	public String pk() {
		return "prime_no";
	}

	@Override
	public String table() {
		return "primes";
	}
	
}
