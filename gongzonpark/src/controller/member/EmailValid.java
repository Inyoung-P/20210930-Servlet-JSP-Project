package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.MemberServiceImpl;

//이메일 유효성 검사

@SuppressWarnings("serial")
@WebServlet("/emailValid")
public class EmailValid extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String email = req.getParameter("email");
		int result = new MemberServiceImpl().findMemberByEmail(email) == null ? 0 : 1;
		
		resp.getWriter().print(result);
	}

}
