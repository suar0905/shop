package vo;

public class QnaComment {
	// 정보은닉(private)
	private int qnaCommentNo;
	private int qnaNo;
	private String qnaCommentContent;
	private int memberNo;
	private String createDate;
	private String updateDate;
	
	// 캡슐화(메소드 분리)
	public int getQnaCommentNo() {
		return qnaCommentNo;
	}
	public void setQnaCommentNo(int qnaCommentNo) {
		this.qnaCommentNo = qnaCommentNo;
	}
	
	public int getQnaNo() {
		return qnaNo;
	}
	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}
	
	public String getQnaCommentContent() {
		return qnaCommentContent;
	}
	public void setQnaCommentContent(String qnaCommentContent) {
		this.qnaCommentContent = qnaCommentContent;
	}
	
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
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
		return "QnaComment [qnaCommentNo=" + qnaCommentNo + ", qnaNo=" + qnaNo + ", qnaCommentContent="
				+ qnaCommentContent + ", memberNo=" + memberNo + ", createDate=" + createDate + ", updateDate="
				+ updateDate + "]";
	}
}
