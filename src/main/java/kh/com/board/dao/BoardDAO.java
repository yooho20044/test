package kh.com.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.SqlSessionConfig;
import kh.com.board.dto.BoardDTO;

public class BoardDAO {

	private static BoardDAO boardDAO;
	private BoardDAO() {}
	
	public static BoardDAO getInstance() {
		if(boardDAO == null) {
			boardDAO = new BoardDAO();
		}
		return boardDAO;
	}
	
	public int insert(BoardDTO dto) {
		try(SqlSession session = SqlSessionConfig.getSqlSession()){
			return session.insert("boardMapper.insert",dto);
		}
		}
	public List<BoardDTO> selectAll(){
		try(SqlSession session = SqlSessionConfig.getSqlSession()){
			return session.selectList("boardMapper.insert");
		}
	}
	
	public BoardDTO selectBySeq(int seq) {
		try(SqlSession session = SqlSessionConfig.getSqlSession()){
			return session.selectOne("boardMapper.selectBySeq", seq);
		}
	}
	
	public int deleteBySeq(int seq) {
		try(SqlSession session = SqlSessionConfig.getSqlSession()){
			return session.delete("boardMapper.deleteBySeq", seq);
		}
	}
	public int modifyBySeq(int seq, String title, String content) {
		try(SqlSession session = SqlSessionConfig.getSqlSession()){
			Map<String,Object> map = new HashMap<>();
			map.put("seq", seq);
			map.put("title", title);
			map.put("content", content);
			return session.update("boardMapper.modifyBySeq",map);
		}
	}
	
	public int updateView_count(int seq) {
		try(SqlSession session = SqlSessionConfig.getSqlSession()){
			return session.update("boardMapper.updateView_count", seq);
		}
	}
	
	public List<BoardDTO> getBoardList(int startRange, int endRange){
		try(SqlSession session = SqlSessionConfig.getSqlSession();){
			Map<String,Object> map = new HashMap<>();
			map.put("startRange", startRange);
			map.put("endRange", endRange);
			return session.selectList("boardMapper.getBoardList",map);
		}
	}
	public int countAll() {
		try(SqlSession session = SqlSessionConfig.getSqlSession()){
			return session.selectOne("boardMapper.countAll");
		}
	}
	public int selectSeq(String title, String content) {
		try(SqlSession session = SqlSessionConfig.getSqlSession()){
			Map<String,String> map = new HashMap<>();
			map.put("title", title);
			map.put("content", content);
			return session.selectOne("boardMapper.selectSeq",map);
		}
	}

}
