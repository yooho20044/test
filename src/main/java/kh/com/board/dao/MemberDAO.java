package kh.com.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.SqlSessionConfig;
import kh.com.board.dto.MemberDTO;

public class MemberDAO {

	private static MemberDAO memberDAO;
	private MemberDAO() {}
	
	
	
	public static MemberDAO getInstance() {
		if(memberDAO == null) {
			memberDAO = new MemberDAO();
		}
		return memberDAO;
	}
	
	
	//아이디 중복 확인
	public boolean checkId(String id) {
		try(SqlSession session = SqlSessionConfig.getSqlSession()){
			return session.selectOne("memberMapper.checkId",id);
		}
	}
	//회원정보 삽입
	public int insert(MemberDTO dto) {
		try(SqlSession session = SqlSessionConfig.getSqlSession()){
			return session.insert("memberMapper.insertMember",dto);
		}
	}
	//로그인 
	public MemberDTO isLoginOK(String id, String pw){
		try(SqlSession session = SqlSessionConfig.getSqlSession()){
			Map<String,String> map = new HashMap<>();
			map.put("id", id);
			map.put("pw", pw);
			return session.selectOne("memberMapper.isLoginOK",map);
		}
	}
	//회원정보삭제
	public int deleteById(String id) {
		try(SqlSession session = SqlSessionConfig.getSqlSession()){
			return session.delete("memberMapper.deleteById",id);
		}
	}
	//회원정보조회
	public MemberDTO selectById(String id) {
		try(SqlSession session = SqlSessionConfig.getSqlSession()){
			return session.selectOne("memberMapper.selectById",id);
		}
	}
	//회원정보수정
	public int modifyById(MemberDTO dto) {
		try(SqlSession session = SqlSessionConfig.getSqlSession()){
			return session.update("memberMapper.modifyById",dto);
		}
	}
}
