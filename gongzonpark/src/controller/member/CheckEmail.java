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
import vo.Member;

@SuppressWarnings("serial")
@WebServlet("/checkemail")
public class CheckEmail extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 이메일 인증
		String hashcode = req.getParameter("hashcode");
		MemberService service = new MemberServiceImpl();
		service.checkEmail(hashcode);
		
		// 해당 이메일의 회원이 로그인 중
		// 같은 브라우저로 이메일 인증을 했다면 인증 결과가 바로 반영
		HttpSession session = req.getSession();
		Member member = (Member)session.getAttribute("member");
		if(member != null) {
			if(member.getEmailHash().equals(hashcode)) {
				session.setAttribute("member", service.findMemberById(member.getId()));
			}
		}
		req.getRequestDispatcher("WEB-INF/jsp/member/checkEmail.jsp").forward(req, resp);
		
	}
	
}
