package service;

import dao.MemberDao;
import vo.Member;

public class MemberServiceImpl implements MemberService {

	private MemberDao dao = new MemberDao();

	// 회원가입
	@Override
	public void join(Member member) {
		dao.join(member);
	}
	
	// 이메일인증
	@Override
	public void checkEmail(String hashcode) {
		dao.checkEmail(hashcode);
	}

	// 로그인
	@Override
	public boolean login(String id, String pwd) {
		return dao.login(id, pwd);
	}
	
	// 회원찾기(id)
	@Override
	public Member findMemberById(String id) {
		return dao.findMemberById(id);
	}
	
	// 회원찾기(email)
	@Override
	public Member findMemberByEmail(String email) {
		return dao.findMemberByEmail(email);
	}	
	
	// 회원찾기(nickname)
	@Override
	public Member findMemberByNickname(String nickname) {
		return dao.findMemberByNickname(nickname);
	}
	
	// 비밀번호 수정
	@Override
	public void modifyMemberPwd(String id, String pwd) {
		dao.updateMemberPwd(id, pwd);
	}
	
	// 이메일 수정
	@Override
	public void modifyMemberEmail(String id, String email, String emailHash) {
		dao.updateMemberEmail(id, email, emailHash);
	}
	
	// 별명 수정
	@Override
	public void modifyMemberNickname(String id, String nickname) {
		dao.updateMemberNickname(id, nickname);
	}

	// 프로필 수정
	@Override
	public void modifyProfile(String id, String uuid) {
		dao.updateProfile(id, uuid);
	}

	// 회원 탈퇴
	@Override
	public void leave(String id) {
		dao.updateMember(id);
	}
	
}

