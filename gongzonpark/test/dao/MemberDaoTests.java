package dao;

import vo.Member;

public class MemberDaoTests {

	static MemberDao dao = new MemberDao();
	
	public static void main(String[] args) {
		
		// 회원가입
		testJoin();
		
		// 이메일인증
		testCheckEmail();

		// 로그인
		testLogin();
		
		// 회원찾기(id)
		testFindMemberById();
		
		// 회원찾기(email)
		testFindMemberByEmail();
		
		// 회원찾기(nickname)
		testFindMemberByNickname();
		
		// 비밀번호 수정
		testUpdateMemberPwd();

		// 이메일 수정
		testUpdateMemberEmail();
		
		// 별명 수정
		testUpdateMemberNickname();	
		
		// 별명 수정
		testUpdateProfile();

		// 회원탈퇴
		testUpdateMember();
	}
	
	// 회원가입
	public static void testJoin() {
		dao.join(new Member("idid", "pwd", "email", "name", "nickname", "emailhash"));
	}
	
	// 이메일인증
	public static void testCheckEmail() {
		dao.checkEmail("emailhash");
	}

	// 로그인
	public static void testLogin() {
		System.out.println(dao.login("idid", "pwd"));
	}

	// 회원찾기(id)
	public static void testFindMemberById() {
		System.out.println(dao.findMemberById("idid"));
	}
	
	// 회원찾기(email)
	public static void testFindMemberByEmail() {
		System.out.println(dao.findMemberByEmail("email"));
	}
	
	// 회원찾기(nickname)
	public static void testFindMemberByNickname() {
		System.out.println(dao.findMemberByNickname("nickname"));
	}
	
	// 비밀번호 수정
	public static void testUpdateMemberPwd() {
		dao.updateMemberPwd("idid", "pwdpwd");
		System.out.println(dao.findMemberById("idid"));
	}	

	// 이메일 수정
	public static void testUpdateMemberEmail() {
		dao.updateMemberEmail("idid", "emailemail", "emailHashemailHash");
		System.out.println(dao.findMemberById("idid"));
	}
	
	// 별명 수정
	public static void testUpdateMemberNickname() {
		dao.updateMemberNickname("idid", "nicknamenickname");
		System.out.println(dao.findMemberById("idid"));
		
	}
	
	// 별명 수정
	public static void testUpdateProfile() {
		dao.updateProfile("idid", "uuiduuid");
		System.out.println(dao.findMemberById("idid"));
	}

	// 회원탈퇴
	public static void testUpdateMember() {
		dao.updateMember("idid");
	}
}
