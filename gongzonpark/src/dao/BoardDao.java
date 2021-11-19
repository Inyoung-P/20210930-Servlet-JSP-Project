package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import utill.DBConn;
import vo.Attach;
import vo.Board;
import vo.Criteria;

public class BoardDao {

	// 글쓰기
	public Long insert(Board board) {
		Connection conn = DBConn.getConnection();
		Long bno = null;
		try {
			ResultSet rs = conn.prepareStatement("SELECT SEQ_BOARD.NEXTVAL FROM DUAL").executeQuery();
			rs.next();
			bno = rs.getLong(1);
			
			PreparedStatement pstmt = conn.prepareStatement("INSERT INTO TBL_BOARD(BNO, TITLE, CONTENT, ID, CATEGORY) "
														  + "VALUES (?, ?, ?, ?, ?)");
			int idx = 1;
			
			pstmt.setLong(idx++, bno);
			pstmt.setString(idx++, board.getTitle());
			pstmt.setString(idx++, board.getContent());
			pstmt.setString(idx++, board.getId());
			pstmt.setLong(idx++, board.getCategory());
			
			pstmt.executeUpdate();
			conn.commit();
			conn.setAutoCommit(true);
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return bno;
	}

	// 글조회
	public Board read(Long bno) {
		Connection conn = DBConn.getConnection();
		Board board = null;
		try {
			PreparedStatement pstmt = conn.prepareStatement(
					"SELECT "
					+ "	BNO, "
					+ "	TITLE, "
					+ "	CONTENT, "
					+ "	TO_CHAR(REGDATE, 'YYYY.MM.DD HH24:MI') AS REGDATE, "
					+ "	ID, "
					+ "	CATEGORY, "
					+ "	(SELECT COUNT(*) FROM TBL_REPLY R WHERE R.BNO = B.BNO) REPLYCNT, "
					+ "	(SELECT NICKNAME FROM TBL_MEMBER M WHERE M.ID = B.ID) NICKNAME, "
					+ "	(SELECT UUID FROM TBL_MEMBER M WHERE M.ID = B.ID) PROFILEUUID "
					+ "FROM TBL_BOARD B "
					+ "WHERE BNO = ?");
			pstmt.setLong(1, bno);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				int idx = 1;
				board = new Board(
						rs.getLong(idx++),
						rs.getString(idx++),
						rs.getString(idx++),
						rs.getString(idx++),
						rs.getString(idx++),
						rs.getLong(idx++),
						rs.getInt(idx++),
						rs.getString(idx++),
						rs.getString(idx++)
				);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return board;
	}

	// 글목록(페이지 포함)
	public List<Board> list(Criteria cri) {
		Connection conn = DBConn.getConnection();
		List<Board> list = new ArrayList<>();
		try {
			StringBuilder sql = new StringBuilder();

			sql.append("WITH B AS (");
			sql.append("	SELECT /*+ INDEX_DESC(TB PK_BOARD) */");
			sql.append("		ROWNUM RN, TB.* ");
			sql.append("	FROM TBL_BOARD TB ");
			sql.append("	WHERE BNO > 0 ");
			sql.append("	AND CATEGORY = ? ");
			sql.append("	AND ROWNUM <= ? * ?) ");
			sql.append("SELECT ");
			sql.append("	BNO, ");
			sql.append("	TITLE, ");
			sql.append("	CONTENT, ");
			sql.append("	TO_CHAR(REGDATE, 'YYYY.MM.DD') AS REGDATE, ");
			sql.append("	ID, ");
			sql.append("	CATEGORY, ");
			sql.append("	(SELECT COUNT(*) FROM TBL_REPLY R WHERE R.BNO = B.BNO) REPLYCNT, ");
			sql.append("	(SELECT NICKNAME FROM TBL_MEMBER M WHERE M.ID = B.ID) NICKNAME, ");
			sql.append("	(SELECT UUID FROM TBL_MEMBER M WHERE M.ID = B.ID) PROFILEUUID ");
			sql.append("FROM B ");
			sql.append("WHERE RN > (?-1) * ?");
			
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
			int idx = 1;
			pstmt.setInt(idx++, cri.getCategory());
			pstmt.setInt(idx++, cri.getPageNum());
			pstmt.setInt(idx++, cri.getAmount());
			pstmt.setInt(idx++, cri.getPageNum());
			pstmt.setInt(idx++, cri.getAmount());
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				idx = 1;
				Long bno = rs.getLong(idx++);
				String title = rs.getString(idx++);
				String content = rs.getString(idx++);
				String regDate = rs.getString(idx++);
				String id = rs.getString(idx++);
				Long category = rs.getLong(idx++);
				Integer replyCnt = rs.getInt(idx++);
				String nickname = rs.getString(idx++);
				String profileUuid = rs.getString(idx++);
				
				Board board = new Board(bno, title, content, regDate, id, category, replyCnt, nickname, profileUuid);
				list.add(board);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 글수정
	public void update(Board board) {
		Connection conn = DBConn.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement("UPDATE TBL_BOARD SET " + 
															"	TITLE = ?, " + 
															"	CONTENT = ? " + 
															"WHERE BNO = ?");
			int idx = 1;
			pstmt.setString(idx++, board.getTitle());
			pstmt.setString(idx++, board.getContent());
			pstmt.setLong(idx++, board.getBno());
			
			pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 글 삭제
	public void delete(Long bno) {
		Connection conn = DBConn.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement("DELETE TBL_BOARD WHERE BNO = ?");
			pstmt.setLong(1, bno);
			pstmt.executeUpdate();
			conn.commit();
			conn.setAutoCommit(true);
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 게시글 총 갯수
	public int getCount(Criteria cri) {
		Connection conn = DBConn.getConnection();
		int count = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(
					"SELECT COUNT(*) FROM TBL_BOARD WHERE CATEGORY = ?");
			pstmt.setInt(1, cri.getCategory());
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}
	
	// 첨부파일 작성
	public void writeAttach(Attach attach) {
		Connection conn = DBConn.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement(
					"INSERT INTO TBL_ATTACH VALUES (?, ?, ?, ?)");
			int idx = 1;
			pstmt.setString(idx++, attach.getUuid());
			pstmt.setString(idx++, attach.getOrigin());
			pstmt.setLong(idx++, attach.getBno());
			pstmt.setString(idx++, attach.getPath());
			
			pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 첨부파일 불러오기
	public List<Attach> readAttach(Long bno) {
		Connection conn = DBConn.getConnection();
		List<Attach> list = new ArrayList<>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(
					"SELECT UUID, ORIGIN, PATH FROM TBL_ATTACH WHERE BNO = ?");
			pstmt.setLong(1, bno);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int idx = 1;
				String uuid = rs.getString(idx++);
				String origin = rs.getString(idx++);
				String path = rs.getString(idx++);
				
				Attach attach = new Attach(uuid, origin, bno, path);
				list.add(attach);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 첨부파일 원본명 조회 
	public String findOriginBy(String uuid) {
		Connection conn = DBConn.getConnection();
		String origin = null;
		try {
			PreparedStatement pstmt = conn.prepareStatement(
					"SELECT ORIGIN FROM TBL_ATTACH WHERE UUID = ?");
			pstmt.setString(1, uuid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				origin = rs.getString(1);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return origin;
	}	

	// 첨부파일 불러오기
	public List<Attach> readAttachByPath(String path) {
		Connection conn = DBConn.getConnection();
		List<Attach> list = new ArrayList<>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(
					"SELECT UUID, ORIGIN, PATH FROM TBL_ATTACH WHERE PATH = ?");
			pstmt.setString(1, path);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int idx = 1;
				String uuid = rs.getString(idx++);
				String origin = rs.getString(idx++);
				
				Attach attach = new Attach(uuid, origin, null, path);
				list.add(attach);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	// 첨부파일 삭제
	public void deleteAttachs(Long bno) {
		Connection conn = DBConn.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement("DELETE TBL_ATTACH WHERE BNO = ?");
			pstmt.setLong(1, bno);
			pstmt.executeUpdate();
			conn.commit();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 첨부파일 개별 삭제
	public void deleteAttach(String uuid) {
		Connection conn = DBConn.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement("DELETE TBL_ATTACH WHERE UUID = ?");
			pstmt.setString(1, uuid);
			pstmt.executeUpdate();
			conn.commit();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 탈퇴회원의 게시글 id 수정
	public void updateId(String id) {
		Connection conn = DBConn.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement("UPDATE TBL_BOARD SET ID = 'gongzonpark' WHERE ID = ?");
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 게시글의 작성자 찾기
	public String findWriterBy(Long bno) {
		Connection conn = DBConn.getConnection();
		String id = null;
		try {
			PreparedStatement pstmt = conn.prepareStatement("SELECT ID FROM TBL_BOARD WHERE BNO = ?");
			pstmt.setLong(1, bno);
			pstmt.executeUpdate();
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString(1);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return id;
	}
}
