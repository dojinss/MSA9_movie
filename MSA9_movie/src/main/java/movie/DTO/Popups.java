package movie.DTO;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Popups {

	private int popupNo;
	private String imageUrl;
	private String content;
	private Date startTime;
	private Date endTime;
	private Date regDate;
	private Date updDate;
	
}	
