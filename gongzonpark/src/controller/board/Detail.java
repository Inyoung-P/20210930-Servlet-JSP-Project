package controller.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardSecviceImpl;

@SuppressWarnings("serial")
@WebServlet("/board/detail")
public class Detail extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 글 번호
		Long bno = Long.parseLong(req.getParameter("bno"));
		
		// 게시글 조회
		req.setAttribute("board", new BoardSecviceImpl().read(bno));
		
		// 글 목록 위치 
		String pn = req.getParameter("pageNum");
		String am = req.getParameter("amount");
		if(pn == null) pn = "1";
		if(am == null) am = "10";
		req.setAttribute("pageNum", pn);
		req.setAttribute("amount", am);
		
		// 페이지 이동
		req.getRequestDispatcher("/WEB-INF/jsp/board/detail.jsp").forward(req, resp);
		
	}
	
}
