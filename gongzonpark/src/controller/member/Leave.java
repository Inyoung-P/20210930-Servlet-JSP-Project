package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardSecviceImpl;
import service.MemberServiceImpl;
import service.ReplyServiceImpl;

@SuppressWarnings("serial")
@WebServlet("/leave")
public class Leave extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("WEB-INF/jsp/member/leave.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 탈퇴할 아이디
		String id = req.getParameter("id");
		
		// 해당 아이디가 작성한 게시글의 id를 탈퇴회원 전용 id로 변경
		new BoardSecviceImpl().modifyId(id);

		// 해당 아이디가 작성한 댓글의 id를 탈퇴회원 전용 id로 변경
		new ReplyServiceImpl().modifyId(id);
		
		// 해당 아이디의 기본정보 전부 NULL 처리
		new MemberServiceImpl().leave(id);
		
		// 로그아웃
		req.getSession().invalidate();
		
	}
	
}
