package controller.gallery;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
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

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import net.coobird.thumbnailator.Thumbnailator;
import service.BoardSecviceImpl;
import utill.CommonConst;
import utill.MyFileRenamePolicy;
import vo.Attach;
import vo.Board;
import vo.Member;

@SuppressWarnings("serial")
@WebServlet("/gallery/write")
public class Write extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/WEB-INF/jsp/gallery/write.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String saveDirectory = CommonConst.UPLOAD_PATH;
		String path = getPath();
		
		File uploadPath = new File(saveDirectory + File.separator + path);
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		int maxPostSize = 10*1024*1024;
		String encoding = "utf-8";
		
		FileRenamePolicy policy = new MyFileRenamePolicy();
		MultipartRequest multi = new MultipartRequest(req, uploadPath.getAbsolutePath(), maxPostSize, encoding, policy);
		Enumeration<String> files = multi.getFileNames();
		List<Attach> attachs = new ArrayList<>();
		while(files.hasMoreElements()) {
			String file = files.nextElement();
			String uuid = multi.getFilesystemName(file);
			if(uuid == null) continue;
			String origin = multi.getOriginalFileName(file);
			
			Attach attach = new Attach(uuid, origin, null, path);
			attachs.add(attach);
			
			// thumbnail
			FileInputStream fis = new FileInputStream(uploadPath.getAbsolutePath() + "\\" + uuid);
			FileOutputStream fos = new FileOutputStream(uploadPath.getAbsolutePath() + "\\s_" + uuid);
			Thumbnailator.createThumbnail(fis, fos, 350, 260);
		}
		
		String title = multi.getParameter("title");
		String content = multi.getParameter("content");
		String id = ((Member)req.getSession().getAttribute("member")).getId();
	
		Board board = new Board(title, content, id, 2L);
		board.setAttachs(attachs);
		Long bno = new BoardSecviceImpl().write(board);
		resp.sendRedirect("detail?bno="+bno);
	}
	
	private String getPath() {
		return new SimpleDateFormat("yyMMdd").format(new Date());
	}
}
