package controller.member;

import java.io.IOException;

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
@WebServlet("/modifyPwd")
public class ModifyPwd extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String id = req.getParameter("id");
		String pwd = req.getParameter("pwd");
		String newPwd = req.getParameter("newPwd");
		String newPwdCk = req.getParameter("newPwdCk");
		int result = 0;
		
		// 새 비밀번호 유효성 검사
		if(checkNewPwd(pwd, newPwd) != 0) result = checkNewPwd(pwd, newPwd);
		// 새 비밀번호 재확인 일치 검사
		else if(!newPwd.equals(newPwdCk)) result = 5;
		// 비밀번호 수정
		else {
			MemberService service = new MemberServiceImpl();
			service.modifyMemberPwd(id, newPwd);
			HttpSession session = req.getSession();
			session.setAttribute("member", service.findMemberById(id));
			result = 6;
		}
		resp.getWriter().print(result);
	}
	
	// 새 비밀번호 유효성 검사 메서드
	private int checkNewPwd(String pwd, String newPwd) {
		int result = 0;
		// 현재 비밀번호와 일치 여부 확인
		if(pwd.equals(newPwd)) result = 1;
		// 영문으로 시작하는지 확인
		else if (!('a' <= newPwd.charAt(0) && newPwd.charAt(0) <= 'z' || 'A' <= newPwd.charAt(0) && newPwd.charAt(0) <= 'Z')) result = 2;
		// 8~16자 이내인지 확인
		else if (!(8 <= newPwd.length() && newPwd.length() <= 16)) result = 3;
		// 영문, 숫자만 사용했는지 확인
		else {
			for (int i = 0; i < newPwd.length(); i++) {
				if(!('a' <= newPwd.charAt(i) && newPwd.charAt(i) <= 'z' || '0' <= newPwd.charAt(i) && newPwd.charAt(i) <= '9' || 'A' <= newPwd.charAt(0) && newPwd.charAt(0) <= 'Z'))
					result = 4;
			}
		}
		return result;
	}
	
}