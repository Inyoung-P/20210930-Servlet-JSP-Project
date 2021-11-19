package controller.reply;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import service.ReplyServiceImpl;
import vo.Reply;

@SuppressWarnings("serial")
@WebServlet("/reply/list")
public class ReplyList extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String b = req.getParameter("bno");
		Long bno = Long.parseLong(b);
		List<Reply> replies = new ReplyServiceImpl().list(bno);
		Gson gson = new Gson();
		String json = gson.toJson(replies);
		resp.setContentType("application/json");
		resp.setCharacterEncoding("utf-8");
		resp.getWriter().print(json);
	}

}
