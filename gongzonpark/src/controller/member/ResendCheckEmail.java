package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.MemberService;
import service.MemberServiceImpl;
import utill.SendEmail;
import vo.Member;

@SuppressWarnings("serial")
@WebServlet("/resendCheckEmail")
public class ResendCheckEmail extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 로그인한 회원의 이메일 정보 불러오기
		String id = req.getParameter("id");
		MemberService service = new MemberServiceImpl();
		Member member = service.findMemberById(id);
		String emailHash = member.getEmailHash();
		String email = member.getEmail();
		
		// 이메일 인증 요청 메일 발송
		SendEmail sendEmail = new SendEmail();
		String host = "http://jsp.llrayall.com/";
		String tilte = "[공존공원] 이메일 인증 재발송";
		String content = "링크를 눌러 이메일 인증을 완료하세요." +
						 host + "checkemail?hashcode=" + emailHash +
						 " 만약 요청한 적이 없다면 gongzonpark@gmail.com으로 이메일을 보내주세요.";
		sendEmail.send(email, tilte, content);
	}
	
}
