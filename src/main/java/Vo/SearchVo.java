package Vo;

public class SearchVo extends PageVo{

	private String keyword;
    private String condition;
    private String startDate;
    private String endDate;
    
    public SearchVo() {
    	
    }

    
	public SearchVo(String keyword, String condition, String startDate, String endDate) {
		super();
		this.keyword = keyword;
		this.condition = condition;
		this.startDate = startDate;
		this.endDate = endDate;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
    
	@Override
	public String toString() {
		return "SearchVo [keyword=" + keyword + ", condition=" + condition + ", startDate=" + startDate + ", endDate="
				+ endDate + "]";
	}
    
    
}
