package utill;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/display")
public class Display extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String fileName = req.getParameter("filename");
		String saveDirectory = CommonConst.UPLOAD_PATH;
		
		String filePath = saveDirectory + File.separator + fileName;
		FileInputStream fis = new FileInputStream(filePath);
		String mimeType = getServletContext().getMimeType(filePath);
		if(mimeType == null) mimeType = "application/octet-stream";
		resp.setContentType(mimeType);
		ServletOutputStream sos = resp.getOutputStream();
		int b;
		while((b = fis.read()) != -1) {
			sos.write(b);
		}
		fis.close();
		sos.close();
	}
	
}
