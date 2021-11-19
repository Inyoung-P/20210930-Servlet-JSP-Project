package service;

import vo.Member;

public interface MemberService {
	
	// 회원가입
	void join(Member member);
	
	// 이메일인증
	void checkEmail(String hashcode);
	
	// 로그인
	boolean login(String id, String pwd);

	// 회원찾기(id)
	Member findMemberById(String id);
	
	// 회원찾기(email)
	Member findMemberByEmail(String email);
	
	// 회원찾기(nickname)
	Member findMemberByNickname(String nickname);
	
	// 비밀번호 수정
	void modifyMemberPwd(String id, String pwd);
		
	// 이메일 수정
	void modifyMemberEmail(String id, String email, String emailHash);
	
	// 별명 수정
	void modifyMemberNickname(String id, String nickname);
	
	// 프로필 수정
	void modifyProfile(String id, String uuid);
	
	// 회원 탈퇴
	void leave(String id);
		
}