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
public class Replies {

	private int replyNo;
	private int postNo;
	private int userNo;
	private String content;
	private Date regDate;
	private Date updDate;
	
}	
