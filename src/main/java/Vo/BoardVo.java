package Vo;

public class BoardVo {
	
	private int boardId;
	private String boardTitle;
	private String boardContent;
	private String writer;
	private String pw;
	private int view;
	private String categorys;
	private String regdate;
	private String rewriteDate;
	private boolean filesCheck;
	
	
	
	

	public BoardVo() {
		
	}

	public BoardVo(int boardId, String boardTitle, String boardContent, String writer, String pw, int view,
			String categorys, String regdate, String rewriteDate) {
		super();
		this.boardId = boardId;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.writer = writer;
		this.pw = pw;
		this.view = view;
		this.categorys = categorys;
		this.regdate = regdate;
		this.rewriteDate = rewriteDate;
	}
	
	public int getBoardId() {
		return boardId;
	}
	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public int getView() {
		return view;
	}
	public void setView(int view) {
		this.view = view;
	}
	public String getCategory() {
		return categorys;
	}
	public void setCategory(String categorys) {
		this.categorys = categorys;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getRewriteDate() {
		return rewriteDate;
	}
	public void setRewriteDage(String rewriteDate) {
		this.rewriteDate = rewriteDate;
	}
	public boolean isFilesCheck() {
		return filesCheck;
	}

	public void setFilesCheck(boolean filesCheck) {
		this.filesCheck = filesCheck;
	}
	@Override
	public String toString() {
		return "boardVo [boardId=" + boardId + ", boardTitle=" + boardTitle + ", boardContent=" + boardContent
				+ ", writer=" + writer + ", pw=" + pw + ", view=" + view + ", categorys=" + categorys + ", regdate="
				+ regdate + ", rewriteDate=" + rewriteDate + "]";
	}

}
