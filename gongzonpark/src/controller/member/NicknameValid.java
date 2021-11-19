package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.MemberServiceImpl;

// 닉네임 유효성 검사

@SuppressWarnings("serial")
@WebServlet("/nicknameValid")
public class NicknameValid extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String nickname = req.getParameter("nickname");
		int result = 0;
		if (new MemberServiceImpl().findMemberByNickname(nickname) != null) result = 1;			// 중복 검사
		else if (!(2 <= nickname.length() && nickname.length() <= 10)) result = 2;		// 2~10자 이내
		else {																			// 영문, 숫자, 한글만 사용
			for (int i = 0; i < nickname.length(); i++) {
				if(!('a' <= nickname.charAt(i) && nickname.charAt(i) <= 'z' || 'A' <= nickname.charAt(i) && nickname.charAt(i) <= 'Z' ||'0' <= nickname.charAt(i) && nickname.charAt(i) <= '9' || '가' <= nickname.charAt(i) && nickname.charAt(i) <= '힣'))
					result = 3;
			}
		}
		resp.getWriter().print(result);
		
	}
		
}
