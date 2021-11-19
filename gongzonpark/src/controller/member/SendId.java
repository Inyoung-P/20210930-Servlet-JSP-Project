package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utill.SendEmail;

@SuppressWarnings("serial")
@WebServlet("/sendId")
public class SendId extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 로그인한 회원의 이메일 정보 불러오기
		String id = req.getParameter("id");
		String email = req.getParameter("email");
		
		// 이메일 인증 요청 메일 발송
		SendEmail sendEmail = new SendEmail();
		String tilte = "[공존공원] 아이디 찾기";
		String content = "회원님의 아이디는 [ " + id + " ] 입니다. " +
						 "만약 요청한 적이 없다면 gongzonpark@gmail.com으로 이메일을 보내주세요.";
		sendEmail.send(email, tilte, content);
		
	}
	
}
