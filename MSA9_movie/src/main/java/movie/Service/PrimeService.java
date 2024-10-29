package movie.Service;

import java.util.List;

import com.alohaclass.jdbc.dto.Page;
import com.alohaclass.jdbc.dto.PageInfo;

import movie.DTO.Movies;
import movie.DTO.Posts;
import movie.DTO.Primes;

public interface PrimeService {
	
	// 광고주 가입
	public int join(Primes prime);
	
	// 광고주 조회
	public Primes selectByUserNo(int userNo);
	public Primes selectByPrimeNo(int primeNo);
	// 광고주 정보 수정
	public int update(Primes prime);
	// 광고주 삭제
	public int delete(int primeNo);
	public PageInfo<Primes> page(Page page); 
	public PageInfo<Primes> page(Page page, String keyword, List<String> searchOptions); 
}
