package service;

import java.util.List;

import vo.Attach;
import vo.Board;
import vo.Criteria;

public interface BoardSecvice {

	// 글쓰기
	Long write(Board board);

	// 글조회
	Board read(Long bno);
	
	// 글목록(페이지 포함)
	List<Board> list(Criteria cri);
	
	// 글수정
	void modify(Board board);
	
	// 글삭제
	void remove(Long bno);
	
	// 게시글 총 갯수
	int getCount(Criteria cri);

	// 첨부파일 원본명 조회
	String findOriginBy(String uuid);
	
	// 첨부파일 패쓰명 조회
	List<Attach> readAttachByPath(String path);
	
	// 첨부파일 삭제
	void removeAttachs(Long bno);
	
	// 첨부파일 개별 삭제
	void removeAttach(String uuid);	
	
	// 탈퇴회원의 게시글 id 수정
	void modifyId(String id);
	
	// 게시글의 작성자 찾기
	String findWriterBy(Long bno);
	
}
