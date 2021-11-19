package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.tribes.membership.MemberImpl;

import service.MemberService;
import service.MemberServiceImpl;
import vo.Member;

@SuppressWarnings("serial")
@WebServlet("/logout")
public class Logout extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String url = req.getParameter("url");
		String[] urls = {"http://jsp.llrayall.com/checkmember"
				, "http://jsp.llrayall.com/mypage"
				, "http://jsp.llrayall.com/withdrawal"
				, "http://jsp.llrayall.com/gallery/write"
				, "http://jsp.llrayall.com/board/write"};

		for (int i = 0; i < urls.length; i++) {
			if(url.equals(urls[i])) url = "index.html";
		}			
		
		req.getSession().invalidate();
		resp.sendRedirect(url);
	}

}
