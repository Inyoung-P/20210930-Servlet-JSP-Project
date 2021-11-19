package service;

import vo.Member;

public class MemberServiceTests {

	private static MemberService service = new MemberServiceImpl();
	
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
		testModifyMemberPwd();
		
		// 이메일 수정
		testModifyMemberEmail();
		
		// 별명 수정
		testModifyMemberNickname();
		
		// 프로필 수정
		testModifyProfile();
		
		// 회원 탈퇴
		testLeave();
	}
	
	// 회원가입
	public static void testJoin()  {
		service.join(new Member("id", "pwd", "email", "name", "nickname", "emailHash"));
	}
	
	// 이메일인증
	public static void testCheckEmail() {
		service.checkEmail("emailHash");
	}
	
	// 로그인
	public static void testLogin() {
		System.out.println(service.login("id", "pwd"));
	}

	// 회원찾기(id)
	public static void testFindMemberById() {
		System.out.println(service.findMemberById("id"));
	}
	
	// 회원찾기(email)
	public static void testFindMemberByEmail() {
		System.out.println(service.findMemberByEmail("email"));
	}
	
	// 회원찾기(nickname)
	public static void testFindMemberByNickname() {
		System.out.println(service.findMemberByNickname("nickname"));
	}
	
	// 비밀번호 수정
	public static void testModifyMemberPwd() {
		System.out.println(service.findMemberById("id"));
		service.modifyMemberPwd("id", "pwd2");
		System.out.println(service.findMemberById("id"));
	}
		
	// 이메일 수정
	public static void testModifyMemberEmail() {
		System.out.println(service.findMemberById("id"));
		service.modifyMemberEmail("id", "email2", "emailHash2");
		System.out.println(service.findMemberById("id"));
	}
	
	// 별명 수정
	public static void testModifyMemberNickname() {
		System.out.println(service.findMemberById("id"));
		service.modifyMemberNickname("id", "nickname2");
		System.out.println(service.findMemberById("id"));
	}
	
	// 프로필 수정
	public static void testModifyProfile() {
		System.out.println(service.findMemberById("id"));
		service.modifyProfile("id", "uuid2");
		System.out.println(service.findMemberById("id"));
	}
	
	// 회원 탈퇴
	public static void testLeave() {
		service.leave("id");
		System.out.println(service.findMemberById("id"));
	}
	
}
