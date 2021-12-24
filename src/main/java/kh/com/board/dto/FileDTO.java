package kh.com.board.dto;

public class FileDTO {

	private int seq_file;
	private int seq_board;
	private String origin_name;
	private String system_name;
	
	public FileDTO() {}

	public FileDTO(int seq_file, int seq_board, String origin_name, String system_name) {
		super();
		this.seq_file = seq_file;
		this.seq_board = seq_board;
		this.origin_name = origin_name;
		this.system_name = system_name;
	}

	public int getSeq_file() {
		return seq_file;
	}

	public void setSeq_file(int seq_file) {
		this.seq_file = seq_file;
	}

	public int getSeq_board() {
		return seq_board;
	}

	public void setSeq_board(int seq_board) {
		this.seq_board = seq_board;
	}

	public String getOrigin_name() {
		return origin_name;
	}

	public void setOrigin_name(String origin_name) {
		this.origin_name = origin_name;
	}

	public String getSystem_name() {
		return system_name;
	}

	public void setSystem_name(String system_name) {
		this.system_name = system_name;
	}
	
	
}
