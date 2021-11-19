package dao;

import vo.Reply;

public class ReplyDaoTests {

	static ReplyDao dao = new ReplyDao(); 
	
	public static void main(String[] args) {
		
		// 댓글 조회
		testList();
		
		// 댓글 삭제
		testDelete();
		
		// 댓글들 삭제 - 게시글 삭제시
		testDeleteReplies();
		
		// 댓글 작성
		testInsert();
		
		// 탈퇴회원의 댓글 id 수정
		testUpdateId();
	}
	
	// 댓글 조회
	public static void testList() {
		dao.list(8L).forEach(System.out::println);
	}

	// 댓글 삭제
	public static void testDelete() {
		dao.delete(5L);
		dao.list(8L).forEach(System.out::println);
	}

	// 댓글들 삭제 - 게시글 삭제시
	public static void testDeleteReplies() {
		dao.deleteReplies(8L);
		dao.list(8L).forEach(System.out::println);
	}	
	
	// 댓글 작성
	public static void testInsert() {
		dao.insert(new Reply("content", "id", 8L));
		dao.list(8L).forEach(System.out::println);
	}

	// 탈퇴회원의 댓글 id 수정
	public static void testUpdateId() {
		dao.updateId("id");
		dao.list(8L).forEach(System.out::println);
	}
}
