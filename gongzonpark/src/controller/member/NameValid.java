package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.MemberServiceImpl;

// 이름 유효성 검사

@SuppressWarnings("serial")
@WebServlet("/nameValid")
public class NameValid extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String name = req.getParameter("name");
		int result = 0;
		if (!(2 <= name.length() && name.length() <= 20)) result = 1;			// 2~20자 이내
		else {																	// 영문, 한글만 사용
			for (int i = 0; i < name.length(); i++) {			
				if(!('a' <= name.charAt(i) && name.charAt(i) <= 'z' || 'A' <= name.charAt(i) && name.charAt(i) <= 'Z' || '가' <= name.charAt(i) && name.charAt(i) <= '힣'))
					result = 2;
			}
		}
		resp.getWriter().print(result);
		
	}
		
}
