package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.MemberServiceImpl;

//아이디 유효성 검사

@SuppressWarnings("serial")
@WebServlet("/idValid")
public class IdValid extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String id = req.getParameter("id");
		
		int result = 0;
		
		if (new MemberServiceImpl().findMemberById(id) != null) result = 1;		// 중복 검사
		else if (!('a' <= id.charAt(0) && id.charAt(0) <= 'z')) result = 2;		// 영문 소문자 시작
		else if (!(5 <= id.length() && id.length() <= 15)) result = 3;			// 5~15자 이내
		else {																	// 영문 소문자, 숫자만 사용
			for (int i = 0; i < id.length(); i++) {
				if(!('a' <= id.charAt(i) && id.charAt(i) <= 'z' || '0' <= id.charAt(i) && id.charAt(i) <= '9'))
					result = 4;
			}
		}
		resp.getWriter().print(result);
		
	}
		
}
