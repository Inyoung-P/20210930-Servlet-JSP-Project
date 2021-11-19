package utill;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardSecvice;
import service.BoardSecviceImpl;

@SuppressWarnings("serial")
@WebServlet("/download")
public class FileDownload extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String fileName = req.getParameter("filename");
		String saveDirectory = CommonConst.UPLOAD_PATH;
		String filePath = saveDirectory + File.separator + fileName;
		FileInputStream fis = new FileInputStream(filePath);
		String mimeType = getServletContext().getMimeType(filePath);
		if(mimeType == null) mimeType = "application/octet-stream";
		String userAgent = req.getHeader("User-Agent");
		BoardSecvice secvice = new BoardSecviceImpl();
		fileName = secvice.findOriginBy(fileName.substring(fileName.indexOf("/")+1));
		if(userAgent.toLowerCase().contains("trident")) {
			fileName = URLEncoder.encode(fileName, "utf-8").replace("\\+", "%20");
		}
		else {
			fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
		}
		resp.setContentType(mimeType);
		resp.setHeader("Content-DisPosition", "attachment; filename=" + fileName);
		ServletOutputStream sos = resp.getOutputStream();
		int b;
		while((b = fis.read()) != -1) {
			sos.write(b);
		}
		fis.close();
		sos.close();
	}
	
}
