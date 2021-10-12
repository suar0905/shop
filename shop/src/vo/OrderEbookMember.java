package vo;

public class OrderEbookMember {
	// Order, Ebook, Member JOIN한 것
	// 정보은닉(private)
	private Order order;
	private Ebook ebook;
	private Member member;
	
	// 캡슐화(메소드 분리)
	public Order getOrder() {
		return order;
	}
	public void setOrder(Order order) {
		this.order = order;
	}
	
	public Ebook getEbook() {
		return ebook;
	}
	public void setEbook(Ebook ebook) {
		this.ebook = ebook;
	}
	
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	
	@Override
	public String toString() {
		return "OrderEbookMember [order=" + order + ", ebook=" + ebook + ", member=" + member + "]";
	}
}
