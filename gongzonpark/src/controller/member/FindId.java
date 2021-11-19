package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.MemberServiceImpl;
import vo.Member;

@SuppressWarnings("serial")
@WebServlet("/findid")
public class FindId extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("WEB-INF/jsp/member/findId.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		Member member = null;;
		try {
			member = new MemberServiceImpl().findMemberByEmail(email);
			if(!name.equals(member.getName()))
				member = null;
		}
		catch(NullPointerException e) {
			e.printStackTrace();
		}
		req.setAttribute("member", member);
		req.getRequestDispatcher("WEB-INF/jsp/member/findIdResult.jsp").forward(req, resp);
	}

}
