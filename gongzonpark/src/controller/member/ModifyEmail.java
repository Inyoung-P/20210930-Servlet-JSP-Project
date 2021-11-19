package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.MemberService;
import service.MemberServiceImpl;
import utill.SHA256;
import utill.SendEmail;

@SuppressWarnings("serial")
@WebServlet("/modifyEmail")
public class ModifyEmail extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		String email = req.getParameter("email");
		String newEmail = req.getParameter("newEmail");
		int result = 0;
		MemberService service = new MemberServiceImpl();
		
		// 새 이메일과 현재 이메일 일치 검사
		if(email.equals(newEmail)) result = 1;
		// 새 이메일 이미 등록된 이메일인지 검사
		else if(service.findMemberByEmail(newEmail) != null) result = 2;
		// 새 이메일에 @가 있는지 검사
		else if(!checkAd(newEmail)) result = 3;
		// 새 이메일에 @ 뒤로 .이 있는지 검사
		else if(!checkDot(newEmail)) result = 4;
		else {
			// DB 상의 이메일 주소 수정
			String emailHash = (new SHA256().getSHA256(email)).substring(0, 20);
			service.modifyMemberEmail(id, newEmail, emailHash);
			// 세션의 이메일 주소 수정
			HttpSession session = req.getSession();
			session.setAttribute("member", service.findMemberById(id));
			// 인증메일 발송
			SendEmail sendEmail = new SendEmail();
			String host = "http://jsp.llrayall.com/";
			String tilte = "[공존공원] 수정하신 이메일을 인증해 주세요. ";
			String content = "아래의 링크를 눌러 이메일 인증을 완료하세요. " +
							 host + "checkemail?hashcode=" + emailHash +
							 " 만약 요청한 적이 없다면 gongzonpark@gmail.com으로 이메일을 보내주세요.";
			sendEmail.send(newEmail, tilte, content);
			
			result = 5;
		}
		resp.getWriter().print(result);
	}
	
	// 새 이메일에 @가 있는지 검사
	private boolean checkAd(String newEmail) {
		for (int i = 0; i < newEmail.length(); i++) {
			if(newEmail.charAt(i) == '@') return true;
		}
		return false;
	}
	
	// 새 이메일에 @ 뒤로 .이 있는지 검사
	private boolean checkDot(String newEmail) {
		int adIndex = newEmail.indexOf('@');
		for (int i = adIndex; i < newEmail.length(); i++) {
			if(newEmail.charAt(i) == '.') return true;
		}
		return false;
	}
}
