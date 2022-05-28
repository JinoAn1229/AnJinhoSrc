package Vo;

public class FilesVo {
	
	private int boardId;
	private int filesId;
	private String filesName;
	private String filesRealname;
	private String filesPath;
	
	public FilesVo() {
		
	}
	
	public FilesVo(int boardId, int filesId, String filesName, String filesRealname, String filesPath) {
		super();
		this.boardId = boardId;
		this.filesId = filesId;
		this.filesName = filesName;
		this.filesRealname = filesRealname;
		this.filesPath = filesPath;
	}

	public int getBoardId() {
		return boardId;
	}

	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}

	public int getFilesId() {
		return filesId;
	}

	public void setFilesId(int filesId) {
		this.filesId = filesId;
	}

	public String getFilesName() {
		return filesName;
	}

	public void setFilesName(String filesName) {
		this.filesName = filesName;
	}

	public String getFilesRealname() {
		return filesRealname;
	}

	public void setFilesRealname(String filesRealname) {
		this.filesRealname = filesRealname;
	}

	public String getFilesPath() {
		return filesPath;
	}

	public void setFilesPath(String filesPath) {
		this.filesPath = filesPath;
	}

	@Override
	public String toString() {
		return "FilesVo [boardId=" + boardId + ", filesId=" + filesId + ", filesName=" + filesName + ", filesRealname="
				+ filesRealname + ", filesPath=" + filesPath + "]";
	}
	
	

	
}
