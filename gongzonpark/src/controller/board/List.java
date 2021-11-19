package controller.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardSecvice;
import service.BoardSecviceImpl;
import vo.Criteria;
import vo.PageDTO;

@SuppressWarnings("serial")
@WebServlet("/board/list")
public class List extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 한 페이지에 보일 게시글 수
		String pn = req.getParameter("pageNum");
		String am = req.getParameter("amount");
		
		if(pn == null || pn == "") pn = "1";
		if(am == null || am == "") am = "10";
		
		BoardSecvice service = new BoardSecviceImpl();
		Criteria cri = new Criteria(Integer.parseInt(pn), Integer.parseInt(am));
		
		// 게시글 리스트
		req.setAttribute("list", service.list(cri));
		
		// 페이지
		req.setAttribute("page", new PageDTO(service.getCount(cri), cri));
		
		req.getRequestDispatcher("/WEB-INF/jsp/board/list.jsp").forward(req, resp);
	}
	
}
