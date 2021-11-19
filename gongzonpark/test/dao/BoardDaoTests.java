package dao;

import vo.Attach;
import vo.Board;
import vo.Criteria;

public class BoardDaoTests {
	
	static BoardDao dao = new BoardDao();
	
	public static void main(String[] args) {
		
		// 글쓰기
		testInsert();
		
		// 글조회
		testRead();
		
		// 글목록(페이지 포함)
		testList();
		
		// 글수정
		testUpdate();
		
		// 글삭제
		testDelete();
		
		// 게시글 총 갯수
		testGetCount();

		// 첨부파일 작성
		testWriteAttach();
		
		// 첨부파일 불러오기
		testReadAttach();
		
		// 첨부파일 원본명 조회
		testFindOriginBy();
		
		// 첨부파일 패쓰명 조회
		testReadAttachByPath();
		
		// 첨부파일 삭제
		testDeleteAttachs();
		
		// 첨부파일 개별 삭제
		testDeleteAttach();
		
		// 게시글의 작성자 찾기
		testFindWriterBy();
	}
	
	// 글쓰기
	public static void testInsert() {
		dao.insert(new Board("title", "content", "id", 1L));
	}

	// 글조회
	public static void testRead() {
		System.out.println(dao.read(12L));
	}
	
	// 글목록(페이지 포함)
	public static void testList() {
		dao.list(new Criteria(1,20,1)).forEach(System.out::println);
	}
	
	// 글수정
	public static void testUpdate() {
		dao.update(new Board(12L, "title2", "content2"));
		System.out.println(dao.read(12L));
	}
	
	// 글삭제
	public static void testDelete() {
		dao.delete(12L);
		System.out.println(dao.read(12L));
	}
	
	// 게시글 총 갯수
	public static void testGetCount() {
		System.out.println(dao.getCount(new Criteria()));
	}

	// 첨부파일 작성
	public static void testWriteAttach() {
		System.out.println(dao.read(12L));
		dao.writeAttach(new Attach("uuid", "origin", 12L,"210928"));
		System.out.println(dao.read(12L));
	}
	
	// 첨부파일 불러오기
	public static void testReadAttach() {
		dao.readAttach(12L).forEach(System.out::println);
	}	
	
	// 첨부파일 원본명 조회
	public static void testFindOriginBy() {
		System.out.println(dao.findOriginBy("uuid"));
	}
	
	// 첨부파일 패쓰명 조회
	public static void testReadAttachByPath() {
		dao.readAttachByPath("210928").forEach(System.out::println);
	}
	
	// 첨부파일 삭제
	public static void testDeleteAttachs() {
		System.out.println(dao.read(12L));
		dao.deleteAttachs(12L);
		System.out.println(dao.read(12L));
	}
	
	// 첨부파일 개별 삭제
	public static void testDeleteAttach() {
		System.out.println(dao.read(12L));
		dao.deleteAttach("uuid");
		System.out.println(dao.read(12L));
	}	
	
	// 탈퇴회원의 게시글 id 수정
	public static void testUpdateId() {
		System.out.println(dao.read(12L));
		dao.updateId("id");
		System.out.println(dao.read(12L));
	}
	
	// 게시글의 작성자 찾기
	public  static void testFindWriterBy() {
		System.out.println(dao.findWriterBy(14L));
	}
	
}
