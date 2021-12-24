package kh.com.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import config.SqlSessionConfig;
import kh.com.board.dto.CommentDTO;

public class CommentDAO {
	
	private static CommentDAO commentDAO;
	private CommentDAO() {}
	
	
	
	public static CommentDAO getInstance() {
		if(commentDAO == null) {
			commentDAO = new CommentDAO();
		}
		return commentDAO;
	}

	
	public int insert(CommentDTO dto) {
		try(SqlSession session = SqlSessionConfig.getSqlSession()){
			return session.insert("commentMapper.insert",dto);
		}
	}
	
	public List<CommentDTO> getCommentList(int seq_board){
		try(SqlSession session = SqlSessionConfig.getSqlSession()){
			return session.selectList("commentMapper.getCommentList",seq_board);
		}
	}
	public int deleteBySeq(int seq_comment) {
		try(SqlSession session = SqlSessionConfig.getSqlSession()){
			return session.delete("commentMapper.deleteBySeq",seq_comment);
		}
	}
	public int modifyBySeq(int seq_comment, String content) {
		try(SqlSession session = SqlSessionConfig.getSqlSession()){
			Map<String,Object> map = new HashMap<>();
			map.put("seq_comment", seq_comment);
			map.put("content", content);
			return session.update("commentMapper.modifyBySeq",map);
		}
	}
	
}
