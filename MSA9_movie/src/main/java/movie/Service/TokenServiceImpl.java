package movie.Service;

import java.util.Date;

import movie.DAO.TokenDAO;
import movie.DTO.Tokens;

public class TokenServiceImpl implements TokenService{
	
	private TokenDAO pDAO = new TokenDAO();
	
	@Override
	public Tokens insert(int no) {
		return pDAO.insert(no);
	}

	@Override
	public Tokens select(int no) {
		return pDAO.select(no);
	}

	@Override
	public Tokens selectByToken(String token) {
		return pDAO.selectByToken(token);
	}

	@Override
	public Tokens update(int no) {
		return pDAO.update(no);
	}

	@Override
	public Tokens refresh(int no) {
		// 토큰 조회
		Tokens plogin = pDAO.select(no);
		
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
		Tokens plogin = pDAO.selectByToken(token);
		
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
