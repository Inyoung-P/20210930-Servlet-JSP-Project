package utill;

public class SHA256Tests {

	public static void main(String[] args) {
		testGetSHA256();
	}
	
	// 이메일 인증을 위한 emailHash 생성
	public static void testGetSHA256() {
		System.out.println(SHA256.getSHA256("llrayall@naver.com"));
	}
	
}
