package vo;

public class Category {
	// 정보은닉(private)
	private String categoryName;
	private String updateDate;
	private String createDate;
	private String categoryState;
	
	// 캡슐화 과정
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	public String getCategoryState() {
		return categoryState;
	}
	public void setCategoryState(String categoryState) {
		this.categoryState = categoryState;
	}
	
	@Override
	public String toString() {
		return "Category [categoryName=" + categoryName + ", updateDate=" + updateDate + ", createDate=" + createDate
				+ ", categoryState=" + categoryState + "]";
	}
}
