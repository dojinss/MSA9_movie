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
public class Keywords {

	private int keywordNo;
	private int movieNo;
	private String title;
	private String type;
	private String imageUrl;
	private String content;
	private Date regDate;
	private Date updDate;
	
}	
