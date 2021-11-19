package controller.reply;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import service.ReplyService;
import service.ReplyServiceImpl;
import vo.Reply;

@SuppressWarnings("serial")
@WebServlet("/reply")
public class ReplyController extends HttpServlet {

	private ReplyService service = new ReplyServiceImpl();
	private Gson gson = new Gson();
	
	// 댓글 작성
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String jsonData = req.getParameter("jsonData");
		Reply reply = gson.fromJson(jsonData, Reply.class);
		service.write(reply);
	}

	// 댓글 삭제
	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Long rno = Long.parseLong(req.getParameter("rno"));
		service.remove(rno);
	}
}
