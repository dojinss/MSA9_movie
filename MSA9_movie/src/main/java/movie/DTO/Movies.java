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
public class Movies {

	private int movieNo;
	private String imageUrl;
	private String title;
	private String content;
	private String cate;
	private boolean notice;
	private String cast;
	private Date regDate;
	private Date updDate;
	
}	
