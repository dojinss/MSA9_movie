package movie.DAO;

import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

import com.alohaclass.jdbc.dao.BaseDAOImpl;

import movie.DTO.Keywords;
import movie.DTO.PersistenceLogins;

public class PersistenceLoginsDAO extends BaseDAOImpl<PersistenceLogins> {
	
	@Override
	public PersistenceLogins map(ResultSet arg0) throws Exception {
		return null;
	}

	@Override
	public String pk() {
		return "token_no";
	}

	@Override
	public String table() {
		return "tokens";
	}
	
	
	
	/**
	 * 토큰 생성
	 * @param no
	 * @return
	 */
	public PersistenceLogins insert(int no) {
		int result = 0;
		String SQL = " INSERT INTO tokens (user_no, token, expiry_date) "
				   + " VALUES ( ? , ? , ? ) "
				   ;
		
		// 토큰 발행
		String token = UUID.randomUUID().toString();
		
		// 만료 시간 설정
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DAY_OF_YEAR, 7);
		Date expiryDate = calendar.getTime();
		Timestamp expiryTime = new Timestamp(expiryDate.getTime());
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setInt(1, no);
			psmt.setString(2, token);
			psmt.setTimestamp(3, expiryTime);
			
			result = psmt.executeUpdate();
		} catch (Exception e) {
			System.err.println("자동 로그인 정보 등록 중, 예외 발생");
			e.printStackTrace();
		}
		System.out.println("자동 로그인 정보(토큰) 등록 성공");
		
		PersistenceLogins logins = PersistenceLogins.builder()
													.userNo(no)
													.token(token)
													.expiryDate(expiryTime)
													.build()
													;
		
		return logins;
	}
	
	/**
	 * 토큰 조회
	 * - 아이디로 조회
	 * @param no
	 * @return
	 */
	public PersistenceLogins select(int no) {
		
		
		String SQL = " SELECT * "
				   + " FROM tokens "
				   + " WHERE user_no = ? "
				   ;
		PersistenceLogins logins = null;
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setInt(1, no);
			rs = psmt.executeQuery();
			if( rs.next() ) {
				logins = PersistenceLogins.builder()
										  .userNo(no)
										  .token(rs.getString("token"))
										  .expiryDate(rs.getTimestamp("expiry_date"))
										  .regDate(rs.getTimestamp("reg_date"))
										  .updDate(rs.getTimestamp("upd_date"))
										  .build()
										  ;
			}
		} catch (Exception e) {
			System.err.println("토큰 조회 시, 예외 발생");
			e.printStackTrace();
		}
		
		return logins;
		
	}
	
	/**
	 * 토큰 조회
	 * - 인증 토큰으로 조회
	 * @param token
	 * @return
	 */
	public PersistenceLogins selectByToken(String token) {
		
		
		String SQL = " SELECT * "
				+ " FROM tokens "
				+ " WHERE token = ? "
				;
		PersistenceLogins logins = null;
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, token);
			rs = psmt.executeQuery();
			if( rs.next() ) {
				logins = PersistenceLogins.builder()
						.userNo(rs.getInt("user_no"))
						.token(rs.getString("token"))
						.expiryDate(rs.getTimestamp("expiry_date"))
						.regDate(rs.getTimestamp("reg_date"))
						.updDate(rs.getTimestamp("upd_date"))
						.build()
						;
			}
		} catch (Exception e) {
			System.err.println("토큰 조회 시, 예외 발생");
			e.printStackTrace();
		}
		
		return logins;
		
	}
	
	
	/**
	 * 토큰 수정
	 * @param userid
	 * @return
	 */
	public PersistenceLogins update(int no) {
		
		String SQL = " UPDATE tokens "
				   + " SET token = ? "
				   + " 	  ,expiry_date = ? "
				   + " 	  ,upd_date = ? "
				   + " WHERE user_no = ? "
				   ;
		// 토큰 발행
		String token = UUID.randomUUID().toString();
		
		// 만료 시간 설정
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DAY_OF_YEAR, 7);
		Date expiryDate = calendar.getTime();
		Timestamp expiryTime = new Timestamp(expiryDate.getTime());
		
		// 수정 시간
		Timestamp updDate = new Timestamp( new Date().getTime() );
		
		PersistenceLogins logins = null;
		try {
			
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, token);
			psmt.setTimestamp(2, expiryTime);
			psmt.setTimestamp(3, updDate);
			psmt.setInt(4, no);
			int result = psmt.executeUpdate();
			if( result > 0) {
				logins = PersistenceLogins.builder()
						.userNo(no)
						.expiryDate(expiryDate)
						.token(token)
						.updDate(updDate)
						.build()
						;
				System.out.println("토큰 수정 성공!");
			}
		} catch (Exception e) {
			System.err.println("토큰 수정 시, 오류 발생");
			e.printStackTrace();
		}
		return logins;
	}
	
	
	// 토큰 삭제
	
	public boolean delete(int no) {
		boolean result = false;
		String SQL = " DELETE FROM tokens "
				   + " WHERE user_no = ? "
				   ;
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setInt(1, no);
			result = psmt.executeUpdate() == 0 ? false : true;
		} catch (Exception e) {
			System.err.println("토큰 삭제 시, 어류 발생");
			e.printStackTrace();
		}
		return result;
	}


	
}










