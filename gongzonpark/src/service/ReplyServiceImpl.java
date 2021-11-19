package service;

import java.util.List;

import dao.ReplyDao;
import vo.Reply;

public class ReplyServiceImpl implements ReplyService {
	
	private ReplyDao dao = new ReplyDao();

	// 댓글 쓰기
	@Override
	public void write(Reply reply) {
		dao.insert(reply);
	}
	
	// 댓글 목록
	@Override
	public List<Reply> list(Long bno) {
		return dao.list(bno);
	}

	// 댓글 삭제
	@Override
	public void remove(Long rno) {
		dao.delete(rno);
	}

	// 게시글 삭제 시 해당 댓글 삭제
	@Override
	public void removeReplies(Long bno) {
		dao.deleteReplies(bno);
	}

	// 탈퇴회원의 댓글 id 수정
	public void modifyId(String id) {
		dao.updateId(id);
	}

	

}
