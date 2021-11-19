package vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@RequiredArgsConstructor
public class Member {
	
	@NonNull
	private String id;
	private String pwd;
	private String email;
	private String name;
	private String nickname;
	private String emailHash;
	private int emailChecked;
	private String profileUuid;
	
	// 회원가입을 위한 생성자
	public Member(@NonNull String id, String pwd, String email, String name, String nickname, String emailHash) {
		this.id = id;
		this.pwd = pwd;
		this.email = email;
		this.name = name;
		this.nickname = nickname;
		this.emailHash = emailHash;
	}
	
}