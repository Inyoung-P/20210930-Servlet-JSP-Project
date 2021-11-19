package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//비밀번호 유효성 검사

@SuppressWarnings("serial")
@WebServlet("/pwdValid")
public class PwdValid extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String pwd = req.getParameter("pwd");
		int result = 0;
		if (!('a' <= pwd.charAt(0) && pwd.charAt(0) <= 'z' || 'A' <= pwd.charAt(0) && pwd.charAt(0) <= 'Z')) result = 1;	// 영문 시작
		else if (!(8 <= pwd.length() && pwd.length() <= 16)) result = 2;													// 8~16자 이내
		else {																												// 영문, 숫자만 사용
			for (int i = 0; i < pwd.length(); i++) {
				if(!('a' <= pwd.charAt(i) && pwd.charAt(i) <= 'z' || '0' <= pwd.charAt(i) && pwd.charAt(i) <= '9' || 'A' <= pwd.charAt(0) && pwd.charAt(0) <= 'Z'))
					result = 3;
			}
		}
		resp.getWriter().print(result);
	}

}
