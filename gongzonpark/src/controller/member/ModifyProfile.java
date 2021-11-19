package controller.member;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import net.coobird.thumbnailator.Thumbnailator;
import service.MemberService;
import service.MemberServiceImpl;
import utill.CommonConst;
import utill.MyFileRenamePolicy;
import vo.Member;

//아이디 유효성 검사

@SuppressWarnings("serial")
@WebServlet("/modifyProfile")
public class ModifyProfile extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String saveDirectory = CommonConst.UPLOAD_PATH;
		String path = "profileImg";
		
		File uploadPath = new File(saveDirectory + File.separator + path);
		if(!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		int maxPostSize = 10*1024*1024;
		String encoding = "utf-8";
		
		FileRenamePolicy policy = new MyFileRenamePolicy();
		MultipartRequest multi = new MultipartRequest(req, uploadPath.getAbsolutePath(), maxPostSize, encoding, policy);
		
		Enumeration<String> files = multi.getFileNames();

		String file = files.nextElement();
		String uuid = multi.getFilesystemName(file);
		
		FileInputStream fis = new FileInputStream(uploadPath.getAbsolutePath() + "\\" + uuid);
		FileOutputStream fos = new FileOutputStream(uploadPath.getAbsolutePath() + "\\s_" + uuid);
		Thumbnailator.createThumbnail(fis, fos, 250, 250);
		
		String id = ((Member)req.getSession().getAttribute("member")).getId();
		MemberService service = new MemberServiceImpl();
		service.modifyProfile(id, uuid);
		
		HttpSession session = req.getSession();
		session.setAttribute("member", service.findMemberById(id));
		
	}

}
