package vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Board {
	
	private Long bno;
	private String title;
	private String content;
	private String regDate;
	private String id;
	private Long category;
	private Integer replyCnt;
	private String nickname;
	private String profileUuid;
	
	private List<Attach> attachs;

	// 글 작성을 위한 생성자
	public Board(String title, String content, String id, Long category) {
		this.title = title;
		this.content = content;
		this.id = id;
		this.category = category;
	}
	
	// 글 수정을 위한 생성자
	public Board(Long bno, String title, String content) {
		super();
		this.bno = bno;
		this.title = title;
		this.content = content;
	}

	// 글 목록을 위한 생성자
	public Board(Long bno, String title, String content, String regDate, String id
			, Long category, Integer replyCnt, String nickname, String profileUuid) {
		super();
		this.bno = bno;
		this.title = title;
		this.content = content;
		this.regDate = regDate;
		this.id = id;
		this.category = category;
		this.replyCnt = replyCnt;
		this.nickname = nickname;
		this.profileUuid = profileUuid;
	}
	
}
