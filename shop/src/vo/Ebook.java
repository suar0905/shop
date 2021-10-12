package vo;

public class Ebook {
	// 정보은닉(private)
	private int ebookNo;
	private String ebookISBN;
	private String categoryName;
	private String ebookTitle;
	private String ebookAuthor;
	private String ebookCompany;
	private int ebookPageCount;
	private int ebookPrice;
	private String ebookImg;
	private String ebookSummary;
	private String ebookState;
	private String createDate;
	private String updateDate;
   
    // 캡슐화(메소드 분리)
	public int getEbookNo() {
		return ebookNo;
	}
	public void setEbookNo(int ebookNo) {
		this.ebookNo = ebookNo;
	}
	
	public String getEbookISBN() {
		return ebookISBN;
	}
	public void setEbookISBN(String ebookISBN) {
		this.ebookISBN = ebookISBN;
	}
	
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
	public String getEbookTitle() {
		return ebookTitle;
	}
	public void setEbookTitle(String ebookTitle) {
		this.ebookTitle = ebookTitle;
	}
	
	public String getEbookAuthor() {
		return ebookAuthor;
	}
	public void setEbookAuthor(String ebookAuthor) {
		this.ebookAuthor = ebookAuthor;
	}
	
	public String getEbookCompany() {
		return ebookCompany;
	}
	public void setEbookCompany(String ebookCompany) {
		this.ebookCompany = ebookCompany;
	}
	
	public int getEbookPageCount() {
		return ebookPageCount;
	}
	public void setEbookPageCount(int ebookPageCount) {
		this.ebookPageCount = ebookPageCount;
	}
	
	public int getEbookPrice() {
		return ebookPrice;
	}
	public void setEbookPrice(int ebookPrice) {
		this.ebookPrice = ebookPrice;
	}
	
	public String getEbookImg() {
		return ebookImg;
	}
	public void setEbookImg(String ebookImg) {
		this.ebookImg = ebookImg;
	}
	
	public String getEbookSummary() {
		return ebookSummary;
	}
	public void setEbookSummary(String ebookSummary) {
		this.ebookSummary = ebookSummary;
	}
	
	public String getEbookState() {
		return ebookState;
	}
	public void setEbookState(String ebookState) {
		this.ebookState = ebookState;
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
		return "Ebook [ebookNo=" + ebookNo + ", ebookISBN=" + ebookISBN + ", categoryName=" + categoryName
				+ ", ebookTitle=" + ebookTitle + ", ebookAuthor=" + ebookAuthor + ", ebookCompany=" + ebookCompany
				+ ", ebookPageCount=" + ebookPageCount + ", ebookPrice=" + ebookPrice + ", ebookImg=" + ebookImg
				+ ", ebookSummary=" + ebookSummary + ", ebookState=" + ebookState + ", createDate=" + createDate
				+ ", updateDate=" + updateDate + "]";
	}
}
