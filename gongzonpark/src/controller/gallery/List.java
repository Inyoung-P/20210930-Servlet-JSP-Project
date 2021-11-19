package controller.gallery;

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
@WebServlet("/gallery/list")
public class List extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		BoardSecvice service = new BoardSecviceImpl();
		String pn = req.getParameter("pageNum");
		String am = req.getParameter("amount");
		if(pn == null) pn = "1";
		if(am == null) am = "6";
		Criteria cri = new Criteria(Integer.parseInt(pn), Integer.parseInt(am), 2);
		req.setAttribute("list", service.list(cri));
		req.setAttribute("page", new PageDTO(service.getCount(cri), cri));
		req.getRequestDispatcher("/WEB-INF/jsp/gallery/list.jsp").forward(req, resp);
	}
	
}
