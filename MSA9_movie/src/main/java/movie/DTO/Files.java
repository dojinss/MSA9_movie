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
public class Files {

	private int fileNo;
	private int postNo;
	private String fileUrl;
	private Date regDate;
	private Date updDate;
	
}	
