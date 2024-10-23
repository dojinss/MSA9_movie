package movie.Service;

import java.util.Date;

import movie.DAO.PersistenceLoginsDAO;
import movie.DTO.PersistenceLogins;

public class PersistenceLoginsServiceImpl implements PersistenceLoginsService{
	
	private PersistenceLoginsDAO pDAO = new PersistenceLoginsDAO();
	
	@Override
	public PersistenceLogins insert(int no) {
		return pDAO.insert(no);
	}

	@Override
	public PersistenceLogins select(int no) {
		return pDAO.select(no);
	}

	@Override
	public PersistenceLogins selectByToken(String token) {
		return pDAO.selectByToken(token);
	}

	@Override
	public PersistenceLogins update(int no) {
		return pDAO.update(no);
	}

	@Override
	public PersistenceLogins refresh(int no) {
		// 토큰 조회
		PersistenceLogins plogin = pDAO.select(no);
		
		// 토큰이 없는 경우, 토큰 생성
		if( plogin == null ) {
			plogin = pDAO.insert(no);
		}
		// 토큰이 있는 경우, 토큰 수정
		else {
			plogin = pDAO.update(no);
		}
		
		return plogin;
	}

	@Override
	public boolean isValid(String token) {
		// 토큰 조회
		PersistenceLogins plogin = pDAO.selectByToken(token);
		
		// 토큰 없음
		if( plogin == null )
			return false;
		
		// 토큰 만료
		Date expiryDate = plogin.getExpiryDate();
		Date today = new Date();
		if( today.after(expiryDate) )
			return false;
		
		// 토큰 유효
		return true;
	}

	@Override
	public boolean delete(int no) {
		return pDAO.delete(no);
	}

}
