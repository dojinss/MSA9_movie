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
public class Primes {

	private int primeNo;
	private int adInfoNo;
	private int userNo;
	private String name;
	private String imageUrl;
	private String number;
	private String addr;
	private Date startTime;
	private Date endTime;
	private Date regDate;
	private Date updDate;
	
}	
