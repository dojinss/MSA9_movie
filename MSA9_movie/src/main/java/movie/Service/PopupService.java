package movie.Service;

import movie.DTO.Popups;

public interface PopupService {
	
	// 팝업 작성
	public int insert(Popups popup);
	// 팝업 조회
	public Popups select(int popupNo);
	// 팝업 수정
	public int update(Popups popup);
	// 팝업 삭제
	public int delete(int popupNo);
}
