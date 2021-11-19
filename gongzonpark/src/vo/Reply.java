package vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Reply {

	private Long rno;
	private String content;
	private String regDate;
	private String id;
	private String nickname;
	private String profileUuid;
	private Long bno;

	// 댓글 쓰기 테스트를 위한 생성자
	public Reply(String content, String id, Long bno) {
		super();
		this.content = content;
		this.id = id;
		this.bno = bno;
	}
}
