package vo;

public class Order {
	// 정보은닉(private)
	private int orderNo;
	private int ebookNo; // == Ebook ebook으로 대체가능
	private int memberNo; // == Member member으로 대체가능
	private int orderPrice;
	private String crateDate;
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
	
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	
	public int getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(int orderPrice) {
		this.orderPrice = orderPrice;
	}
	
	public String getCrateDate() {
		return crateDate;
	}
	public void setCrateDate(String crateDate) {
		this.crateDate = crateDate;
	}
	
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	
	@Override
	public String toString() {
		return "Order [orderNo=" + orderNo + ", ebookNo=" + ebookNo + ", memberNo=" + memberNo + ", orderPrice="
				+ orderPrice + ", crateDate=" + crateDate + ", updateDate=" + updateDate + "]";
	}
	
}
