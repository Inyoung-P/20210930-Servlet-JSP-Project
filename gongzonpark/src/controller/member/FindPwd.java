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
@WebServlet("/findpwd")
public class FindPwd extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("WEB-INF/jsp/member/findPwd.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		String email = req.getParameter("email");
		Member member = null;;
		try {
			// 이메일과 일치하는 회원의 아이디가 일치하는지 확인
			member = new MemberServiceImpl().findMemberByEmail(email);
			// 일치하지 하면 임시비밀번호 이메일 발송
			if(id.equals(member.getId())) {
				SendEmail sendEmail = new SendEmail();
				String password = (new SHA256().getSHA256(id)).substring(0, 10);
				String tilte = "[공존공원] 비밀번호 찾기";
				String content = "회원님의 임시 비밀번호는 [" + password + "] 입니다. " +
								 "만약 요청한 적이 없다면 gongzonpark@gmail.com으로 이메일을 보내주세요.";
				sendEmail.send(email, tilte, content);
				
				// 임시비밀번호로 비밀번호 변경
				MemberService service = new MemberServiceImpl();
				service.modifyMemberPwd(id, password);
			}
			// 일치하지 않으면 이메일 미발송
			else {
				member = null;
			}
		}
		catch(NullPointerException e) {
			e.printStackTrace();
		}
		req.setAttribute("member", member);
		req.getRequestDispatcher("WEB-INF/jsp/member/findPwdResult.jsp").forward(req, resp);
	}
	
}
