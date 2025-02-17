package movie.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alohaclass.jdbc.dto.Page;
import com.alohaclass.jdbc.dto.PageInfo;

import movie.DAO.PrimeDAO;
import movie.DAO.UserDAO;
import movie.DTO.Movies;
import movie.DTO.Primes;
import movie.DTO.Primes;
import movie.DTO.Users;

public class PrimeServiceImpl implements PrimeService {

	PrimeDAO primeDAO = new PrimeDAO();
	UserDAO userDAO = new UserDAO();
	

	@Override
	public int join(Primes prime) {
		int result = 0;
		int idCheck = 0;
		try {
			Users user = userDAO.select(prime.getUserNo());
			if( user.getUserNo() > 0 )
				idCheck = user.getUserNo();
			else
				System.err.println("광고주 가입중... 없는 회원입니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}
		if( idCheck != 0 ) {
			try {
				result = primeDAO.insert(prime);
			} catch (Exception e) {
				e.printStackTrace();
			}
			if(result > 0) 	System.out.println("광고주 가입 성공.");
			else			System.out.println("광고주 가입 실패.");
		}
		return result;
	}

	@Override
	public Primes selectByUserNo(int userNo) {
		Map<Object, Object> map = new HashMap<Object, Object>() {{
            put("user_no", userNo);
        }};
        Primes prime = null;
		try {
			primeDAO.select(1);
			prime = primeDAO.selectBy(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return prime;
	}

	@Override
	public Primes selectByPrimeNo(int primeNo) {
		Map<Object, Object> map = new HashMap<Object, Object>() {{
            put("prime_no", primeNo);
        }};
        Primes prime = null;
		try {
			primeDAO.select(1);
			prime = primeDAO.selectBy(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return prime;
	}

	@Override
	public int update(Primes prime) {
		int result = 0;
		try {
			result = primeDAO.update(prime);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int delete(int primeNo) {
		int result = 0;
		try {
			result = primeDAO.delete(primeNo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public PageInfo<Primes> page(PageInfo<Primes> pageInfo, int searchCode) {
		List<String> searchOptions = new ArrayList<String>();
		//TODO : 서치 옵션 테이블 컬럼명 수정
		switch (searchCode) {
			case 1:	
				searchOptions.add("title");
				searchOptions.add("cast");
				searchOptions.add("cate");
				break;
			case 2:	
				searchOptions.add("title");
				break;
			case 3:	
				searchOptions.add("cate");
				break;
			case 4:	
				searchOptions.add("cast");
				break;
		}
		pageInfo.setSearchOptions(searchOptions);
		PageInfo<Primes> selectedPageInfo = null;
		try {
			selectedPageInfo = primeDAO.page(pageInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Primes> page() {
		PageInfo<Primes> selectedPageInfo = null;
		try {
			selectedPageInfo = primeDAO.page();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}
	@Override
	public PageInfo<Primes> page(Page page) {
		PageInfo<Primes> selectedPageInfo = null;
		try {
			selectedPageInfo = primeDAO.page(page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}

	@Override
	public PageInfo<Primes> page(Page page, String keyword, List<String> searchOptions) {
		PageInfo<Primes> selectedPageInfo = null;
		try {
			selectedPageInfo = primeDAO.page(page, keyword, searchOptions);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}

	@Override
	public PageInfo<Primes> page(Page page, String keyword, List<String> searchOptions,
			Map<String, String> filterOptions) {
		PageInfo<Primes> selectedPageInfo = null;
		try {
			selectedPageInfo = primeDAO.page(page, keyword, searchOptions,filterOptions);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return selectedPageInfo;
	}

}
