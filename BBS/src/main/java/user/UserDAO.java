package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

// UserDAO //
public class UserDAO {
	private Connection 			conn;
	private PreparedStatement 	pstmt;
	private ResultSet 			rs;
	
	// �⺻�����ڿ��� �ʱ�ȭ
	public UserDAO() {
		try {
			String dbURL 		= "jdbc:mysql://localhost:3305/BBS?serverTimezone=UTC";
			String dbID 		= "root";
			String dbPassword 	= "1234";
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
	} // End - UserDAO
	
	
	// login //
	public int login(String userID, String userPassword) {
		//System.out.println("userID = " + userID + ", userPassword = " + userPassword);
		
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs 	  = pstmt.executeQuery();
			
			//���̵� �ִ� ���
			if(rs.next()) {
				//��й�ȣ ��ġ(�α��� ����)
				if(rs.getString(1).equals(userPassword)) {
					return 1; 
					
				//��й�ȣ ����ġ
				} else {
					return 0; 
				}
			}
			
			//���̵� ����
			return -1;
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		//�����ͺ��̽� ����
		return -2;
		
	} // End - login
	
	
	// join //
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUE(?, ?, ?, ?, ?)";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		// �̹� �����ϴ� ���̵�
		return -1;
		
	} // End - join
	
	
} // End - UserDAO