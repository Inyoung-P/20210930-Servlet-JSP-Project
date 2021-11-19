package controller.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.BoardSecviceImpl;
import service.ReplyServiceImpl;
import vo.Member;

@SuppressWarnings("serial")
@WebServlet("/board/delete")
public class Delete extends HttpServlet {

	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		Member member = (Member)session.getAttribute("member");
		
		Long bno = Long.parseLong(req.getParameter("bno"));
		String writer = new BoardSecviceImpl().findWriterBy(bno);
		
		// 작성자만 접근 가능
		if(member != null && member.getId().equals(writer)) {
			// 댓글 삭제
			new ReplyServiceImpl().removeReplies(bno);
			// 첨부 파일 삭제
			new BoardSecviceImpl().removeAttachs(bno);
			// 글 삭제
			new BoardSecviceImpl().remove(bno);
		}
		else {
			resp.sendRedirect(req.getContextPath()+"/errorPage");
		}
		
	}
	
}
