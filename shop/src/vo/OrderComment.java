package vo;

public class OrderComment {
	// 정보은닉(private)
	private int orderNo;
	private int ebookNo;
	private int orderScore;
	private String orderCommentContent;
	private String createDate;
	private String updateDate;
	
	// 캡슐화(메소드 분리)
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	
	public int getEbookNo() {
		return ebookNo;
	}
	public void setEbookNo(int ebookNo) {
		this.ebookNo = ebookNo;
	}
	
	public int getOrderScore() {
		return orderScore;
	}
	public void setOrderScore(int orderScore) {
		this.orderScore = orderScore;
	}
	
	public String getOrderCommentContent() {
		return orderCommentContent;
	}
	public void setOrderCommentContent(String orderCommentContent) {
		this.orderCommentContent = orderCommentContent;
	}
	
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	
	@Override
	public String toString() {
		return "OrderComment [orderNo=" + orderNo + ", ebookNo=" + ebookNo + ", orderScore=" + orderScore
				+ ", orderCommentContent=" + orderCommentContent + ", createDate=" + createDate + ", updateDate="
				+ updateDate + "]";
	}
}
