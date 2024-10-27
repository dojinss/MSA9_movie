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
public class Ads {

	private int adNo;
	private int primeNo;
	private String content;
	private Date regDate;
	private Date updDate;
	
}	
