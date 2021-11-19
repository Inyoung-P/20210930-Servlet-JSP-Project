package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.MemberService;
import service.MemberServiceImpl;
import utill.SHA256;
import utill.SendEmail;
import vo.Member;

@SuppressWarnings("serial")
@WebServlet("/join")
public class Join extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("WEB-INF/jsp/member/join.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		String pwd = req.getParameter("pwd");
		String email = req.getParameter("email");
		String name = req.getParameter("name");
		String nickname = req.getParameter("nickname");
		String emailHash = (new SHA256().getSHA256(email)).substring(0, 20);
		
		// 회원가입
		Member member = new Member(id, pwd, email, name, nickname, emailHash);
		MemberService service = new MemberServiceImpl();
		service.join(member);
		
		// 이메일 인증 요청 메일 발송
		SendEmail sendEmail = new SendEmail();
		String host = "http://jsp.llrayall.com/";
		String tilte = "[공존공원] 회원가입을 완료해 주세요.";
		String content = "공존공원 회원으로 가입해 주셔서 감사합니다. " +
						 "링크를 눌러 이메일 인증을 완료하세요. " +
						 host + "checkemail?hashcode=" + emailHash +
						 " 만약 요청한 적이 없다면 gongzonpark@gmail.com으로 이메일을 보내주세요.";
		sendEmail.send(email, tilte, content);
		resp.sendRedirect("welcome");
	}
	
}
