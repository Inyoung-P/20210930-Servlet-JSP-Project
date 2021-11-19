package controller.member;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.MemberService;
import service.MemberServiceImpl;

@SuppressWarnings("serial")
@WebServlet("/login")
public class Login extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("WEB-INF/jsp/member/login.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String url = req.getParameter("url");
		if(url == null) url = "index.html";
		String id = req.getParameter("id");
		String pwd = req.getParameter("pwd");
		MemberService service = new MemberServiceImpl();
		boolean success = service.login(id, pwd);
		
		if(success) {
			HttpSession session = req.getSession();
			session.setAttribute("member", service.findMemberById(id));
			Cookie cookie = new Cookie("savedId", id);
			cookie.setMaxAge((req.getParameter("savedId") == null) ? 0 : 60*60*24*365);
			resp.addCookie(cookie);
			
			String[] urls = {""
							,"http://jsp.llrayall.com/findid"
							, "http://jsp.llrayall.com/findpwd"
							, "http://jsp.llrayall.com/contract"
							, "http://jsp.llrayall.com/join"
							, "http://jsp.llrayall.com/login"
							, "http://jsp.llrayall.com/CheckEmail"
							, "http://jsp.llrayall.com/Welcome"};
			
			for (int i = 0; i < urls.length; i++) {
				if(url.equals(urls[i])) url = "index.html";
			}			
			
			resp.sendRedirect(url);
		}
		else {
			String msg = "fail";
			resp.sendRedirect("login?url=" + url + "&msg=" + URLEncoder.encode(msg, "utf-8"));
		}
	}
	
}
