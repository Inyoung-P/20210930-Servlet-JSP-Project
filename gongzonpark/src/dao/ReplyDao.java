package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import utill.DBConn;
import vo.Reply;

public class ReplyDao {

	// 댓글 조회
	public List<Reply> list(Long bno) {
		Connection conn = DBConn.getConnection();
		List<Reply> list = new ArrayList<>();
		
		try {
			String sql = "SELECT RNO, CONTENT, TO_CHAR(REGDATE, 'YYYY.MM.DD HH24:MI') AS REGDATE, ID, NICKNAME, UUID " + 
						 "FROM TBL_REPLY " + 
						 "JOIN TBL_MEMBER " + 
						 "USING(ID) " + 
						 "WHERE RNO > 0 AND BNO = ? ORDER BY 1";			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1,  bno);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int idx = 1;
				Long rno = rs.getLong(idx++);
				String content = rs.getString(idx++);
				String regDate = rs.getString(idx++);
				String id = rs.getString(idx++);
				String nickname = rs.getString(idx++);
				String uuid = rs.getString(idx++);
				Reply reply = new Reply(rno, content, regDate, id, nickname, uuid, bno);
				list.add(reply);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	// 댓글 삭제
	public void delete(Long rno) {
		Connection conn = DBConn.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement("DELETE TBL_REPLY WHERE RNO = ?");
			pstmt.setLong(1, rno);
			
			pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	// 댓글들 삭제 - 게시글 삭제시
	public void deleteReplies(Long bno) {
		Connection conn = DBConn.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement("DELETE TBL_REPLY WHERE BNO = ?");
			pstmt.setLong(1, bno);
			pstmt.executeUpdate();
			conn.commit();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}	
	
	// 댓글 작성
	public void insert(Reply reply) {
		Connection conn = DBConn.getConnection();
		Long rno = null;
		try {
			ResultSet rs = conn.prepareStatement("SELECT SEQ_REPLY.NEXTVAL FROM DUAL").executeQuery();
			rs.next();
			rno = rs.getLong(1);
			PreparedStatement pstmt = conn.prepareStatement(
					"INSERT INTO TBL_REPLY(RNO, CONTENT, ID, BNO) " + 
					"VALUES(?, ?, ?, ?)");
			int idx = 1;
			pstmt.setLong(idx++, rno);
			pstmt.setString(idx++, reply.getContent());
			pstmt.setString(idx++, reply.getId());
			pstmt.setLong(idx++, reply.getBno());
			
			pstmt.executeUpdate();
			conn.commit();
			conn.setAutoCommit(true);
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 탈퇴회원의 댓글 id 수정
	public void updateId(String id) {
		Connection conn = DBConn.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement("UPDATE TBL_REPLY SET ID = 'gongzonpark' WHERE ID = ?");
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}
