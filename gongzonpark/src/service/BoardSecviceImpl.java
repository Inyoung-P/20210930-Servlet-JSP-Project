package service;

import java.util.List;

import dao.BoardDao;
import vo.Attach;
import vo.Board;
import vo.Criteria;

public class BoardSecviceImpl implements BoardSecvice {

	private BoardDao dao = new BoardDao();

	// 글쓰기
	@Override
	public Long write(Board board) {
		Long bno = dao.insert(board);
		for(Attach attach : board.getAttachs()) {
			attach.setBno(bno);
			dao.writeAttach(attach);
		}
		return bno;
	}

	// 글조회
	@Override
	public Board read(Long bno) {
		Board board = dao.read(bno);
		board.setAttachs(dao.readAttach(bno));
		return board;
	}

	// 글목록(페이지 포함)
	@Override
	public List<Board> list(Criteria cri) {
		List<Board> list = dao.list(cri);
		list.forEach(b -> b.setAttachs(dao.readAttach(b.getBno())));
		return list;
	}

	// 글수정
	@Override
	public void modify(Board board) {
		dao.update(board);
		for(Attach attach : board.getAttachs()) {
			attach.setBno(board.getBno());
			dao.writeAttach(attach);
		}
	}

	// 글삭제
	@Override
	public void remove(Long bno) {
		dao.delete(bno);
	}

	// 게시글 총 갯수
	@Override
	public int getCount(Criteria cri) {
		return dao.getCount(cri);
	}
	
	// 첨부파일 원본명 조회
	@Override
	public String findOriginBy(String uuid) {
		return dao.findOriginBy(uuid);
	}

	// 첨부파일 삭제를 위한 날짜별 목록 조회
	@Override
	public List<Attach> readAttachByPath(String path) {
		return dao.readAttachByPath(path);
	}
	// 게시글의 첨부파일 전체 삭제 (글 삭제 시)
	@Override
	public void removeAttachs(Long bno) {
		dao.deleteAttachs(bno);
	}
	
	// 첨부파일 개별 삭제 (글 수정 시)
	@Override
	public void removeAttach(String uuid) {
		dao.deleteAttach(uuid);
	}

	// 탈퇴회원의 게시글 id 수정
	public void modifyId(String id) {
		dao.updateId(id);
		
	}

	// 게시글의 작성자 찾기
	public String findWriterBy(Long bno) {
		return dao.findWriterBy(bno);
	}

}
