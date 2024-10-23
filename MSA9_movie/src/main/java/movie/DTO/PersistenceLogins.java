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
public class PersistenceLogins {
	private int no;
	private int userNo;
	private String token;
	private Date expiryDate;
	private Date regDate;
	private Date updDate;
}
