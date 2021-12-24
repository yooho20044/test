package kh.com.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

import kh.com.board.dto.FileDTO;

public class FileDAO {

	private BasicDataSource bds = new BasicDataSource();
	private static FileDAO instance = null;
	
	private FileDAO() {
		String className = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String username = "board_manager";
		String password = "manager";
		
		bds.setDriverClassName(className);
		bds.setUrl(url);
		bds.setUsername(username);
		bds.setPassword(password);
		bds.setInitialSize(30);
	}
	public static FileDAO getInstance() {
		if(instance == null) {
			instance = new FileDAO();
		}
		return instance;
	}
	public Connection getConnection() throws Exception{
		return bds.getConnection();
	}
	
	public int insertFile(FileDTO dto) {
		String sql = "insert into tbl_file values(seq_file.nextval,?,?,?)";
		
		try(Connection con = this.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);){
			
			pstmt.setInt(1, dto.getSeq_board());
			pstmt.setString(2, dto.getOrigin_name());
			pstmt.setString(3, dto.getSystem_name());
			
			int rs = pstmt.executeUpdate();
			
			if(rs != 0) {
				return rs;
			}
		}catch(Exception e){
			e.printStackTrace();
		}return -1;
	}
}
