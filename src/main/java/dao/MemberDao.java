package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Member;

public class MemberDao {
	Connection getConnection() {
		Connection con = null;
		String url = "jdbc:oracle:thin:@//localhost:1521/xe";
		String userid = "JSP_BOARD";
		String userpw = "1234";
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			con = DriverManager.getConnection(url, userid, userpw);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;
	}

	public Member selectMemberInfo(String checkId) {
		System.out.println("dao - selectMemberInfo() 호출");
		Connection con = getConnection();
		if(con == null) {
			return new Member();
		}
		//2. 쿼리문 실행
		
		String sql = "SELECT * FROM MEMBERS WHERE MID=?";
		Member member = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, checkId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				member = new Member();
				member.setMid(rs.getString("MID"));
				member.setMpw(rs.getString("MPW"));
				member.setMname(rs.getString("MNAME"));
				member.setMbirth(rs.getString("MBIRTH"));
				member.setMaddr(rs.getString("MADDR"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return member;
	}

	public int insertMemberInfo(Member joinMember) {
		System.out.println("dao - insertMemberInfo() 호출");
		Connection con = getConnection();
		if(con == null) {
			return 0;
		}
		String sql = "INSERT INTO MEMBERS(MID,MPW,MNAME,MBIRTH,MADDR)"
				+ " VALUES (?,?,?,?,?)";
		int result=0;
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1,joinMember.getMid());
			pstmt.setString(2,joinMember.getMpw());
			pstmt.setString(3,joinMember.getMname());
			pstmt.setString(4,joinMember.getMbirth());
			pstmt.setString(5,joinMember.getMaddr());
			result=pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}

	public Member LoginCheckInfo(String LoginId,String LoginPw) {
		System.out.println("dao - LoginCheckInfo() 호출");
		Connection con = getConnection();
		if(con == null) {
			return new Member();
		}
		String sql = "SELECT * FROM MEMBERS WHERE MID = ? AND MPW = ?";
		Member member = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, LoginId);
			pstmt.setString(2, LoginPw);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				member = new Member();
				member.setMid(rs.getString("MID"));
				member.setMpw(rs.getString("MPW"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return member;
	}

	
	public Member LoginMemberInfo(String infoId) {
		System.out.println("dao - LoginMemberInfo()호츨");
		Connection con = getConnection();
		if(con == null) {
			return new Member();
		}
		String sql = "SELECT * FROM MEMBERS WHERE MID = ?";
		Member member = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, infoId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				member = new Member();
				member.setMid(rs.getString("MID"));
				member.setMpw(rs.getString("MPW"));
				member.setMname(rs.getString("MNAME"));
				member.setMbirth(rs.getString("MBIRTH"));
				member.setMaddr(rs.getString("MADDR"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return member;
	}

}
