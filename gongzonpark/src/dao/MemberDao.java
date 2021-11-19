package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import utill.DBConn;
import vo.Member;

public class MemberDao {

	// 회원가입
	public void join(Member member) {
		Connection conn = DBConn.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement("INSERT INTO TBL_MEMBER VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
			int idx = 1;
			pstmt.setString(idx++, member.getId());
			pstmt.setString(idx++, member.getPwd());
			pstmt.setString(idx++, member.getEmail());
			pstmt.setString(idx++, member.getName());
			pstmt.setString(idx++, member.getNickname());
			pstmt.setString(idx++, member.getEmailHash());
			pstmt.setInt(idx++, 0);
			pstmt.setString(idx++, null);
			pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 이메일인증
	public void checkEmail(String hashcode) {
		Connection conn = DBConn.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement("UPDATE TBL_MEMBER SET EMAILCHECKED = 1 WHERE EMAILHASH = ?");
			pstmt.setString(1, hashcode);
			pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 로그인
	public boolean login(String id, String pwd) {
		Connection conn = DBConn.getConnection();
		boolean success = false;
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT ID, PWD, EMAIL, NAME, NICKNAME, EMAILHASH, EMAILCHECKED, UUID FROM TBL_MEMBER WHERE ID='"+id+"' AND PWD='"+pwd+"'");
			success = rs.next();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}

	// 회원찾기(id)
	public Member findMemberById(String id) {
		Connection conn = DBConn.getConnection();
		Member member = null;
		try {
			PreparedStatement pstmt = conn.prepareStatement("SELECT ID, PWD, EMAIL, NAME, NICKNAME, EMAILHASH, EMAILCHECKED, UUID FROM TBL_MEMBER WHERE ID=?");
			pstmt.setString(1, id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				int idx = 1;
				member = new Member(
						rs.getString(idx++),
						rs.getString(idx++),
						rs.getString(idx++),
						rs.getString(idx++),
						rs.getString(idx++),
						rs.getString(idx++),
						rs.getInt(idx++),
						rs.getString(idx++)
				);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return member;
	}
	
	// 회원찾기(email)
	public Member findMemberByEmail(String email) {
		Connection conn = DBConn.getConnection();
		Member member = null;
		try {
			PreparedStatement pstmt = conn.prepareStatement("SELECT ID, PWD, EMAIL, NAME, NICKNAME, EMAILHASH, EMAILCHECKED, UUID FROM TBL_MEMBER WHERE EMAIL=?");
			pstmt.setString(1, email);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				int idx = 1;
				member = new Member(
						rs.getString(idx++),
						rs.getString(idx++),
						rs.getString(idx++),
						rs.getString(idx++),
						rs.getString(idx++),
						rs.getString(idx++),
						rs.getInt(idx++),
						rs.getString(idx++)
				);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		return member;	
	}
	
	// 회원찾기(nickname)
	public Member findMemberByNickname(String nickname) {
		Connection conn = DBConn.getConnection();
		Member member = null;
		try {
			PreparedStatement pstmt = conn.prepareStatement("SELECT ID, PWD, EMAIL, NAME, NICKNAME, EMAILHASH, EMAILCHECKED, UUID FROM TBL_MEMBER WHERE NICKNAME=?");
			pstmt.setString(1, nickname);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				int idx = 1;
				member = new Member(
						rs.getString(idx++),
						rs.getString(idx++),
						rs.getString(idx++),
						rs.getString(idx++),
						rs.getString(idx++),
						rs.getString(idx++),
						rs.getInt(idx++),
						rs.getString(idx++)
				);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}		
		return member;	
	}
	
	// 비밀번호 수정
	public void updateMemberPwd(String id, String pwd) {
		Connection conn = DBConn.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement("UPDATE TBL_MEMBER SET PWD = ? WHERE ID = ?");
			pstmt.setString(1, pwd);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}	

	// 이메일 수정
	public void updateMemberEmail(String id, String email, String emailHash) {
		Connection conn = DBConn.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement("UPDATE TBL_MEMBER SET EMAIL = ?, EMAILHASH = ?, EMAILCHECKED = 0 WHERE ID = ?");
			pstmt.setString(1, email);
			pstmt.setString(2, emailHash);
			pstmt.setString(3, id);
			pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 별명 수정
	public void updateMemberNickname(String id, String nickname) {
		Connection conn = DBConn.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement("UPDATE TBL_MEMBER SET NICKNAME = ? WHERE ID = ?");
			pstmt.setString(1, nickname);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 별명 수정
	public void updateProfile(String id, String uuid) {
		Connection conn = DBConn.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement("UPDATE TBL_MEMBER SET UUID = ? WHERE ID = ?");
			pstmt.setString(1, uuid);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 회원탈퇴
	public void updateMember(String id) {
		Connection conn = DBConn.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement(
					"UPDATE TBL_MEMBER " + 
					"SET PWD = NULL, " + 
					"    EMAIL = NULL, " + 
					"    NAME = NULL, " + 
					"    NICKNAME = NULL, " + 
					"    EMAILHASH = NULL, " + 
					"    EMAILCHECKED = NULL, " + 
					"    UUID = NULL " + 
					"WHERE ID = ?");
			pstmt.setString(1, id);
			pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}
