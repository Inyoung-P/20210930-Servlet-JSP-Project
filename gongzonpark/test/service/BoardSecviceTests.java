package service;

import vo.Criteria;

public class BoardSecviceTests {
	
	static BoardSecvice service = new BoardSecviceImpl() ;

	public static void main(String[] args) {
		
		// 글 조회
		testRead();
		
		// 글 목록 (페이지 포함)
		testList();
		
		// 게시글 총 갯수
		testGetCount();

		// 첨부파일 원본명 조회
		testFindOriginBy();
		
		// 첨부파일 삭제를 위한 날짜별 목록 조회
		testReadAttachByPath();
		
		// 게시글의 첨부파일 전체 삭제 (글 삭제 시)
		testRemoveAttachs();

		// 첨부파일 개별 삭제 (글 수정 시)
		testRemoveAttach();
		
		// 게시글의 작성자 찾기
		testFindWriterBy(); 
	}
	
	// 글 조회
	public static void testRead() {
		System.out.println(service.read(3L));
	}
	
	// 글 목록 (페이지 포함)
	public static void testList() {
		service.list(new Criteria(1, 10, 1)).forEach(System.out::println);
	}
	
	// 게시글 총 갯수
	public static void testGetCount() {
		System.out.println(service.getCount(new Criteria(1, 10)));
	}
	
	// 첨부파일 원본명 조회
	public static void testFindOriginBy() {
		System.out.println(service.findOriginBy("8714794f-094e-4578-9c18-76dd818e08df.jpg"));
	}
	
	// 첨부파일 삭제를 위한 날짜별 목록 조회
	public static void testReadAttachByPath() {
		System.out.println(service.readAttachByPath("210928"));
	}
	
	// 게시글의 첨부파일 전체 삭제 (글 삭제 시)
	public static void testRemoveAttachs() {
		service.removeAttachs(4L);
	}
	
	// 첨부파일 개별 삭제 (글 수정 시)
	public static void testRemoveAttach() {
		service.removeAttach("8714794f-094e-4578-9c18-76dd818e08df.jpg");
	}
	
	// 게시글의 작성자 찾기
	public static void testFindWriterBy() {
		System.out.println(service.findWriterBy(14L));
	}
}
