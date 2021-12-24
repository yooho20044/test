package kh.com.board.dto;

import java.sql.Date;

public class CommentDTO {

	private int seq_comment;
	private int seq_board;
	private String content;
	private String writer;
	private String writer_id;
	private Date written_date;
	
	CommentDTO(){}


	public CommentDTO(int seq_comment, int seq_board, String content, String writer, String writer_id,
			Date written_date) {
		super();
		this.seq_comment = seq_comment;
		this.seq_board = seq_board;
		this.content = content;
		this.writer = writer;
		this.writer_id = writer_id;
		this.written_date = written_date;
	}


	public int getSeq_comment() {
		return seq_comment;
	}


	public void setSeq_comment(int seq_comment) {
		this.seq_comment = seq_comment;
	}


	public int getSeq_board() {
		return seq_board;
	}


	public void setSeq_board(int seq_board) {
		this.seq_board = seq_board;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getWriter() {
		return writer;
	}


	public void setWriter(String writer) {
		this.writer = writer;
	}


	public String getWriter_id() {
		return writer_id;
	}


	public void setWriter_id(String writer_id) {
		this.writer_id = writer_id;
	}


	public Date getWritten_date() {
		return written_date;
	}


	public void setWritten_date(Date written_date) {
		this.written_date = written_date;
	}	
	
	
}
