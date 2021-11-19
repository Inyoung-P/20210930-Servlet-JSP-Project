package controller.notice;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import service.BoardSecviceImpl;
import utill.CommonConst;
import utill.MyFileRenamePolicy;
import vo.Attach;
import vo.Board;
import vo.Member;

@SuppressWarnings("serial")
@WebServlet("/notice/modify")
public class Modify extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		Member member = (Member)session.getAttribute("member");
		
		// 관리자만 접근 가능
		if(member != null && member.getId().equals("admin")) {
			Long bno = Long.parseLong(req.getParameter("bno"));
			req.setAttribute("board", new BoardSecviceImpl().read(bno));
			req.getRequestDispatcher("/WEB-INF/jsp/notice/modify.jsp").forward(req, resp);
		}
		else {
			resp.sendRedirect(req.getContextPath()+"/errorPage");
		}
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String saveDirectory = CommonConst.UPLOAD_PATH;
		String path = getPath();
		
		File uploadPath = new File(saveDirectory + File.separator + path);
		if(!uploadPath.exists()) uploadPath.mkdirs();

		int maxPostSize = 10*1024*1024;
		String encoding = "utf-8";
		
		FileRenamePolicy policy = new MyFileRenamePolicy();
		MultipartRequest multi = new MultipartRequest(req, uploadPath.getAbsolutePath(), maxPostSize, encoding, policy);
		
		// 첨부파일 삭제 및 수정 건 개별 삭제
		String changeFile1 = multi.getParameter("changeFile1");
		String beforeFile1 = multi.getParameter("beforeFile1");
		if(changeFile1 != null && changeFile1.equals("true")) { 
			new BoardSecviceImpl().removeAttach(beforeFile1);
		}
		String changeFile2 = multi.getParameter("changeFile2");
		String beforeFile2 = multi.getParameter("beforeFile2");
		if(changeFile2 != null && changeFile2.equals("true")) {
			new BoardSecviceImpl().removeAttach(beforeFile2);
		}
		String changeFile3 = multi.getParameter("changeFile3");
		String beforeFile3 = multi.getParameter("beforeFile3");
		if(changeFile3 != null && changeFile3.equals("true")) {
			new BoardSecviceImpl().removeAttach(beforeFile3);
		}

		// 추가된 첨부파일
		Enumeration<String> files = multi.getFileNames();
		List<Attach> attachs = new ArrayList<>();
		
		while(files.hasMoreElements()) {
			String file = files.nextElement();
			String uuid = multi.getFilesystemName(file);
			if(uuid == null) continue;
			String origin = multi.getOriginalFileName(file);
			
			Attach attach = new Attach(uuid, origin, null, path);
			attachs.add(attach);
		}

		// 게시글 수정
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		Long bno = Long.parseLong(multi.getParameter("bno"));
		Board board = new Board(bno, title, content);
		board.setAttachs(attachs);
		new BoardSecviceImpl().modify(board);
		
		// 상세글로 이동
		resp.sendRedirect("detail?bno="+bno);
		
	}
	
	private String getPath() {
		return new SimpleDateFormat("yyMMdd").format(new Date());
	}	

}
