package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import commons.ConnUtil;
import vo.OrderComment;

public class OrderCommentDao {
	
	// (1) [회원 및 관리자] 전자책 주문 상품 후기 작성 코드
	public int insertOrderEbookComment(OrderComment orderComment) throws ClassNotFoundException, SQLException {
		// insertOrderEbookComment메소드의 orderNo 입력값 확인
		System.out.println("[debug] orderNo param 확인 -> " + orderComment.getOrderNo());
		// insertOrderEbookComment메소드의 ebookNo 입력값 확인
		System.out.println("[debug] ebookNo param 확인 -> " + orderComment.getEbookNo());
		// insertOrderEbookComment메소드의 orderScore 입력값 확인
		System.out.println("[debug] orderScore param 확인 -> " + orderComment.getOrderScore());
		// insertOrderEbookComment메소드의 orderCommentContent 입력값 확인
		System.out.println("[debug] orderCommentContent param 확인 -> " + orderComment.getOrderCommentContent());
		
		// maria db를 사용 및 접속하기 위해 commons 패키지의 ConnUtil클래스 사용
		ConnUtil connUtil = new ConnUtil();
		Connection conn = connUtil.getConnection();		
		System.out.println("[debug] conn 확인 -> + " + conn); // 디버깅 코드
		
		// 쿼리 생성
		// 쿼리문 :  
		String sql = "INSERT INTO order_comment(order_no, ebook_no, order_score, order_comment_content, create_date, update_date) values(?,?,?,?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, orderComment.getOrderNo());
		stmt.setInt(2, orderComment.getEbookNo());
		stmt.setInt(3, orderComment.getOrderScore());
		stmt.setString(4, orderComment.getOrderCommentContent());
		System.out.println("[debug] stmt 확인 - > " + stmt);
		
		// 쿼리 실행
		int insertRs = stmt.executeUpdate();
		
		// 기록 종료
		stmt.close();
		conn.close();
		
		return insertRs;
	}
}
