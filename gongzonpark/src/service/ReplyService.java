package service;

import java.util.List;

import vo.Reply;

public interface ReplyService {

	// 댓글 쓰기
	void write(Reply reply);
	
	// 댓글 목록
	List<Reply> list(Long bno);

	// 댓글 삭제
	void remove(Long rno);

	// 게시글 삭제 시 해당 댓글 삭제
	void removeReplies(Long bno);
	
	// 탈퇴회원의 댓글 id 수정
	void modifyId(String id);
	
}
