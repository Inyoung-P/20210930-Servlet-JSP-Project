package utill;

public class SendEmailTests {

	public static void main(String[] args) {
		testSend(); // 입력한 메일 주소에서 발송 결과 확인
	}
	
	// 이메일 보내기
	public static void testSend() {
		SendEmail sendEmail = new SendEmail();
		sendEmail.send("llrayall@naver.com", "테스트 메일 제목", "테스트 메일 내용");
	}
	
}
