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

@SuppressWarnings("serial")
@WebServlet("/modifyNickname")
public class ModifyNickname extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String id = req.getParameter("id");
		String nickname = req.getParameter("nickname");
		String newNickname = req.getParameter("newNickname");
		int result = 0;
		MemberService service = new MemberServiceImpl();
		
		// 새 별명과 현재 별명 일치 검사
		if(nickname.equals(newNickname)) result = 1;
		// 새 별명 이미 등록된 별명인지 검사
		else if(service.findMemberByNickname(newNickname) != null) result = 2;
		// 별명 유효성 검사
		else if(checkNewNickname(newNickname) != 0) result = checkNewNickname(newNickname);
		// 별명 수정
		else {
			service.modifyMemberNickname(id, newNickname);
			HttpSession session = req.getSession();
			session.setAttribute("member", service.findMemberById(id));
			result = 5;
			
		}
		resp.getWriter().print(result);
		
	}
	
	// 별명 유효성 검사
	private int checkNewNickname(String newNickname) {
		int result = 0;
		// 2~10자 이내인지 검사
		if (!(2 <= newNickname.length() && newNickname.length() <= 10)) result = 3;
		// 영문, 숫자, 한글만 사용했는지 검사
		else {
			for (int i = 0; i < newNickname.length(); i++) {
				if(!('a' <= newNickname.charAt(i) && newNickname.charAt(i) <= 'z' || 'A' <= newNickname.charAt(i) && newNickname.charAt(i) <= 'Z' ||'0' <= newNickname.charAt(i) && newNickname.charAt(i) <= '9' || '가' <= newNickname.charAt(i) && newNickname.charAt(i) <= '힣'))
					result = 4;
			}
		}
		return result;
	}

}
