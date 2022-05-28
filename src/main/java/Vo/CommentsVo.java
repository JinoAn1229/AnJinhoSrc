package Vo;

public class CommentsVo {

	private int boardId;
	private int commentsId;
	private String commentsContent;
	private String regdate;
	
	public CommentsVo() {
	
	}
	
	public CommentsVo(int boardId, int commentsId, String commentsContent, String regdate) {
		super();
		this.boardId = boardId;
		this.commentsId = commentsId;
		this.commentsContent = commentsContent;
		this.regdate = regdate;
	}
	public int getBoardId() {
		return boardId;
	}
	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}
	public int getCommentsId() {
		return commentsId;
	}
	public void setCommentsId(int commentsId) {
		this.commentsId = commentsId;
	}
	public String getCommentsContent() {
		return commentsContent;
	}
	public void setCommentsContent(String commentsContent) {
		this.commentsContent = commentsContent;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	@Override
	public String toString() {
		return "CommentsVo [boardId=" + boardId + ", commentsId=" + commentsId + ", commentsContent=" + commentsContent
				+ ", regdate=" + regdate + "]";
	}
	

	
}
