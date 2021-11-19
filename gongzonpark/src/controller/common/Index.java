package controller.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardSecviceImpl;
import vo.Criteria;

@SuppressWarnings("serial")
@WebServlet("/index.html")
public class Index extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 게시글 리스트 - board 커뮤니티
		req.setAttribute("listCategory1", new BoardSecviceImpl().list(new Criteria(1, 6, 1)));
		
		// 게시글 리스트 - gallery 공존소식(동물)
		req.setAttribute("listCategory2", new BoardSecviceImpl().list(new Criteria(1, 3, 2)));
		
		// 페이지 이동
		req.getRequestDispatcher("WEB-INF/jsp/common/index.jsp").forward(req, resp);
		
	}

}