package service;

import vo.Reply;

public class ReplyServiceTests {

	static ReplyService service = new ReplyServiceImpl();
	
	public static void main(String[] args) {
		
		// 댓글 쓰기
		testWrite();
		
		// 댓글 목록
		testList();
		
		// 댓글 삭제
		testRemove();
		
		// 게시글 삭제 시 해당 댓글 삭제
		testRemoveReplies();
		
		// 탈퇴회원의 댓글 id 수정
		testModifyId();
	}
	
	// 댓글 쓰기
	public static void testWrite() {
		service.write(new Reply("content", "id", 8L));
		System.out.println(service.list(8L));
	}
	
	// 댓글 목록
	public static void testList() {
		service.list(8L).forEach(System.out::println);
	}

	// 댓글 삭제
	public static void testRemove() {
		service.remove(1L);
		System.out.println(service.list(8L));
	}

	// 게시글 삭제 시 해당 댓글 삭제
	public static void testRemoveReplies() {
		System.out.println(service.list(8L));
		service.removeReplies(8L);
		System.out.println(service.list(8L));
	}
	
	// 탈퇴회원의 댓글 id 수정
	public static void testModifyId() {
		service.modifyId("id");
		System.out.println(service.list(8L));
	}
}
